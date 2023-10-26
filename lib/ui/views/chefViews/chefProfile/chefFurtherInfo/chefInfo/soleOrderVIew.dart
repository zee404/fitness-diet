import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/viewmodels/chefViewModels/chefOrdersViewmodel.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeading.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardLinkText.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardText1.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SoleOrderView extends StatefulWidget {
  Order singleOrder;

  SoleOrderView({@required this.singleOrder});
  @override
  _SoleOrderViewState createState() => _SoleOrderViewState();
}

class _SoleOrderViewState extends State<SoleOrderView> {
  // Stream<List<Order>> _orderInfoStream;
  List _updatedStatusList;
  // List<int> _statusListValues = [1, 2];
  List<int> _statusListValues = [1, 2, 3];

  // List<String> _statusListText = [
  // "Order Placed   ",
  // "Order Processed   ",
  // "Order Dispatched   ",
  // "Order Completed   ",
  // "Order Cancelled   ",
  // "Order Failed   ",
  // ];
  List<String> _statusListText = [
    "Order Placed   ",
    "Order Processed   ",
    "Order Cancelled   ",
  ];
  GlobalKey<SimpleGroupedChipsState<int>> chipKey =
      GlobalKey<SimpleGroupedChipsState<int>>();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BaseView<ChefOrdersViewModel>(
      builder: (context, model, child) => model.state == ViewState.Busy
          ? Loading()
          : Scaffold(
              appBar: AppBar(
                title: Text("Order Information"),
                backgroundColor: Colors.brown,
              ),
              body: Container(
                margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                child: ListView(
                  children: [
                    SizedBox(height: 10),

                    // >>>>>>>>>>>>>>>>>>>>>>>>>>  O R D E R   I N F O
                    StandardHeading(passedText: "Order Info"),
                    Divider(thickness: 2),
                    Row(
                      children: [
                        StandardText1(
                          passedDescText: "Order ID: ",
                          fontWeight: FontWeight.bold,
                        ),
                        StandardText1(
                          passedDescText: widget.singleOrder.orderID.toString(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        StandardText1(
                          passedDescText: "Order time: ",
                          fontWeight: FontWeight.bold,
                        ),
                        StandardText1(
                            passedDescText:
                                widget.singleOrder.orderDate.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        StandardText1(
                          passedDescText: "Address: ",
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // >>>>>>>>>>>>>>>>>>>>>>>>>>  O R D E R   I N F O
                    StandardHeading(passedText: "Dishes"),
                    Divider(thickness: 2),
                    widget.singleOrder.items != null &&
                            widget.singleOrder.items.length > 0
                        ? Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.singleOrder.items.length,
                              itemBuilder: (context, index) {
                                final _singleDishID = widget
                                    .singleOrder.items.keys
                                    .elementAt(index);
                                return StreamBuilder<Dish>(
                                  stream: DatabaseService()
                                      .getSingleDishforordersummary(
                                          _singleDishID),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      Dish _singleDishInfo = snapshot.data;
                                      return Container(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: Image(
                                                image: NetworkImage(
                                                  _singleDishInfo.dishPic,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              title: Text(_singleDishInfo
                                                  .dishName
                                                  .toString()),
                                              subtitle: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      StandardText1(
                                                        passedDescText:
                                                            "Dish Price: ",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      Text(_singleDishInfo
                                                              .dishPrice
                                                              .toString() +
                                                          " Rs"),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      StandardText1(
                                                        passedDescText:
                                                            "Dish Kcal: ",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      Text(_singleDishInfo
                                                              .dishKcal
                                                              .toString() +
                                                          " Kcal"),
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
                                      return Text("No dish info");
                                    }
                                  },
                                );
                              },
                            ),
                          )
                        : SizedBox(),

                    // >>>>>>>>>>>>>>>>>>>>>>>>>>  O R D E R   S T A T U S
                    StandardHeading(passedText: "Order Status"),
                    Divider(thickness: 2),
                    StandardText1(passedDescText: "Update order status: "),
                    SimpleGroupedChips<int>(
                      isMultiple: true,
                      preSelection: model
                          .getOrderStatusPreSelectedList(widget.singleOrder),
                      key: chipKey,
                      isScrolling: false,
                      values: _statusListValues,
                      itemTitle: _statusListText,
                      backgroundColorItem: Colors.black26,
                      onItemSelected: (selected) {
                        print("selected " + selected.toString());
                        setState(() {
                          _updatedStatusList = selected;
                        });
                        // _updatedStatusList.add(selected);

                        print("---> _updatedStatusList inside checkBox: " +
                            _updatedStatusList.toString());
                      },
                    ),
                    _updatedStatusList != null
                        ? InkWell(
                            onTap: () async {
                              print("--- _updatedStatusList : " +
                                  _updatedStatusList.toString());
                              bool result = await model.updateOrderStatus(
                                  _updatedStatusList,
                                  widget.singleOrder.orderID);

                              if (result) {
                                Fluttertoast.showToast(
                                    msg: "Order status updated successfully ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 3,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Order status updation failed ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            child: StandardLinkText(
                              passedText: "Update status",
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
    );
  }
}
