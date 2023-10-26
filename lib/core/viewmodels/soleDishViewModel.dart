import 'package:fitness_diet/core/models/cart.dart';
import 'package:fitness_diet/core/models/disease.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';

class SoleDishViewModel extends BaseViewModel {
  //------------------ -------------chef Functionalty

  ChefData extractedChefData(List<ChefData> _allChefsData, String chefID) {
    ChefData _chefData;
    for (int i = 0; i < _allChefsData.length; i++) {
      if (_allChefsData[i].chefID == chefID) {
        _chefData = _allChefsData[i];
      }
    }
    return _chefData;
  }

  String extractedChefName(List<ChefData> _allChefsData, String chefID) {
    String _chefName;
    for (int i = 0; i < _allChefsData.length; i++) {
      if (_allChefsData[i].chefID == chefID) {
        _chefName = _allChefsData[i].chefName;
      }
    }
    return _chefName;
  }
  //-----------------------------------cust cart functionality

  bool additem(
    Dish passedDish,
    CustData custData,
    Cart cart,
    List<Dish> _alldish,
  ) {
    print('------------------- inside add item in sole dihsh view model .... ');

    if (verifyDishChef(
          cart.items,
          passedDish.chefID,
          _alldish,
        ) ==
        true) {
      int _quantity = getServings(cart.items, passedDish.dishID);
      print("custData.cartID: " + custData.toString());
      DatabaseService()
          .updateCartData(custData.cartID, passedDish.dishID, _quantity + 1);
      return true;
    } else {
      return false;
    }
  }

  bool verifyDishChef(
    Map<String, dynamic> items,
    String currentcheffID,
    List<Dish> _alldish,
  ) {
    print(
        '-------------------------------inside verify dish function in soledishview model  ');
    String chefID;
    bool check = true;
    items.forEach((key, value) {
      chefID = getChefID(key, _alldish);
      if (chefID != currentcheffID) {
        print(
            '-------------------------------inside verify dish function cheff id not matched  ' +
                chefID +
                ' current cheff id ' +
                currentcheffID);
        check = false;
      }
    });

    return check;
  }

  String getChefID(String dishID, List<Dish> _alldish) {
    for (int i = 0; i < _alldish.length; i++) {
      if (_alldish[i].dishID == dishID) {
        return _alldish[i].chefID;
      }
    }
  }

  int getServings(Map<String, dynamic> items, String dishID) {
    print('inside get quantity function dish id is  ' + dishID);
    int quan = 0;
    items.forEach((key, value) {
      if (key == dishID) {
        // print('dish id found ' + value.toString());
        String str = value.toString();

        int i = int.parse(str);
        quan = i;
        print('dish id found ' + quan.toString());
        return i;
      }
    });
    return quan;
  }

  bool removeCartItems(String cartID, Map<String, dynamic> items) {
    DatabaseService().deleteallCartItems(cartID, items);
  }

  //------------- c a r t ------  f u n c t i o n s

  void removeSingleItem(Cart _cart, CustData _custData, String dishID) {
    int _servings = getServings(_cart.items, dishID);

    if (_servings == 1) {
      deleteItem(_custData.cartID, dishID);
    } else {
      DatabaseService().updateCartData(_custData.cartID, dishID, _servings - 1);
    }
  }

  void deleteItem(String cartID, String dishID) {
    DatabaseService().deleteCartItem(cartID, dishID);
  }

  bool deleteDish(String dishID) {
    bool returnedResult = DatabaseService()
        .deleteDocument(DatabaseService().dishCollection, dishID);
    return returnedResult;
  }

  // ------------------------------------- G E T   D I S E A S E   R E L A T E D   D A T A

  List<dynamic> getDiseaseInfoNestedList(
      Plan _plansData, List<Disease> _diseasesData, Dish passedDish) {
    print(" INSIDE getDiseaseInfoNestedList SoleViewModel");
    List<dynamic> _diseaseInfoNestedList = [];
    bool isHealthy = true;
    String unhealthyIngrName = "", diseaseToBeProtectedName = "";
    List _custDiseasesID;

    _custDiseasesID = _plansData.diseases;
    print("======> 1) _custDiseasesID: " + _custDiseasesID.toString());
    // comparing dish ingredients with not recomm in diseases table
    for (int i = 0; i < _diseasesData.length; i++) {
      if (_custDiseasesID.contains(_diseasesData[i].diseaseID)) {
        print("======> 2) _custDiseasesID.contains diseaseID: ");
        for (int j = 0; j < _diseasesData[i].notRecommended.length; j++) {
          print("======> 3) _diseasesData[i].notRecommended[j]: " +
              _diseasesData[i].notRecommended[j].toString());

          for (int k = 0; k < passedDish.dishIngrNames.length; k++) {
            print("======> 4) passedDish.dishIngrNames: " +
                passedDish.dishIngrNames[k].toString());
            if (passedDish.dishIngrNames[k]
                .contains(_diseasesData[i].notRecommended[j])) {
              print("======> 5) Inside IF: " +
                  passedDish.dishIngrNames[k].toString());
              isHealthy = false;
              unhealthyIngrName = passedDish.dishIngrNames[k];
              diseaseToBeProtectedName = _diseasesData[i].name;
              print("Not    H E A L T H Y  because it contains " +
                  unhealthyIngrName +
                  " which is unsafe for your health considering your issues with " +
                  diseaseToBeProtectedName);
            }
          }
        }
      }
    }
    _diseaseInfoNestedList.add(isHealthy);
    _diseaseInfoNestedList.add(unhealthyIngrName);
    _diseaseInfoNestedList.add(diseaseToBeProtectedName);
    print("======> 5) _diseaseInfoNestedList before returning: " +
        _diseaseInfoNestedList.toString());
    return (_diseaseInfoNestedList);
  }
}
