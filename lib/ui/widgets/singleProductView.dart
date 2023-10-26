// import 'package:fitness_diet/core/constants/ConstantFtns.dart';
// import 'package:fitness_diet/core/enums/dialogTypes.dart';
// import 'package:fitness_diet/core/models/cart.dart';
// import 'package:fitness_diet/core/models/dish.dart';
// import 'package:fitness_diet/core/models/user.dart';
// import 'package:fitness_diet/core/services/dialogService.dart';
// import 'package:fitness_diet/locator.dart';
// import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
// import 'package:fitness_diet/ui/views/baseView.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../locator.dart';

// // ignore: must_be_immutable
// class SingleProductView extends StatefulWidget {
//   Dish dish;
//   SingleProductView({this.product});
//   @override
//   _SingleProductViewState createState() => _SingleProductViewState();
// }

// class _SingleProductViewState extends State<SingleProductView> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   DialogService _dialogService = locator<DialogService>();

//   int _count = 0;
//   @override
//   Widget build(BuildContext context) {
//     final _custData = Provider.of<CustData>(context);

//     final _userCart = Provider.of<Cart>(context);
//     final _productData = Provider.of<List<Dish>>(context);
//     if (_custData != null) {
//       print('_cust data in inside if condition for count ' +
//           _custData.toString());
//       _count = ConstantFtns().getquantity(_userCart.items, widget.dish.dishID);
//       print('_ count initial value when user logged in ' + _count.toString());
//     } else {
//       _count =  0;
//     }

//     return BaseView<Ordevi>(
//       onModelReady: (model) async {},
//       builder: (context, model, child) => ResponsiveSafeArea(
//         builder: (context, deviceSize) => Scaffold(
//           key: _scaffoldKey,
//           endDrawer: AppDrawer(),
//           backgroundColor: colorContentBg2,
//           appBar: StandardAppBar(
//             passedContext: context,
//             title: widget.product.name.toString(),
//             scaffoldKey: _scaffoldKey,
//           ),
//           body: Stack(
//             children: [
//               ListView(
//                 children: [
//                   Container(
//                     width: deviceSize.width,
//                     // height: deviceSize.height * 0.4,
//                     margin: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       // color: Colors.white,
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(20)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey,
//                           // spreadRadius: 0.1,
//                           blurRadius: 3,
//                           offset: Offset(2, 1),
//                         ),
//                       ],
//                       // image: DecorationImage(
//                       //   image: widget.product.pic != ""
//                       //       ? NetworkImage(widget.product.pic)
//                       //       : AssetImage(defaultStoreifie),
//                       //   fit: BoxFit.contain,
//                       // ),
//                     ),
//                     child: Column(
//                       children: [
//                         Container(
//                           width: deviceSize.width,
//                           height: deviceSize.height * 0.4,
//                           margin: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             // color: Colors.white,
//                             color: Colors.transparent,

