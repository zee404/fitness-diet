import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/dialogService.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import '../../../locator.dart';
import 'package:geolocator/geolocator.dart';

class OrderViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();

  goToSignIn() {
    _navigationService.navigateToWithoutReplacement(routes.HomeRoute);
  }

// >>>>>>>>>> getcurrent user location
  Future<List<double>> getLocation() async {
    List<double> _position = [];
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("P O S I T I O N : " + position.toString());
    _position.add(position.latitude);
    _position.add(position.longitude);
    return _position;
  }

  Stream<List<ChefData>> getSingleChefData(String currentChefID) {
    setState(ViewState.Busy);
    print("--> Inside getSingleChefData in ViewModel  " +
        currentChefID.toString());
    Stream<List<ChefData>> allChefsData =
        DatabaseService().getSingleChefData(currentChefID);
    print("--> Inside getSingleChefData in ViewModel  and allChefsData " +
        allChefsData.toString());
    setState(ViewState.Idle);
    return allChefsData;
  }

  Future<String> createOrder(
    String custID,
    String custName,
    Map<String, dynamic> shippAddress,
    String phoneNO,
    List orderStatus,
    Map<String, dynamic> items,
    List<Dish> allDishes,
    double total,
    String cartID,
    Plan custPlan,
  ) async {
    print('----> inside create order   in orderview model...' +
        allDishes.length.toString());
    if (shippAddress != null) {
      //-------------------------------- UPDATING EATEN NUTRITIENTS
      //
      List<double> nutritientslist =
          calculateEatenNutritients(items, allDishes);
      // double eatenKcl = calculateEatenCalories(items, allDishes);
      // double eatenProtein = calculateEatenProtein(items, allDishes);
      // double eatenfats = calculateEatenFats(items, allDishes);
      // double eatenCarbs = calculateEatenCarbs(items, allDishes);
      // if (custPlan != null) {
      //   print('------------------- eaten calories ' +
      //       nutritientslist[0].toString());
      //   Map<String, dynamic> planData = {};
      //   planData.addAll(
      //       {"custEatenKcal": (nutritientslist[0] + custPlan.custEatenKcal)});
      //   planData.addAll(
      //     {
      //       "custEatenProtein":
      //           (nutritientslist[1] + custPlan.custEatenProtein),
      //     },
      //   );
      //   planData.addAll(
      //     {
      //       "custEatenFats": (nutritientslist[2] + custPlan.custEatenFats),
      //     },
      //   );
      //   planData.addAll(
      //     {
      //       "custEatenCarbs": (nutritientslist[3] + custPlan.custEatenCarbs),
      //     },
      //   );

      //   DatabaseService().updatePLanData(planData, custPlan.planID);

      //   items.forEach((key, value) {
      //     Dish dish = getDishData(key, allDishes);
      //     DatabaseService().updateCustMeals(
      //         custPlan.planID, dish.dishName, dish.dishKcal.toString());
      //   });
      // }

      /// ------>   C  R  E  A   T  I  N  G -- O  R  D  E   R
      ///
      ///
      String chefID = getShefID(items.keys.elementAt(0), allDishes);
      List<double> _currentPosition = await getLocation();
      Map<String, dynamic> _orderInfo = {};
      String orderId = await DatabaseService().createOrder({
        "custID": custID,
        "custName": custName,
        "chefID": chefID,
        "shippAddress": shippAddress,
        "contactNo": phoneNO,
        "orderStatus": orderStatus,
        "items": items,
        "total": total,
        "location": _currentPosition
      });

      /// ------------> D  E  L  E  T  I  N  G  -- C  A  R  T  -- I  T  E  M
      ///

      DatabaseService().deleteallCartItems(cartID, items);

      return orderId;
    } else {
      setErrorMessage("    Add address first");
      return '';
    }
  }

  Dish getDishData(String dishID, List<Dish> allDishes) {
    for (int i = 0; i < allDishes.length; i++) {
      if (dishID == allDishes[i].dishID) {
        return allDishes[i];
      }
    }
  }

  String getShefID(String dishID, List<Dish> allDishes) {
    for (int i = 0; i <= allDishes.length; i++) {
      if (dishID == allDishes[i].dishID) {
        return allDishes[i].chefID;
      }
    }
  }

  List<double> calculateEatenNutritients(
    Map<String, dynamic> items,
    List<Dish> allDishes,
  ) {
    print('----> inside calculateCalories   in orderview model...' +
        items.length.toString());

    double kcalofOrder = 0;
    double proteinofOrder = 0;
    double fatsofOrder = 0;
    double carbsofOrder = 0;

    // for (int i = 0; i <= 9; i++) {
    // items.forEach((key, value) {
    //   if (key == allDishes[i].dishID) {
    //     kcalofOrder += double.parse(allDishes[i].dishKcal);
    //   }
    // });

    // }
    items.forEach((key, value) {
      for (int i = 0; i < allDishes.length; i++) {
        if (key == allDishes[i].dishID) {
          print('----------------inside for loop ' +
              allDishes[i].dishCarb.toString());
          kcalofOrder = kcalofOrder + allDishes[i].dishKcal;
          proteinofOrder = proteinofOrder + allDishes[i].dishProtein;
          fatsofOrder = fatsofOrder + allDishes[i].dishFat;
          carbsofOrder = carbsofOrder + allDishes[i].dishCarb;
        }
      }
    });
    print('----> inside calculateCalories   in orderview model...' +
        kcalofOrder.toString());

    List<double> nutritientslist = [
      kcalofOrder,
      proteinofOrder,
      fatsofOrder,
      carbsofOrder
    ];
    return nutritientslist;
  }

  ///// product data
  ///
  ///
  int getquantity(Map<String, dynamic> items, String productid) {
    print('inside get quantity function product id is  ' + productid);
    int quan = 0;
    items.forEach((key, value) {
      if (key == productid) {
        // print('product id found ' + value.toString());
        String str = value.toString();

        int i = int.parse(str);
        quan = i;
        print('product id found ' + quan.toString());
        return i;
      }
    });
    return quan;
  }

  void updateCartproduct(String cartID, String productID, int quantity) {
    print(
        '*************************inside update cart function in productlistview model **************');
    DatabaseService().updateCartData(cartID, productID, quantity);
  }

  void deleteItem(String cartID, String productID) {
    DatabaseService().deleteCartItem(cartID, productID);
  }

  void updateDishRatings(String dishid, double dishratings, double newrating,
      double chefrating, String chefID) {
    double rating = ((dishratings + newrating) / 2) > 5
        ? 5
        : double.parse(((dishratings + newrating) / 2).toStringAsFixed(1));
    double newchefrating = ((chefrating + newrating) / 2) > 5
        ? 5
        : double.parse(((chefrating + newrating) / 2).toStringAsFixed(1));

    DatabaseService().updateDishData({"dishRatings": rating}, dishid);
    DatabaseService().updateChefData({'chefRatings': newchefrating}, chefID);
  }

  /////////////////////////
  ///////////////////////
  //////////////////////************************************************* P  R  O  D  U  C  T  -----W  I  D  G  E  T  --F  U  N  C  T  I  O  N  */
  ///
  ///

  // int countInitialValue(
  //     CustData _custdata, Cart _cart, UserCart _usercart, String productid) {
  //   int _count = 0;
  //   if (_custdata != null) {
  //     print('_cust data in inside if condition for count ' +
  //         _custdata.toString());
  //     _count = getquantity(_usercart.items, productid);
  //   } else {
  //     _count =
  //         _cart.items[productid] != null ? _cart.items[productid].quantity : 0;
  //   }

  //   return _count;
  // }

  // bool additem(
  //     Cart _cart,
  //     CustData _custdata,
  //     UserCart _usercart,
  //     List<Product> _productData,
  //     String productid,
  //     String productName,
  //     int price,
  //     String pic,
  //     int salePrice,
  //     String volume) {
  //   if (_custdata != null) {
  //     print(
  //         '********************************** data added in online user cart using add item function in product list view mdel ');
  //     int _quantity = getquantity(_usercart.items, productid); //item quantity
  //     int _productQuantity = getProductquantity(
  //         _productData, productid); //product quantity in inventory

  //     print('------------> quantity of product inside productlist view model ' +
  //         _productQuantity.toString());

  //     if (_quantity >= _productQuantity) {
  //       print('--------------> quantity not availeble ******' +
  //           _quantity.toString());
  //       return false;
  //     } else {
  //       updateCartproduct(_custdata.cartID, productid, _quantity + 1);
  //       return true;
  //     }
  //   } else {
  //     print(
  //         '********************************** data added in guest user cart using add item function in product list view mdel ');

  //     _cart.addItem(productid, productName, price, pic, salePrice, volume);
  //     return true;
  //   }
  // }

  // void removeSingleItem(
  //   Cart _cart,
  //   CustData _custdata,
  //   UserCart _usercart,
  //   String productid,
  // ) {
  //   if (_custdata != null) {
  //     print(
  //         '********************************** item Removed in online user cart using remove item function in product list view mdel ');

  //     int _quantity = getquantity(_usercart.items, productid);
  //     if (_quantity == 1) {
  //       deleteItem(_custdata.cartID, productid);
  //     } else {
  //       updateCartproduct(_custdata.cartID, productid, _quantity - 1);
  //     }
  //   } else {
  //     print(
  //         '********************************** item Removed in guest user cart using remove item function in product list view mdel ');
  //     int _quantity = _cart.getQuantity(productid);
  //     print('*****************quantity of guest cart items is ' +
  //         _quantity.toString());

  //     if (_quantity == 1) {
  //       print('***************item removed fro guest cart in view model ');
  //       _cart.removeItem(productid);
  //     }

  //     _cart.removeSingleItem(productid);
  //   }
  // }

  // void removeItem(CustData _custData, Cart _cart, String productId) {
  //   if (_custData != null) {
  //     print(
  //         '***************complete item removed from online user cart in view model ');

  //     deleteItem(_custData.cartID, productId);
  //   } else {
  //     print(
  //         '***************complete item removed from guest cart in view model ');
  //     _cart.removeItem(productId);
  //   }
  // }
}
