import 'package:badges/badges.dart';
import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/cart.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/chefProfileViewModels/chefDishViewModels/chefDishesViewModel.dart';
import 'package:fitness_diet/core/viewmodels/searchviewModel.dart';
import 'package:fitness_diet/ui/shared/imagesURLs.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/custViews/cartView.dart';
import 'package:fitness_diet/ui/views/soleDishView.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingNoBgUniSan.dart';
import 'package:fitness_diet/ui/widgets/dishViewSingleListItemDesign.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SearchDishView extends StatefulWidget {
  @override
  _SearchDishViewState createState() => _SearchDishViewState();
}

// String _searchText = "not products ";
bool connectionStatus = true;

class _SearchDishViewState extends State<SearchDishView> {
  TextEditingController _searchedProductText = new TextEditingController();
  List<Dish> searchresult = new List();

  void checkConnection() async {
    // connectionStatus = await BaseViewModel().checkConn();
  }

  @override
  void initState() {
    checkConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _dishData = Provider.of<List<Dish>>(context);
    final _userCart = Provider.of<Cart>(context);
    // final _guestCart = Provider.of<Cart>(context);
    final _custData = Provider.of<CustData>(context);
    final deviceSize = MediaQuery.of(context).size;
    // print('inside search product view ' + _dishData[0].name);
    final _chefData = Provider.of<List<ChefData>>(context);

    void searchOperation(String searchText) {
      searchresult.clear();
      setState(() {
        for (int i = 0; i < _dishData.length; i++) {
          Dish data = _dishData[i];
          if (data.dishName.toLowerCase().contains(searchText.toLowerCase()) ||
              data.chefName.toLowerCase().contains(searchText.toLowerCase())) {
            searchresult.add(data);
          }
        }
      });
    }

    return BaseView<SearchviewModel>(
      onModelReady: (model) async {
        // connectionStatus = await model.checkConn();
      },
      builder: (context, model, child) => WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
        },
        child: BaseView<ChefDishesViewmodel>(
          builder: (context, model, child) => Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: deviceSize.height * 0.135),
                  child: searchresult.length != 0 ||
                          _searchedProductText.text.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: searchresult.length,
                          itemBuilder: (context, index) => model.state ==
                                  ViewState.Busy
                              ? Loading()
                              : InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SoleDishView(
                                          isFromCustView: true,
                                          passedDish: _dishData[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 100.0,
                                    margin: EdgeInsets.all(5),
                                    child: DishViewSingleListItemDesign(
                                      chefName: model.getChefNameManually(
                                          searchresult[index].chefID,
                                          _chefData),
                                      dishName: searchresult[index].dishName,
                                      dishPic: searchresult[index].dishPic,
                                      kcal: searchresult[index].dishKcal,
                                      price: searchresult[index].dishPrice,
                                      ratings: searchresult[index].dishRatings,
                                    ),
                                  ), 
                                ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _dishData.length,
                          itemBuilder: (context, index) => model.state ==
                                  ViewState.Busy
                              ? Loading()
                              : InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SoleDishView(
                                          isFromCustView: true,
                                          passedDish: _dishData[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 100.0,
                                    margin: EdgeInsets.all(5),
                                    child: DishViewSingleListItemDesign(
                                      chefName: model.getChefNameManually(
                                          _dishData[index].chefID, _chefData),
                                      dishName: _dishData[index].dishName,
                                      dishPic: _dishData[index].dishPic,
                                      kcal: _dishData[index].dishKcal,
                                      price: _dishData[index].dishPrice,
                                      ratings: _dishData[index].dishRatings,
                                    ),
                                  ),
                                ),
                        ),
                ),
                // ------------------------- H E A D E R
                Container(
                  height: deviceSize.height * 0.16,
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 30,
                  ),
                  // margin: EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    // Color(0xffe4d7cb), //
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // >>>>>>>>>>>>>>>>>>>>>>>>> H E A D I N G
                      StandardHeadingNoBgUniSans(passedText: "Search Dish: "),

                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: deviceSize.width * 0.02),
                                height: deviceSize.height * 0.036,
                                width: deviceSize.width * 0.9,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          deviceSize.height * 0.11)),
                                  child: Center(
                                    child: TextFormField(
                                      style: TextStyle(
                                          fontSize: deviceSize.height * 0.015),
                                      controller: _searchedProductText,
                                      cursorColor: Colors.brown,
                                      onChanged: searchOperation,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 20),
                                        hintText: "Enter product name here",
                                        hintStyle: TextStyle(
                                          color: Colors.brown.withOpacity(0.8),
                                          fontSize: deviceSize.height * 0.015,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              deviceSize.height * 0.15),
                                          // borderSide: BorderSide(color: Colors.brown, width: 0.2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              deviceSize.height * 0.15),
                                          //   borderSide: BorderSide(color: Colors.brown, width: 0.3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // >>>>>>>>>>>>>>>>>>>>>>>>> S E A R C H
                            Expanded(
                              flex: 2,
                              child: Lottie.asset(
                                animBrainSearch,
                                repeat: true,
                                reverse: false,
                                animate: true,
                              ),
                              // IconButton(
                              //   color: Colors.black.withOpacity(0.5),
                              //   icon: Icon(
                              //     Icons.search,
                              //     size: 25.0,
                              //     color: Colors.brown.withOpacity(0.7),
                              //   ),
                              //   onPressed: () {},
                              // ),
                            ),
                            // >>>>>>>>>>>>>>>>>>>>>>>>> C A R T
                            Expanded(
                              flex: 1,
                              child: Badge(
                                badgeColor: Colors.green,
                                shape: BadgeShape.circle,
                                badgeContent: Text(
                                  ConstantFtns()
                                      .getCartLength(_custData, _userCart)
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8.5),
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.shopping_cart),
                                  iconSize: 25.0,
                                  color: Colors.green,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CartView(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ------------------------- R E Q U E S T
                      // Expanded(
                      //   flex: 1,
                      //   child: Container(
                      //     margin: EdgeInsets.only(left: 15),
                      //     color: Colors.white,
                      //     child: InkWell(
                      //       onTap: () {
                      //         print("HIT");
                      //         return Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => NewProductRequestView(),
                      //           ),
                      //         );
                      //       },
                      //       child: Row(
                      //         children: [
                      //           Expanded(
                      //             flex: 5,
                      //             child: Text(
                      //               "Your product is not listed? Request new product now",
                      //               overflow: TextOverflow.ellipsis,
                      //               maxLines: 2,
                      //               style: TextStyle(
                      //                   fontFamily: fontMontserrat,
                      //                   fontSize: deviceSize.height * 0.012,
                      //                   fontWeight: FontWeight.normal,
                      //                   color: Colors.black54),
                      //             ),
                      //           ),
                      //           Expanded(
                      //             flex: 2,
                      //             child: Center(
                      //               child: Lottie.asset(
                      //                 animThumbsUp,
                      //                 repeat: true,
                      //                 reverse: true,
                      //                 animate: true,
                      //                 fit: BoxFit.cover,
                      //               ),
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