//                             image: DecorationImage(
//                               image: widget.product.pic != ""
//                                   ? NetworkImage(widget.product.pic)
//                                   : AssetImage(defaultStoreifie),
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                         ),
//                         Divider(
//                           indent: 20.0,
//                           endIndent: 20.0,
//                           // height: 10.0,
//                           thickness: 3.0,
//                         ),
//                         Container(
//                           padding: EdgeInsets.all(10.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               checkOffer(widget.product.price,
//                                       widget.product.salePrice)
//                                   ? Container(
//                                       height: 20.0,
//                                       width: 50.0,
//                                       color: Colors.red,
//                                       child: Center(
//                                         child: Text(
//                                           calculateOffer(widget.product.price,
//                                                       widget.product.salePrice)
//                                                   .toString() +
//                                               '% off',
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 10.0),
//                                         ),
//                                       ),
//                                     )
//                                   : Container(),
//                               SizedBox(height: 5),
//                               Text(
//                                 widget.product.name,
//                                 style: TextStyle(
//                                   color: Color(0xff69AA6C),
//                                   fontFamily: fontMontserrat,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                               SizedBox(height: 5),
//                               StandardText1(
//                                   passedDescText: widget.product.volume),
//                               SizedBox(height: 5),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "Rs ",
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       fontFamily: fontUniSans,
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     checkOffer(widget.product.price,
//                                             widget.product.salePrice)
//                                         ? widget.product.salePrice.toString()
//                                         : widget.product.price.toString(),
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       fontFamily: fontUniSans,
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   SizedBox(width: 10),
//                                   checkOffer(widget.product.price,
//                                           widget.product.salePrice)
//                                       ? Text(
//                                           widget.product.price.toString(),
//                                           style: TextStyle(
//                                             fontFamily: fontUniSans,
//                                             fontSize: 17,
//                                             color: Colors.grey,
//                                             decoration:
//                                                 TextDecoration.lineThrough,
//                                           ),
//                                         )
//                                       : SizedBox(),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   // Container(
//                   //   // height: deviceSize.height * 0.2,
//                   //   margin: EdgeInsets.symmetric(horizontal: 10),
//                   //   padding: EdgeInsets.all(10.0),
//                   //   decoration: BoxDecoration(
//                   //     color: Colors.white,
//                   //     borderRadius: BorderRadius.all(Radius.circular(20)),
//                   //     boxShadow: [
//                   //       BoxShadow(
//                   //         color: Colors.grey,
//                   //         // spreadRadius: 0.1,
//                   //         blurRadius: 3,
//                   //         offset: Offset(2, 1),
//                   //       ),
//                   //     ],
//                   //   ),
//                   //   child: Column(
//                   //     crossAxisAlignment: CrossAxisAlignment.start,
//                   //     mainAxisAlignment: MainAxisAlignment.start,
//                   //     children: [
//                   //       checkOffer(
//                   //               widget.product.price, widget.product.salePrice)
//                   //           ? Container(
//                   //               height: 20.0,
//                   //               width: 50.0,
//                   //               color: Colors.red,
//                   //               child: Center(
//                   //                 child: Text(
//                   //                   calculateOffer(widget.product.price,
//                   //                               widget.product.salePrice)
//                   //                           .toString() +
//                   //                       '% off',
//                   //                   style: TextStyle(
//                   //                       color: Colors.white, fontSize: 10.0),
//                   //                 ),
//                   //               ),
//                   //             )
//                   //           : Container(),
//                   //       SizedBox(height: 5),
//                   //       Text(
//                   //         widget.product.name,
//                   //         style: TextStyle(
//                   //           color: Color(0xff69AA6C),
//                   //           fontFamily: fontMontserrat,
//                   //           fontSize: 20,
//                   //         ),
//                   //       ),
//                   //       SizedBox(height: 5),
//                   //       StandardText1(passedDescText: widget.product.volume),
//                   //       SizedBox(height: 5),
//                   //       Row(
//                   //         crossAxisAlignment: CrossAxisAlignment.center,
//                   //         children: [
//                   //           Text(
//                   //             "Rs ",
//                   //             overflow: TextOverflow.ellipsis,
//                   //             style: TextStyle(
//                   //               fontFamily: fontUniSans,
//                   //               fontSize: 17,
//                   //               fontWeight: FontWeight.bold,
//                   //             ),
//                   //           ),
//                   //           Text(
//                   //             checkOffer(widget.product.price,
//                   //                     widget.product.salePrice)
//                   //                 ? widget.product.salePrice.toString()
//                   //                 : widget.product.price.toString(),
//                   //             overflow: TextOverflow.ellipsis,
//                   //             style: TextStyle(
//                   //               fontFamily: fontUniSans,
//                   //               fontSize: 17,
//                   //               fontWeight: FontWeight.bold,
//                   //             ),
//                   //           ),
//                   //           SizedBox(width: 10),
//                   //           checkOffer(widget.product.price,
//                   //                   widget.product.salePrice)
//                   //               ? Text(
//                   //                   widget.product.price.toString(),
//                   //                   style: TextStyle(
//                   //                     fontFamily: fontUniSans,
//                   //                     fontSize: 17,
//                   //                     color: Colors.grey,
//                   //                     decoration: TextDecoration.lineThrough,
//                   //                   ),
//                   //                 )
//                   //               : SizedBox(),
//                   //         ],
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                 ],
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: _count == 0
//                     ? FlatButton(
//                         onPressed: () {
//                           bool added = model.additem(
//                             _guestCart,
//                             _custData,
//                             _userCart,
//                             _productData,
//                             widget.product.productID,
//                             widget.product.productCtgname,
//                             widget.product.price,
//                             widget.product.pic,
//                             widget.product.salePrice,
//                             widget.product.volume,
//                           );
//                           if (added == false) {
//                             _dialogService.showDialog(
//                                 title: 'Alert :(',
//                                 description:
//                                     "We are SORRY. \nThis Product is not currently out of stock",
//                                 buttonTitle: "its ok ",
//                                 dialogType: Dialog_Types.SMALL_ERROR);
//                           }
//                           setState(() {
//                             added == true ? _count += 1 : _count += 0;
//                           });
//                         },
//                         child: Container(
//                           margin: EdgeInsets.only(bottom: 10.0),
//                           alignment: Alignment.center,
//                           height: 40.0,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.green,
//                             // Color(0xffE4E4E4),
//                             borderRadius: BorderRadius.circular(20.0),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(width: 10),
//                               Center(
//                                 child: Text(
//                                   "Add to Cart",
//                                   style: TextStyle(
//                                       fontFamily: "Segoe UI",
//                                       fontSize: 20,
//                                       color: Colors.white),
//                                 ),
//                               ),
//                               // Spacer(),
//                               // Icon(
//                               //   Icons.add_circle,
//                               //   color: Colors.white,
//                               //   size: 20.0,
//                               // )
//                             ],
//                           ),
//                         ),
//                       )
//                     : Container(
//                         margin: EdgeInsets.only(bottom: 10.0),
//                         alignment: Alignment.center,
//                         height: 40.0,
//                         width: deviceSize.width * 0.5,
//                         decoration: BoxDecoration(
//                           color: Colors.green,
//                           // Color(0xffE4E4E4),
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             // SizedBox(width: 10),
//                             InkWell(
//                               onTap: () {
//                                 setState(() {
//                                   _count -= 1;

