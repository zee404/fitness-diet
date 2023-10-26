import 'package:date_format/date_format.dart';
import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:fitness_diet/ui/views/delivViews/updateOrderStatusView.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardLinkText.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustOrdersDelivView extends StatelessWidget {
  Order custOrder;
  CustOrdersDelivView({@required this.custOrder});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.0, top: 5.0, right: 10.0),
      margin: EdgeInsets.all(5.0),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xfffcfbf9),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // >>>>>>>>>>>>>>>>>>>>>>>> Order ID
              Row(
                children: [
                  Text(
                    "Order ID : ",
                    style: TextStyle(
                      fontFamily: fontMontserrat,
                      fontSize: 15,
                      color: Colors.brown,
                    ),
                  ),
                  Text(
                    custOrder.orderID.toString(),
                    style: TextStyle(
                      fontFamily: fontMontserrat,
                      fontSize: 15,
                      color: Color(0xff3caa43),
                    ),
                  ),
                ],
              ),
              // >>>>>>>>>>>>>>>>>>>>>>>> Order Price
              Text(
                custOrder.total.toString() + "Rs",
                style: TextStyle(
                  fontFamily: fontMontserrat,
                  fontSize: 12,
                  color: Colors.black,
                ),
              )
            ],
          ),
          Divider(
            thickness: 1.0,
          ),
          // >>>>>>>>>>>>>>>>>>>>>>>> Order items
          Text(
            "No of items: " + custOrder.items.length.toString(),
            style: TextStyle(
              fontFamily: fontMontserrat,
              fontSize: 12,
              color: Color(0xff707070),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          // >>>>>>>>>>>>>>>>>>>>>>>> Order Date
          Text(
            "Date and time: " +
                formatDate(
                  custOrder.orderDate,
                  [dd, '-', mm, '-', yyyy, ', ', h, ':', nn],
                ),
            style: TextStyle(
              fontFamily: fontMontserrat,
              fontSize: 12,
              color: Color(0xff707070),
            ),
          ),

          Expanded(
            child: Center(
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateOrderStatusView(
                          passedOrder: custOrder,
                        ),
                      ),
                    );
                  },
                  child: StandardLinkText(passedText: "Deliver Order")),
            ),
          )
        ],
      ),
    );
  }
}
