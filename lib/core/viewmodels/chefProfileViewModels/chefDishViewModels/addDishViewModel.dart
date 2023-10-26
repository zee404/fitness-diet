import 'dart:io';
import 'package:fitness_diet/core/constants/route_paths.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/DatabaseServices/dbHelperFtns.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';
import 'dart:async';

import 'package:fitness_diet/core/models/API_MODELS/FoodCentralJSONModel.dart';
import 'package:http/http.dart' as http;

List<FoodInfo> _currentFoodIngr = [];

class AddDishViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

// ---------------------------------------- G E T   L I S T   R E L A T E D   T O   S E A R C H E D    F O O D
  Future<List<FoodInfo>> getSearchedMealsList(String searchedQuery) async {
    setState(ViewState.Busy);
    var client = http.Client();
    List<FoodInfo> searchedFoodsList;
    var apiKey = "vAK9vJMtSQdYxcBhYRxZl5cpEkahZEkBhl0iw0ox";
    var dataType = "Survey (FNDDS)";
    // var dataType = "Branded";

    int pageSize = 30;

    try {
      http.Response responce = await client.get(
          "https://api.nal.usda.gov/fdc/v1/foods/list?api_key=$apiKey&query=$searchedQuery&pageSize=$pageSize&dataType=$dataType");
      if (responce.statusCode == 200) {
        String jsonString = responce.body;
        // printWrapped(jsonString);
        searchedFoodsList = foodInfoFromJson(jsonString);
      }
    } catch (Exception) {
      print("E X C E P T I O N");
      print("Exception in APi in apimanager class: " + Exception.toString());
    }
    setState(ViewState.Idle);
    return searchedFoodsList;
  }

  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

// // ---------------------------------------- G E T   L I S T   O F   A L L   F O O D S   I T E M S
//   Future<List<FoodInfo>> getAllIngredientsList() async {
//     setState(ViewState.Busy);
//     print("---> Inside getAllIngredientsList in ViewModel");
//     var client = http.Client();
//     List<FoodInfo> allFoodsInfo;
//     var apiKey = "vAK9vJMtSQdYxcBhYRxZl5cpEkahZEkBhl0iw0ox";
//     var dataType = "Survey (FNDDS), Foundation";
//     // int pageSize = 100;

//     try {
//       http.Response responce = await client.get(
//           "https://api.nal.usda.gov/fdc/v1/foods/list?api_key=$apiKey&dataType=$dataType");
//       print("Inside API MANAGER");
//       if (responce.statusCode == 200) {
//         String jsonString = responce.body;

//         allFoodsInfo = foodInfoFromJson(jsonString);
//       }
//     } catch (Exception) {
//       print("E X C E P T I O N");
//       print("Exception in APi in apimanager class: " + Exception.toString());
//     }

//     setState(ViewState.Idle);
//     return allFoodsInfo;
//   }

// ---------------------------------------- S E T   /    G E T   I N G R E D I E N T S

  FutureOr setIngList(List<FoodInfo> _foodInfoList) {
    _currentFoodIngr = _foodInfoList;

    print(" ---> INSIDE setIngList and _currentFoodIngr = " +
        _currentFoodIngr.toString());
  }

  List<FoodInfo> get getCurrentFoodIngr {
    print(" ---> INSIDE getCurrentFoodIngr and  returning  = " +
        _currentFoodIngr.toString());
    return _currentFoodIngr;
  }

  List<double> convertNutrientsBackToOriginal(
      FoodInfo _singleFood, int _count) {
    // Indexes => Protien - 0, Fats - 1, Carbs - 2, Kcal - 3
    List<double> _convertedNutrients = [];
    _singleFood.foodNutrients[0].amount = double.parse(
        (_singleFood.foodNutrients[0].amount / _count).toStringAsFixed(2));
    _singleFood.foodNutrients[1].amount = double.parse(
        (_singleFood.foodNutrients[1].amount / _count).toStringAsFixed(2));
    _singleFood.foodNutrients[2].amount = double.parse(
        (_singleFood.foodNutrients[2].amount / _count).toStringAsFixed(2));
    _singleFood.foodNutrients[3].amount = double.parse(
        (_singleFood.foodNutrients[3].amount / _count).toStringAsFixed(2));
    _convertedNutrients.add(_singleFood.foodNutrients[0].amount);
    _convertedNutrients.add(_singleFood.foodNutrients[1].amount);
    _convertedNutrients.add(_singleFood.foodNutrients[2].amount);
    _convertedNutrients.add(_singleFood.foodNutrients[3].amount);
    print("--- Fat: " + _singleFood.foodNutrients[1].amount.toString());
    return _convertedNutrients;
  }
// ---------------------------------------- E D A M N A N   A P I