//                                   if (_count < 0) {
//                                     _count = 0;
//                                   }
//                                 });

//                                 ///
//                                 ///
//                                 ///
//                                 ///******************************  R  E  M  O  V  E  -- I  T  E  M --- F  R  O  M -- C  A  R  T */
//                                 ///
//                                 ///
//                                 model.removeSingleItem(
//                                   _guestCart,
//                                   _custData,
//                                   _userCart,
//                                   widget.product.productID,
//                                 );
//                               },
//                               child: Icon(
//                                 Icons.remove_circle,
//                                 color: Colors.white,
//                                 size: 40.0,
//                               ),
//                             ),
//                             // Spacer(),
//                             Text(
//                               _count.toString(),
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20.0,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             // --------------------------------------- A D D   I T E M
//                             InkWell(
//                               onTap: () {
//                                 bool added = model.additem(
//                                   _guestCart,
//                                   _custData,
//                                   _userCart,
//                                   _productData,
//                                   widget.product.productID,
//                                   widget.product.productCtgname,
//                                   widget.product.price,
//                                   widget.product.pic,
//                                   widget.product.salePrice,
//                                   widget.product.volume,
//                                 );
//                                 if (added == false) {
//                                   _dialogService.showDialog(
//                                       title: 'Alert :(',
//                                       description:
//                                           "We are SORRY. \nThis Product is not currently out of stock",
//                                       buttonTitle: "its ok ",
//                                       dialogType: Dialog_Types.SMALL_ERROR);
//                                 }
//                                 setState(() {
//                                   added == true ? _count += 1 : _count += 0;
//                                 });
//                               },
//                               child: Icon(
//                                 Icons.add_circle,
//                                 color: Colors.white,
//                                 size: 40.0,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//               )
//               // Align(
//               //   alignment: Alignment.bottomCenter,
//               //   child: Container(
//               //     margin: EdgeInsets.symmetric(vertical: 25),
//               //     child: InkWell(
//               //       onTap: () {
//               //         // bool added = model.additem(
//               //         //   _guestCart,
//               //         //   _custData,
//               //         //   _userCart,
//               //         //   _productData,
//               //         //   widget.product.productID,
//               //         //   widget.product.productCtgname,
//               //         //   widget.product.price,
//               //         //   widget.product.pic,
//               //         //   widget.product.salePrice,
//               //         //   widget.product.volume,
//               //         // );
//               //         // setState(() {
//               //         //   added == true ? _count += 1 : _count += 0;
//               //         // });
//               //         bool added = model.additem(
//               //           _guestCart,
//               //           _custData,
//               //           _userCart,
//               //           _productData,
//               //           widget.product.productID,
//               //           widget.product.productCtgname,
//               //           widget.product.price,
//               //           widget.product.pic,
//               //           widget.product.salePrice,
//               //           widget.product.volume,
//               //         );
//               //         if (added == false) {
//               //           _dialogService.showDialog(
//               //               title: 'Alert :(',
//               //               description:
//               //                   "we are sory the product is not available in the quantity you requested ...",
//               //               buttonTitle: "its ok ",
//               //               dialogType: Dialog_Types.PLAN_SUCCESS);
//               //         }
//               //         setState(() {
//               //           added == true ? _count += 1 : _count += 0;
//               //         });
//               //       },
//               //       child: BigLightGreenBtn(
//               //         passedText: _count == 0
//               //             ? "Add to cart"
//               //             : "Add to cart ( " + _count.toString() + " added )",
//               //         isDisabled: false,
//               //       ),
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
