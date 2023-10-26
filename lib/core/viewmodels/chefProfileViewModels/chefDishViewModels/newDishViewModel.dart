import 'dart:io';
import 'package:fitness_diet/core/constants/route_paths.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/models/API_MODELS/edamamJSONModel.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/DatabaseServices/dbHelperFtns.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

List<IngredientInfo> _newCurrentIngrList = [];

class NewAddDishViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  FutureOr setIngList(List<IngredientInfo> _foodInfoList) {
    _newCurrentIngrList = _foodInfoList;

    print(" ---> INSIDE setIngList and _newCurrentIngrList = " +
        _newCurrentIngrList.toString());
  }

  List<IngredientInfo> get getCurrentFoodIngr {
    print(" ---> INSIDE getCurrentFoodIngr and  returning  = " +
        _newCurrentIngrList.toString());
    return _newCurrentIngrList;
  }

  List<double> convertNutrientsBackToOriginal(
      IngredientInfo _singleFood, int _count) {
    // Indexes => Protien - 0, Fats - 1, Carbs - 2, Kcal - 3
    List<double> _convertedNutrients = [];
    _singleFood.ingredients[0].parsed[0].nutrients["PROCNT"].quantity =
        double.parse(
            (_singleFood.ingredients[0].parsed[0].nutrients["PROCNT"].quantity /
                    _count)
                .toStringAsFixed(2));
    _singleFood.ingredients[0].parsed[0].nutrients["FAT"].quantity =
        double.parse(
            (_singleFood.ingredients[0].parsed[0].nutrients["FAT"].quantity /
                    _count)
                .toStringAsFixed(2));
    _singleFood.ingredients[0].parsed[0].nutrients["CHOCDF"].quantity =
        double.parse(
            (_singleFood.ingredients[0].parsed[0].nutrients["CHOCDF"].quantity /
                    _count)
                .toStringAsFixed(2));
    _singleFood.ingredients[0].parsed[0].nutrients["ENERC_KCAL"].quantity =
        double.parse((_singleFood
                    .ingredients[0].parsed[0].nutrients["ENERC_KCAL"].quantity /
                _count)
            .toStringAsFixed(2));
    _convertedNutrients
        .add(_singleFood.ingredients[0].parsed[0].nutrients["PROCNT"].quantity);
    _convertedNutrients
        .add(_singleFood.ingredients[0].parsed[0].nutrients["FAT"].quantity);
    _convertedNutrients
        .add(_singleFood.ingredients[0].parsed[0].nutrients["CHOCDF"].quantity);
    _convertedNutrients.add(
        _singleFood.ingredients[0].parsed[0].nutrients["ENERC_KCAL"].quantity);
    print("--- Fat: " +
        _singleFood.ingredients[0].parsed[0].nutrients["FAT"].quantity
            .toString());
    return _convertedNutrients;
  }
// ---------------------------------------- E D A M N A N   A P I

  Future<IngredientInfo> getSearchedIngredientsList(
      String searchedQuery) async {
    setState(ViewState.Busy);
    var client = http.Client();
    IngredientInfo _searchedIngrInfo;
    var ingr = searchedQuery;

    try {
      http.Response responce = await client.get(
          "https://api.edamam.com/api/nutrition-data?app_id=a2d43d71&app_key=6fb432105b306e6f26db1d0b082938d9&ingr=$ingr");
      if (responce.statusCode == 200) {
        String jsonString = responce.body;
        print("jsonString: : " + jsonString);
        // searchedIngrList = ingredientInfoFromJson(jsonString);
        _searchedIngrInfo = ingredientInfoFromJson(jsonString);
        print("After");
        // print("After" + _ingredientInfo.calories.toString());

        // searchedIngrList.add(_ingredientInfo);
      }
    } catch (Exception) {
      print("E X C E P T I O N");
      print(Exception.runtimeType.toString());
      print("Exception in A P I in apimanager class: " + Exception.toString());
    }
    setState(ViewState.Idle);
    return _searchedIngrInfo;
  }

// ---------------------------------------- U P L O A D I N G    D I S H
  Future uploadDishInfo(
    String dishName,
    String dishPrice,
    int totalPrepTime,
    File dishPic,
    String dishCatg,
    String dishAttr,
    List<IngredientInfo> _foodIngrList,
  ) async {
    setState(ViewState.Busy);
    print("--------> Upload dish Function reached.");

    if (!Validators().verifyNameInputFeild(dishName)) {
      setErrorMessage("    Dishname can't be empty");
      setState(ViewState.Idle);
    } else if (!Validators().verifyNameInputFeild(dishCatg)) {
      setErrorMessage("    Dish Category can't be empty");
      setState(ViewState.Idle);
    } else if (!Validators().verifyNameInputFeild(dishPrice)) {
      setErrorMessage("    Price can't be empty");
      setState(ViewState.Idle);
    } else if (!Validators().verifyNumInputFeild(totalPrepTime)) {
      setErrorMessage("    Total prepration time can't \nbe empty");
      setState(ViewState.Idle);
    } else if (!Validators().verifyNameInputFeild(dishCatg)) {
      setErrorMessage("    Dish Category can't be empty");
      setState(ViewState.Idle);
    } else if (_foodIngrList == null) {
      setErrorMessage("    Ingredients can't be null");
      setState(ViewState.Idle);
    } else if (dishPic == null) {
      setErrorMessage("    Picture can't be empty");
      setState(ViewState.Idle);
    } else {
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
          "---------> ChefID and extracted ChefName inside NewAddDishViewModel : " +
              userId.toString() +
              " " +
              _chefName);

      print("---------> attrID inside NewAddDishViewModel : " +
          attrID.toString());

      String _uploadedImgURL = await ConstantFtns().uploadFile(dishPic);
      print(" INSIDE UPLOAD DISH AND    N U T R I E N T S    ARE: " +
          _foodIngrList.toString());

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

// --------------------------- G E T T I N G   I N G R E D I E N T S   N A M E S   L I S T
      List<String> _ingredientNames = [];
      for (int i = 0; i < _foodIngrList.length; i++) {
        _ingredientNames.add(_foodIngrList[i].ingredients[0].text);
      }

      await DatabaseService().addNewDishData({
        'dishName': dishName,
        'dishCatg': dishCatg,
        'chefID': userId,
        'dishPrepTime': totalPrepTime,
        'dishPic': _uploadedImgURL.toString(),
        'dishPrice': int.parse(dishPrice),
        'attrID': attrID,
        'chefName': _chefName,
        'ctgID': ctgID,
        'dishProtein': _dishProtein,
        'dishFat': _dishFat,
        'dishCarb': _dishCarb,
        'dishKcal': _dishKcal,
        'dishIngrNames': _ingredientNames,
      });

      setState(ViewState.Idle);
      _navigationService.navigateTo(ChefProfileRoute);
    }
  }

