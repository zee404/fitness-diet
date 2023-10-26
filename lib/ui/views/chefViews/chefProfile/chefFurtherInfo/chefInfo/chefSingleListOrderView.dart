import 'package:date_format/date_format.dart';
import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/chefViewModels/chefOrdersViewmodel.dart';
import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadinNoBgSmall.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingSmall.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardLinkText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ChefSingleListOrderView extends StatelessWidget {
  Order singleOrder;
  ChefSingleListOrderView({@required this.singleOrder});
  CustData _singleCustData;
  @override
  Widget build(BuildContext context) {
    final _custData = Provider.of<List<CustData>>(context);

    return BaseView<ChefOrdersViewModel>(
      onModelReady: (model) {
        // _singleCustData =
        //     model.getSingleCustInfo(_custData, singleOrder.custID);
      },
      builder: (context, model, child) => Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(2.00, 3.00),
              color: Colors.black45,
              blurRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StandardHeadingNoBgSmall(
                    passedText: "Order ID : " + singleOrder.orderID.toString(),
                  ),
                  // Text(
                  //   "Cust - ID " + singleOrder.custID.toString(),
                  //   style: TextStyle(
                  //     fontFamily: fontUniSans,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text("Order time: ",
                          style: TextStyle(fontFamily: fontBahnschrift)),
                      Text(formatDate(singleOrder.orderDate, ["HH", ":", "nn"]),
                          style: TextStyle(fontFamily: fontBahnschrift)),
                      Spacer(),
                      StandardHeadingSmall(
                        passedText: singleOrder
                            .orderStatus[singleOrder.orderStatus.length - 1],
                      ),
                    ],
                  ),
                  StandardLinkText(passedText: "Check order detail"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
