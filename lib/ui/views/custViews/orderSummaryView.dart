import 'dart:async';
import 'dart:typed_data';

import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/enums/dialogTypes.dart';
import 'package:fitness_diet/core/enums/orderStatus.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/dialogService.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/orderViewModel.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingBlackMedium.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardText1.dart';
import 'package:fitness_diet/ui/widgets/orderSingleStage.dart';
import 'package:fitness_diet/ui/widgets/timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';

// ignore: must_be_immutable
class OrderSummaryView extends StatefulWidget {
  String orderID;
  List orderStatus;
  OrderSummaryView({@required this.orderID, @required this.orderStatus});

  @override
  _OrderSummaryViewState createState() => _OrderSummaryViewState();
}

class _OrderSummaryViewState extends State<OrderSummaryView> {
  final DialogService _dialogService = locator<DialogService>();
  Order singleOrderInfo;
  // StreamSubscription _locationSubscription;
  // Location _locationTracker = Location();
  // Marker marker;
  // Circle circle;
  // GoogleMapController _controller;

  // static final CameraPosition initialLocation = CameraPosition(
  //   target: LatLng(34.195317, 73.235871),
  //   zoom: 10,
  // );

  // Future<Uint8List> getMarker() async {
  //   ByteData byteData =
  //       await DefaultAssetBundle.of(context).load("assets/images/car_icon.png");
  //   return byteData.buffer.asUint8List();
  // }

  // void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
  //   LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
  //   this.setState(() {
  //     marker = Marker(
  //         markerId: MarkerId("home"),
  //         position: latlng,
  //         rotation: newLocalData.heading,
  //         draggable: false,
  //         zIndex: 2,
  //         flat: true,
  //         anchor: Offset(0.5, 0.5),
  //         icon: BitmapDescriptor.fromBytes(imageData));
  //     circle = Circle(
  //         circleId: CircleId("car"),
  //         radius: newLocalData.accuracy,
  //         zIndex: 1,
  //         strokeColor: Colors.blue,
  //         center: latlng,
  //         fillColor: Colors.blue.withAlpha(70));
  //   });
  // }

  // void getCurrentLocation() async {
  //   try {
  //     Uint8List imageData = await getMarker();
  //     var location = await _locationTracker.getLocation();

  //     updateMarkerAndCircle(location, imageData);

  //     if (_locationSubscription != null) {
  //       _locationSubscription.cancel();
  //     }

  //     _locationSubscription =
  //         _locationTracker.onLocationChanged.listen((newLocalData) {
  //       if (_controller != null) {
  //         _controller.animateCamera(CameraUpdate.newCameraPosition(
  //             new CameraPosition(
  //                 bearing: 192.8334901395799,
  //                 target: LatLng(newLocalData.latitude, newLocalData.longitude),
  //                 tilt: 0,
  //                 zoom: 18.00)));
  //         updateMarkerAndCircle(newLocalData, imageData);
  //       }
  //     });
  //   } on PlatformException catch (e) {
  //     if (e.code == 'PERMISSION_DENIED') {
  //       debugPrint("Permission Denied");
  //     }
  //   }
  // }

  // @override
  // void dispose() {
  //   if (_locationSubscription != null) {
  //     _locationSubscription.cancel();
  //   }
  //   super.dispose();
  // }