// ---------------------------------------- E D I T I N G    D I S H
  Future editDishInfo(
    String dishName,
    String dishPrice,
    int totalPrepTime,
    var dishPic,
    String dishCatg,
    String dishAttr,
    List<IngredientInfo> _foodIngrList,
    Dish passedDish,
  ) async {
    setState(ViewState.Busy);
    print("--------> edit dish Function reached.");

    if (!Validators().verifyNameInputFeild(dishName)) {
      setErrorMessage("    Dishname can't be empty");
      setState(ViewState.Idle);
    } else if (!Validators().verifyNameInputFeild(dishCatg)) {
      setErrorMessage("    Dish Category can't be empty");
      setState(ViewState.Idle);
    } else if (!Validators().verifyNameInputFeild(dishPrice)) {
      setErrorMessage("    Price can't be empty");
      setState(ViewState.Idle);
    } else if (!Validators().verifyNumInputFeild(totalPrepTime)) {
      setErrorMessage("    Total prepration time can't \nbe empty");
      setState(ViewState.Idle);
    } else if (!Validators().verifyNameInputFeild(dishCatg)) {
      setErrorMessage("    Dish Category can't be empty");
      setState(ViewState.Idle);
    } else if (_foodIngrList == null) {
      setErrorMessage("    Ingredients can't be null");
      setState(ViewState.Idle);
    } else if (dishPic == null) {
      setErrorMessage("    Picture can't be empty");
      setState(ViewState.Idle);
    } else {
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
          "---------> ChefID and extracted ChefName inside NewAddDishViewModel : " +
              userId.toString() +
              " " +
              _chefName);

      print("---------> attrID inside NewAddDishViewModel : " +
          attrID.toString());

      String _uploadedImgURL = await ConstantFtns().uploadFile(dishPic);
      print(" INSIDE UPLOAD DISH AND    N U T R I E N T S    ARE: " +
          _foodIngrList.toString());

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

// --------------------------- G E T T I N G   I N G R E D I E N T S   N A M E S   L I S T
      List<String> _ingredientNames = [];
      for (int i = 0; i < _foodIngrList.length; i++) {
        _ingredientNames.add(_foodIngrList[i].ingredients[0].text);
      }

      await DatabaseService().updateDishData(
        {
          'dishName': dishName,
          'dishCatg': dishCatg,
          'chefID': userId,
          'dishPrepTime': totalPrepTime,
          'dishPic': _uploadedImgURL.toString(),
          'dishPrice': int.parse(dishPrice),
          'attrID': attrID,
          'chefName': _chefName,
          'ctgID': ctgID,
          'dishProtein': _dishProtein,
          'dishFat': _dishFat,
          'dishCarb': _dishCarb,
          'dishKcal': _dishKcal,
          'dishIngrNames': _ingredientNames,
        },
        passedDish.dishID,
      );

      setState(ViewState.Idle);
      _navigationService.navigateTo(ChefProfileRoute);
    }
  }

  List<double> getTotalDishNutrients(List<IngredientInfo> _foodIngrList) {
    double _totalKcal = 0;
    double _totalFats = 0;
    double _totalCarbs = 0;
    double _totalProtein = 0;
    List<double> _nutrientData = [];
    for (int i = 0; i < _foodIngrList.length; i++) {
      _totalProtein = _totalProtein +
          _foodIngrList[i]
              .ingredients[0]
              .parsed[0]
              .nutrients["PROCNT"]
              .quantity;
      _totalFats = _totalFats +
          _foodIngrList[i].ingredients[0].parsed[0].nutrients["FAT"].quantity;
      _totalCarbs = _totalCarbs +
          _foodIngrList[i]
              .ingredients[0]
              .parsed[0]
              .nutrients["CHOCDF"]
              .quantity;
      _totalKcal = _totalKcal +
          _foodIngrList[i]
              .ingredients[0]
              .parsed[0]
              .nutrients["ENERC_KCAL"]
              .quantity;
      print("Total protein: " + _totalProtein.toString());
      print("Total _totalFats: " + _totalFats.toString());
      print("Total _totalKcal: " + _totalKcal.toString());
    }
    _nutrientData.add(_totalProtein);
    _nutrientData.add(_totalFats);
    _nutrientData.add(_totalCarbs);
    _nutrientData.add(_totalKcal);
    return _nutrientData;
  }

  List<String> getDishIngrIDs(List<IngredientInfo> _foodIngrList) {
    List<String> _dishIngrIDs = [];
    for (int i = 0; i < _foodIngrList.length; i++) {
      _dishIngrIDs.add(_foodIngrList[i].ingredients[0].text);
    }
    return _dishIngrIDs;
  }
}