// ---------------------------------------- U P L O A D I N G    D I S H
  Future uploadDishInfo(
    String dishName,
    int dishPrice,
    int totalPrepTime,
    File dishPic,
    String dishCatg,
    String dishAttr,
    List<FoodInfo> _foodIngrList,
  ) async {
    setState(ViewState.Busy);
    print("--------> Upload dish Function reached.");

    if (Validators().verifyNameInputFeild(dishName) &&
        Validators().verifyNameInputFeild(dishCatg) &&
        Validators().verifyNumInputFeild(dishPrice) &&
        Validators().verifyNumInputFeild(totalPrepTime) &&
        _foodIngrList != null &&
        dishPic != null) {
      print("uploaded yahooooooo");
      String userId = getUser;
// ---------- Check if attribute name already exists then add accordingly
      if (dishAttr != null) {
        bool attrNameAlreadyExist = await DBHelperFtns().feildExistInCollection(
            DatabaseService().dishAttrCollection, 'attrID', dishAttr);
        if (attrNameAlreadyExist) await DatabaseService().addAttrData(dishAttr);
      }

// ---------- Converting attrName to ID
      String attrID = await DBHelperFtns().documentNameToID(
        DatabaseService().dishAttrCollection,
        "attrName",
        "attrID",
        dishAttr,
      );
// ---------- Converting ctgName to ID
      String ctgID = await DBHelperFtns().documentNameToID(
        DatabaseService().dishCtgCollection,
        "ctgName",
        "ctgID",
        dishCatg,
      );

      String _chefName = await DBHelperFtns().documentIDToName(
        DatabaseService().chefCollection,
        "chefID",
        "chefName",
        userId,
      );
      print(
          "---------> ChefID and extracted ChefName inside AddDishViewModel : " +
              userId.toString() +
              " " +
              _chefName);

      print("---------> attrID inside AddDishViewModel : " + attrID.toString());

      String _uploadedImgURL = await ConstantFtns().uploadFile(dishPic);
      print(" INSIDE UPLOAD DISH AND    N U T R I E N T S    ARE: " +
          _foodIngrList.toString());
      // print(" INSIDE UPLOAD DISH AND    N U T R I E N T S    ARE: " +
      //     _foodIngrList[0].foodNutrients[3].amount.toString() +
      //     " " +
      //     _foodIngrList[0].foodNutrients[1].amount.toString());

      List<double> _totalDishNutrientsList =
          getTotalDishNutrients(_foodIngrList);

      double _dishProtein =
          double.parse((_totalDishNutrientsList[0]).toStringAsFixed(2));
      double _dishFat =
          double.parse(_totalDishNutrientsList[1].toStringAsFixed(2));
      double _dishCarb =
          double.parse(_totalDishNutrientsList[2].toStringAsFixed(2));
      double _dishKcal =
          double.parse(_totalDishNutrientsList[3].toStringAsFixed(2));
      print("---------------" + _dishProtein.toString());
      // double _protein = double.parse(
      //     ConstantFtns().getStringBeforeCharacter(_dishProtein, " "));
      // double _fat =
      //     double.parse(ConstantFtns().getStringBeforeCharacter(_dishFat, " "));
      // double _carb =
      //     double.parse(ConstantFtns().getStringBeforeCharacter(_dishCarb, " "));
      // double _kcal =
      //     double.parse(ConstantFtns().getStringBeforeCharacter(_dishKcal, " "));

      // List<int> _dishIngredientsIDs;

      // for (int i = 0; i < _foodIngrList.length; i++) {
      //   _dishIngredientsIDs.add(_foodIngrList[i].fdcId);
      // }

      await DatabaseService().addNewDishData({
        'dishName': dishName,
        'dishCatg': dishCatg,
        'chefID': userId,
        'dishPrepTime': totalPrepTime,
        'dishPic': _uploadedImgURL.toString(),
        'dishPrice': dishPrice,
        'attrID': attrID,
        'chefName': _chefName,
        'ctgID': ctgID,
        'dishProtein': _dishProtein,
        'dishFat': _dishFat,
        'dishCarb': _dishCarb,
        'dishKcal': _dishKcal,
        'dishIngrIDs': getDishIngrIDs,
        // 'dishIngrList': _dishIngredientsIDs,
      });

      setState(ViewState.Idle);
      _navigationService.navigateTo(ChefProfileRoute);
    } else {
      setErrorMessage("Enter valid info");
      setState(ViewState.Idle);
    }
  }

  List<double> getTotalDishNutrients(List<FoodInfo> _foodIngrList) {
    double _totalKcal = 0;
    double _totalFats = 0;
    double _totalCarbs = 0;
    double _totalProtein = 0;
    // List<String> _nutrientData = [];
    List<double> _nutrientData = [];
    for (int i = 0; i < _foodIngrList.length; i++) {
      _totalProtein = _totalProtein + _foodIngrList[i].foodNutrients[0].amount;
      _totalFats = _totalFats + _foodIngrList[i].foodNutrients[1].amount;
      _totalCarbs = _totalCarbs + _foodIngrList[i].foodNutrients[2].amount;
      _totalKcal = _totalKcal + _foodIngrList[i].foodNutrients[3].amount;
      print("Total protein: " + _totalProtein.toString());
      print("Total _totalFats: " + _totalFats.toString());
      print("Total _totalKcal: " + _totalKcal.toString());
    }
    _nutrientData.add(_totalProtein);
    _nutrientData.add(_totalFats);
    _nutrientData.add(_totalCarbs);
    _nutrientData.add(_totalKcal);
    // _nutrientData.add(_totalProtein.toString() + " G");
    // _nutrientData.add(_totalFats.toString() + " G");
    // _nutrientData.add(_totalCarbs.toString() + " G");
    // _nutrientData.add(_totalKcal.toString() + " Kcal");
    return _nutrientData;
  }

  List<int> getDishIngrIDs(List<FoodInfo> _foodIngrList) {
    List<int> _dishIngrIDs = [];
    for (int i = 0; i < _foodIngrList.length; i++) {
      _dishIngrIDs.add(_foodIngrList[i].fdcId);
    }
  }
}
