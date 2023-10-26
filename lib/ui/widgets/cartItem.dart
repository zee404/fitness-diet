import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/models/cart.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/dialogService.dart';
import 'package:fitness_diet/core/viewmodels/soleDishViewModel.dart';
import 'package:fitness_diet/locator.dart';
import 'package:fitness_diet/ui/shared/imagesURLs.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartItemWidget extends StatefulWidget {
  Dish passedDish;
  // String itemName;
  // String productID;
  // String chefName;
  // int price;
  // int salePrice;
  // String pic;
  int quantity;
  // List<ChefData> allChefsData;
  // List<Dish> allDishes;
  // CustData custdata;
  // Cart cart;

  CartItemWidget({
    @required this.passedDish,
    // @required this.itemName,
    // @required this.chefName,
    // @required this.price,
    // @required this.salePrice,
    // @required this.pic,
    @required this.quantity,
    // @required this.allChefsData,
    // @required this.allDishes,
    // @required this.custdata,
    // @required this.cart,
    // @required this.productID,
  });
  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  DialogService _dialogService = locator<DialogService>();
  int _count = 0;
  bool show;
  @override
  void initState() {
    super.initState();
    show = true;
  }

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<Cart>(context);
    final _custdata = Provider.of<CustData>(context);
    final _dishData = Provider.of<List<Dish>>(context);
    final _allChefsData = Provider.of<List<ChefData>>(context);

    // final _productData = Provider.of<List<Product>>(context);

    ///
    ///
    ///************************************* C  O  D  E  ---- L  O  G  I  C */
    // COUNT INITIAL VALUE BASED ON USER (GUESTUSER ,ONLINE USER)

    if (_custdata != null) {
      print(
          '***********************_cust data in inside if condition for count ' +
              _custdata.toString());
      _count =
          ConstantFtns().getquantity(_cart.items, widget.passedDish.dishID);
      print(
          '***********************_ count initial value when user logged in ' +
              _count.toString());
    }
    // else {
    //   _count = _cart.items[widget.productID] != null
    //       ? _cart.items[widget.productID].quantity
    //       : 0;
    // }

    //
    //********************************************************** */

    return BaseView<SoleDishViewModel>(
      onModelReady: (model) async {},
      builder: (context, model, child) => Container(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        height: 100.0,
        decoration: BoxDecoration(
          //color: Color(0xffedeff2),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              width: 70.0,
              height: 100.0,
              decoration: BoxDecoration(
                //color: Colors.yellow,
                image: DecorationImage(
                  image: widget.passedDish.dishPic != ""
                      ? NetworkImage(widget.passedDish.dishPic)
                      : AssetImage(defaultChefImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //
            //
            //
            ///////////////******************************** O  F  F  E  R  ------  B  A  D  G  E */
            ///
            ///
            ///*******************  C  H  E  C  K -- O  F  F  E  R */
            ///
            ///
            // checkOffer(widget.price, widget.salePrice)

            //     ///
            //     ///
            //     ///***************************************** */
            //     ///
            //     ? Container(
            //         height: 20.0,
            //         width: 50.0,
            //         color: Colors.red,
            //         child: Center(
            //           child: Text(
            //             ///
            //             ///
            //             ///*******************  C  A  L  C  U  L  A  T  E  --- O  F  F  E  R */
            //             ///
            //             ///
            //             ///
            //             calculateOffer(widget.price, widget.salePrice)
            //                     .toString() +
            //                 '% off',

            //             ///
            //             ///
            //             ///******************************************************** */

            //             style: TextStyle(color: Colors.white, fontSize: 10.0),
            //           ),
            //         ),
            //       )
            //     : Container(),
            SizedBox(
              width: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [
                  Flexible(
                    child: Text(
                      ///
                      ///
                      ///**************** C  A  R  T -- I  T  E  M ---- N  A  M  E */
                      ///
                      ///
                      ///
                      widget.passedDish.dishName,
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 15,
                        color: Color(0xff3caa43),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    ///
                    ///
                    ///**************** C  A  R  T -- I  T  E  M ---- V  O  L  U  M  E */
                    ///
                    ///
                    ///
                    model.extractedChefName(
                        _allChefsData, widget.passedDish.chefID),
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 12,
                      color: Color(0xff707070),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      ///
                      ///
                      ///**************** C  A  R  T -- I  T  E  M ---- P  R  I  C  E */
                      ///
                      ///
                      ///
                      Text(
                        widget.passedDish.dishPrice.toString(),
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 12,
                          color: Color(0xff3caa43),
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),

                      ///
                      ///
                      ///**************** C  A  R  T -- I  T  E  M ---- S  A  L  E -- P  R  I  C  E */
                      ///
                      ///
                      // checkOffer(widget.price, widget.salePrice)
                      //     ? Text(
                      //         widget.price.toString(),
                      //         style: TextStyle(
                      //             fontFamily: "Montserrat",
                      //             fontSize: 12,
                      //             color: Colors.grey,
                      //             decoration: TextDecoration.lineThrough),
                      //       )
                      //     : Container(),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.only(
                  bottom: 5.0,
                  top: 5.0,
                ),
                margin: EdgeInsets.only(right: 20.0),
                height: 40.0,
                width: 70.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.green,
                        ),
                        iconSize: 19.0,
                        onPressed: () {
                          ///
                          ///
                          ///
                          ///******************************  A  D  D  -- I  T  E  M --- I  N -- C  A  R  T */
                          ///
                          ///
                          bool added = model.additem(
                            widget.passedDish,
                            _custdata,
                            _cart,
                            _dishData,
                          );
                          // if (added == false) {
                          //   _dialogService.showDialog(
                          //       title: 'Alert :(',
                          //       description:
                          //           "we are sory the product is not available in the quantity you requested ...",
                          //       buttonTitle: "its ok ",
                          //       dialogType: Dialog_Types.PLAN_SUCCESS);
                          // }
                          setState(() {
                            added == true ? _count += 1 : _count += 0;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Text(
                          // _cart.items[widget.productID].quantity.toString(),
                          _count.toString(),
                          style: TextStyle(
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0,
                            color: Color(0xff707070),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                          icon: Icon(
                            Icons.remove_circle,
                            color: Colors.green,
                          ),
                          iconSize: 18.0,
                          onPressed: () {
                            setState(() {
                              _count -= 1;

                              if (_count <= 0) {
                                _count = 0;
                              }

                              ///
                              ///
                              ///
                              ///******************************  A  D  D  -- I  T  E  M --- I  N -- C  A  R  T */
                              ///
                              // ///
                              model.removeSingleItem(
                                  _cart, _custdata, widget.passedDish.dishID);
                            });
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.remove_shopping_cart,
                  color: Colors.grey,
                ),
                onPressed: () {
                  model.deleteItem(_cart.cartid, widget.passedDish.dishID);
                  setState(() {});

                  // global.cartitem -= 1;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
