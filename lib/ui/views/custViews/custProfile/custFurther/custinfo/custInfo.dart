import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custInfoViewModel/custInfoViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/addAddressView.dart';
import 'package:fitness_diet/ui/widgets/custOrders.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingwithBGandRoundCorner.dart';
import 'package:fitness_diet/ui/widgets/standardInfoDisplayWithBullets.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CustInfo extends StatelessWidget {
  void _showAddressBottomSheet(BuildContext _context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: _context,
      isScrollControlled: true,
      elevation: 20,
      builder: (context) {
        return AddAddressView();
      },
    );
  }

  void _showEditaddressBottomSheet(BuildContext _context, String title) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: _context,
      isScrollControlled: true,
      elevation: 20,
      builder: (context) {
        return AddAddressView(
          addressTitle: title,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final _custData = Provider.of<CustData>(context);
    final _custOrders = Provider.of<List<Order>>(context);
    // print('---------------------->_custorderdata length in cust info is :' +
    //     _custOrders.length.toString());
    final _planData = Provider.of<Plan>(context);
    return BaseView<CustInfoViewModel>(
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, widgetSize) => Container(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: widgetSize.height * 0.03,
              ),
              Container(
                margin: EdgeInsets.only(left: widgetSize.width * 0.1),
                child: Column(
                  children: <Widget>[
                    standardInfDisplaywithBullets(
                        'Contact No : ', _custData.custContactNo, deviceSize),
                    // standardInfDisplaywithBullets('Data of birth : ',
                    //     model.parseDate(_custData.custDateOfBirth), deviceSize),
                    standardInfDisplaywithBullets('Address :', '', deviceSize),
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _custData.custaddress != null
                          ? _custData.custaddress.length
                          : 0,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Flexible(
                              child: standardInfDisplaywithBullets(
                                  _custData.custaddress.keys
                                      .elementAt(index)
                                      .toString(),
                                  _custData.custaddress.values
                                      .elementAt(index)
                                      .toString()
                                      .substring(
                                          1,
                                          _custData.custaddress.values
                                                  .elementAt(index)
                                                  .toString()
                                                  .length -
                                              1),
                                  deviceSize),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                print('******** Edit custaddress presed :');
                                _showEditaddressBottomSheet(
                                    context,
                                    _custData.custaddress.keys
                                        .elementAt(index)
                                        .toString());
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete_forever_outlined),
                              onPressed: () {
                                print('********** remove address presed :');

                                model.removeAddress(
                                  _custData.custId,
                                  _custData.custaddress.keys
                                      .elementAt(index)
                                      .toString(),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    FlatButton(
                      onPressed: () {
                        print('add address presed :');
                        _showAddressBottomSheet(context);
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Add address",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            color: Color(0xff3caa43),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: widgetSize.height * 0.06),
              standardHeadingWithBGAndRoundCorner(passedText: "Orders"),

              SizedBox(
                height: widgetSize.height * 0.02,
              ),

              //>>>>>>> O R D E R
              _custOrders != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: _custOrders != null ? _custOrders.length : 0,
                      itemBuilder: (context, index) {
                        return CustOrders(custOrder: _custOrders[index]);
                      },
                    )
                  : Center(
                      child: Text("No orders yet!"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
