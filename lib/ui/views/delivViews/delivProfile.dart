import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/viewmodels/delivViewModel.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/delivViews/custOrdersDelivView.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingSmall.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DelivProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _allOrder = Provider.of<List<Order>>(context);

    print("-------- INSIDE DELIV PROFILE");
    return BaseView<DelivViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Text("All Orders"),
          actions: [
            InkWell(
              onTap: () => {model.signOut()},
              child: Icon(Icons.input_outlined),
            ),
            SizedBox(width: 15),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(top: 15, left: 10, right: 10),
          child: _allOrder == null
              ? Center(child: Text("No orders"))
              : ListView(
                  children: [
                    // ------------------------------ Active orders
                    StandardHeadingSmall(passedText: "Active orders"),
                    Divider(height: 2, thickness: 2),
                    SizedBox(height: 5),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _allOrder.length,
                      itemBuilder: (context, index) {
                        int _statusListLength =
                            _allOrder[index].orderStatus.length;
                        return _allOrder[index]
                                    .orderStatus[_statusListLength - 1] !=
                                "ORDER_COMPLETED"
                            ? CustOrdersDelivView(custOrder: _allOrder[index])
                            : SizedBox();
                      },
                    ),
                    SizedBox(height: 10),
                    // ------------------------------ Completed orders
                    StandardHeadingSmall(passedText: "Completed orders"),
                    Divider(height: 2, thickness: 2),
                    SizedBox(height: 5),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _allOrder.length,
                      itemBuilder: (context, index) {
                        int _statusListLength =
                            _allOrder[index].orderStatus.length;
                        print("---------> S T A T U S  " +
                            _allOrder[index]
                                .orderStatus[_statusListLength - 1]
                                .toString() +
                            " I D : " +
                            _allOrder[index].orderID);
                        return _allOrder[index]
                                    .orderStatus[_statusListLength - 1] ==
                                "ORDER_COMPLETED"
                            ? CustOrdersDelivView(custOrder: _allOrder[index])
                            : SizedBox();
                      },
                    ),
                    // ------------------------------ Cancelled orders
                    SizedBox(height: 10),
                    StandardHeadingSmall(passedText: "Cancelled orders"),
                    Divider(height: 2, thickness: 2),
                    SizedBox(height: 5),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _allOrder.length,
                      itemBuilder: (context, index) {
                        int _statusListLength =
                            _allOrder[index].orderStatus.length;
                        print("---------> S T A T U S  " +
                            _allOrder[index]
                                .orderStatus[_statusListLength - 1]
                                .toString() +
                            " I D : " +
                            _allOrder[index].orderID);
                        return _allOrder[index]
                                        .orderStatus[_statusListLength - 1] ==
                                    "ORDER_CANCELLED" ||
                                _allOrder[index]
                                        .orderStatus[_statusListLength - 1] ==
                                    "ORDER_FAILED"
                            ? CustOrdersDelivView(custOrder: _allOrder[index])
                            : SizedBox();
                      },
                    ),
                       SizedBox(height: 10),
                  ],
                ),
        ),
      ),
    );
  }
}