  List<bool> reviewd = List<bool>();
  @override
  Widget build(BuildContext context) {
    final _allOrdersInfo = Provider.of<List<Order>>(context);
    final deviceSize = MediaQuery.of(context).size;

    print("orderStatus : " + widget.orderStatus.toString());
    return BaseView<OrderViewModel>(
        onModelReady: (model) {
          print("READY");
          for (int i = 0; i < _allOrdersInfo.length; i++) {
            if (_allOrdersInfo[i].orderID == widget.orderID) {
              singleOrderInfo = _allOrdersInfo[i];
            }
          }
        },
        builder: (context, model, child) => StreamBuilder<List<ChefData>>(
            stream: model.getSingleChefData(_allOrdersInfo.elementAt(0).chefID),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ChefData chefData = snapshot.data[0];
                return Scaffold(
                  appBar: AppBar(
                    title: Text("Order Summary"),
                    backgroundColor: Colors.lightGreen.withOpacity(0.3),
                  ),
                  body: ListView(
                    children: [
                      Container(
                        height: 60,
                        color: Colors.pink.withOpacity(0.1),
                        child: Center(
                          // >>>>>>>>>>>>>>>>>>>>>>>>>>>> O R D E R   I D   A N D   T I M E
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 8),
                                  Text(
                                    "ESTIMATED TIME",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Text(
                                    "30 mins",
                                  ),
                                ],
                              ),
                              // SizedBox(width: 15),
                              Column(
                                children: [
                                  SizedBox(height: 8),
                                  Text(
                                    "Order ID",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Text(
                                    widget.orderID.toString(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   height: deviceSize.height * 0.4,
                      //   child: Stack(
                      //     children: [
                      //       GoogleMap(
                      //         mapType: MapType.hybrid,
                      //         initialCameraPosition: initialLocation,
                      //         markers: Set.of((marker != null) ? [marker] : []),
                      //         circles: Set.of((circle != null) ? [circle] : []),
                      //         onMapCreated: (GoogleMapController controller) {
                      //           _controller = controller;
                      //         },
                      //       ),
                      //       InkWell(
                      //         onTap: () {
                      //           getCurrentLocation();
                      //         },
                      //         child: Align(
                      //           alignment: Alignment.topRight,
                      //           child: Container(
                      //             margin: EdgeInsets.all(10),
                      //             height: deviceSize.height * 0.04,
                      //             width: deviceSize.height * 0.04,
                      //             decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               shape: BoxShape.circle,
                      //             ),
                      //             child: Center(
                      //                 child: Icon(Icons.location_searching)),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // // >>>>>>>>>>>>>>>>>>>>>>>>>>>> O R D E R   T R A C K I N G
                      Timeline(
                        children: <Widget>[
                          OrderSingleStage(
                            primaryText: "Order Placed",
                            secondaryText: "We have received your order",
                            passedIcon: FontAwesomeIcons.receipt,
                            isDone: widget.orderStatus.contains(ConstantFtns()
                                    .getEnumValue(
                                        Order_Status.ORDER_PLACED.toString()))
                                ? true
                                : false,
                          ),
                          OrderSingleStage(
                            primaryText: "Order Processed",
                            secondaryText: "We are prepearing your order",
                            passedIcon: FontAwesomeIcons.gift,
                            isDone: widget.orderStatus.contains(ConstantFtns()
                                    .getEnumValue(Order_Status.ORDER_PROCESSED
                                        .toString()))
                                ? true
                                : false,
                          ),
                          OrderSingleStage(
                            primaryText: "Order Dispatched",
                            secondaryText:
                                "Your order is dispatched and will be ready for pick up",
                            passedIcon: FontAwesomeIcons.truckPickup,
                            isDone: widget.orderStatus.contains(ConstantFtns()
                                    .getEnumValue(Order_Status.ORDER_DISPATCHED
                                        .toString()))
                                ? true
                                : false,
                          ),
                          OrderSingleStage(
                            primaryText: "Order Completed",
                            secondaryText: "Order completed successfully",
                            passedIcon: FontAwesomeIcons.thumbsUp,
                            isDone: widget.orderStatus.contains(ConstantFtns()
                                    .getEnumValue(Order_Status.ORDER_COMPLETED
                                        .toString()))
                                ? true
                                : false,
                          ),
                          OrderSingleStage(
                            primaryText: "Order Failed",
                            secondaryText:
                                "Order is not not completed due to some reason",
                            passedIcon: FontAwesomeIcons.thumbsUp,
                            isDone: widget.orderStatus.contains(ConstantFtns()
                                    .getEnumValue(
                                        Order_Status.ORDER_FAILED.toString()))
                                ? true
                                : false,
                          ),
                        ],
                        indicators: <Widget>[
                          Icon(
                            FontAwesomeIcons.checkCircle,
                            color: widget.orderStatus.contains(ConstantFtns()
                                    .getEnumValue(
                                        Order_Status.ORDER_PLACED.toString()))
                                ? Colors.blueAccent
                                : Colors.redAccent.withOpacity(0.4),
                          ),
                          Icon(
                            FontAwesomeIcons.checkCircle,
                            color: widget.orderStatus.contains(ConstantFtns()
                                    .getEnumValue(Order_Status.ORDER_PROCESSED
                                        .toString()))
                                ? Colors.blueAccent
                                : Colors.redAccent.withOpacity(0.4),
                          ),
                          Icon(
                            FontAwesomeIcons.checkCircle,
                            color: widget.orderStatus.contains(ConstantFtns()
                                    .getEnumValue(Order_Status.ORDER_DISPATCHED
                                        .toString()))
                                ? Colors.blueAccent
                                : Colors.redAccent.withOpacity(0.4),
                          ),
                          Icon(
                            FontAwesomeIcons.checkCircle,
                            color: widget.orderStatus.contains(ConstantFtns()
                                    .getEnumValue(Order_Status.ORDER_COMPLETED
                                        .toString()))
                                ? Colors.blueAccent
                                : Colors.redAccent.withOpacity(0.4),
                          ),
                          Icon(
                            FontAwesomeIcons.cross,
                            color: widget.orderStatus.contains(ConstantFtns()
                                    .getEnumValue(
                                        Order_Status.ORDER_FAILED.toString()))
                                ? Colors.blueAccent
                                : Colors.redAccent.withOpacity(0.4),
                          ),
                        ],
                      ),
                      // >>>>>>>>>>>>>>>>>>>>>>>>>>>> O R D E R   D I S H E S
                      StandardHeadingBlackMedium(passedText: "Products"),
                      Divider(thickness: 2),
                      SizedBox(height: 2),

                      singleOrderInfo.items != null &&
                              singleOrderInfo.items.length > 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: singleOrderInfo.items.length,
                              itemBuilder: (context, index) {
                                reviewd.add(false);
                                print("SINGLE ITEM ID: ");
                                final _singleItemID =
                                    singleOrderInfo.items.keys.elementAt(index);
                                print("SINGLE ITEM ID: " +
                                    _singleItemID.toString());
                                return StreamBuilder<Dish>(
                                  stream: DatabaseService()
                                      .getSingleDishforordersummary(
                                          _singleItemID),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      Dish _singleItemInfo = snapshot.data;
                                      return InkWell(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         SoleDishView(
                                          //       isFromCustView: true,
                                          //       passedDish: _singleItemInfo,
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: Image(
                                                image: NetworkImage(
                                                  _singleItemInfo.dishPic,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              title: Text(_singleItemInfo
                                                  .dishName
                                                  .toString()),
                                              subtitle: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      StandardText1(
                                                        passedDescText:
                                                            "Calories: ",
                                                      ),
                                                      Text(_singleItemInfo
                                                          .dishKcal
                                                          .toString()),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      StandardText1(
                                                        passedDescText:
                                                            "Price: ",
                                                      ),
                                                      Text(_singleItemInfo
                                                              .dishPrice
                                                              .toString() +
                                                          " Rs"),
                                                      Spacer(),
                                                      Container(
                                                        child: FlatButton(
                                                          disabledColor:
                                                              Colors.grey,
                                                          onPressed: () async {
                                                            if (singleOrderInfo
                                                                    .orderStatus
                                                                    .contains(
                                                                        ConstantFtns()
                                                                            .getEnumValue(
                                                                  Order_Status
                                                                      .ORDER_COMPLETED
                                                                      .toString(),
                                                                )) &&
                                                                !reviewd
                                                                    .elementAt(
                                                                        index)) {
                                                              var dialogResult = await _dialogService.showDialog(
                                                                  title:
                                                                      "how was your Experience with the dish. ",
                                                                  description:
                                                                      "Your current Calories consumption is",
                                                                  buttonTitle:
                                                                      "Submit",
                                                                  dialogType:
                                                                      Dialog_Types
                                                                          .Ratings);
                                                              print("--------------------> user ratings in app drawer is  " +
                                                                  dialogResult
                                                                      .userText);

                                                              if (dialogResult
                                                                  .confirmed) {
                                                                double rating =
                                                                    double.parse(
                                                                        dialogResult
                                                                            .userText);
                                                                model
                                                                    .updateDishRatings(
                                                                  _singleItemInfo
                                                                      .dishID,
                                                                  _singleItemInfo
                                                                      .dishRatings,
                                                                  rating,
                                                                  chefData
                                                                      .chefRatings,
                                                                  chefData
                                                                      .chefID,
                                                                );
                                                                reviewd[index] =
                                                                    true;
                                                              }
                                                            }
                                                          },
                                                          child: Text(
                                                            'Review',
                                                            style: TextStyle(
                                                              color: singleOrderInfo
                                                                      .orderStatus
                                                                      .contains(
                                                                          ConstantFtns()
                                                                              .getEnumValue(
                                                                Order_Status
                                                                    .ORDER_COMPLETED
                                                                    .toString(),
                                                              ))
                                                                  ? Colors.blue
                                                                  // : reviewd.elementAt(
                                                                  //         index)
                                                                  : Colors.grey,
                                                              // : Colors
                                                              //     .blue,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  },
                                );
                              },
                            )
                          : Text("No Products"),
                    ],
                  ),
                );
              } else {
                return Scaffold(
                  body: Center(child: Text("No data for selected user")),
                );
              }
            }));
  }
}

// class Example10Vertical extends StatelessWidget {
//   const Example10Vertical({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Container(
//         color: Colors.white,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             TimelineTile(
//               alignment: TimelineAlign.start,
//               isFirst: true,
//               indicatorStyle: IndicatorStyle(
//                 width: 40,
//                 color: Colors.purple,
//                 padding: const EdgeInsets.all(8),
//                 iconStyle: IconStyle(
//                   color: Colors.white,
//                   iconData: Icons.insert_emoticon,
//                 ),
//               ),
//               endChild: Container(
//                 constraints: const BoxConstraints(
//                   minHeight: 120,
//                 ),
//                 // color: Colors.amberAccent,
// child: Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   crossAxisAlignment: CrossAxisAlignment.center,
//   children: [
//     Text(
//       "Order placed",
//       style: TextStyle(fontSize: 16),
//     ),
//     Text(
//       "We have received your order",
//       style: TextStyle(fontSize: 12),
//     ),
//   ],
// ),
//               ),
//             ),
//             TimelineTile(
//               alignment: TimelineAlign.start,
//               isLast: true,
//               indicatorStyle: IndicatorStyle(
//                 width: 30,
//                 color: Colors.red,
//                 indicatorXY: 0.7,
//                 iconStyle: IconStyle(
//                   color: Colors.white,
//                   iconData: Icons.thumb_up,
//                 ),
//               ),
//               endChild: Container(
//                 constraints: const BoxConstraints(
//                   minHeight: 80,
//                 ),
//                 color: Colors.lightGreenAccent,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
