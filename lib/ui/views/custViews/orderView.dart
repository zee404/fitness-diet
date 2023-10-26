import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/cart.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/orderViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/custViews/ReceiptContainer.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/addAddressView.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/addPhoneNoViewSheet.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingBig.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingSmall.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardText1.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardText2.dart';
import 'package:fitness_diet/ui/widgets/radioItemCustom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

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

void _showphoneBottomSheet(BuildContext _context) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: _context,
    isScrollControlled: true,
    elevation: 20,
    builder: (context) {
      return AddPhoneNoSheet();
    },
  );
}

class _OrderViewState extends State<OrderView> {
  String _addrSelectedTitle;
  @override
  Widget build(BuildContext context) {
    final _custdata = Provider.of<CustData>(context);
    final _cart = Provider.of<Cart>(context);
    final _dishData = Provider.of<List<Dish>>(context);

    print("---> _custdata inside OrderView :" + _custdata.toString());
    print('---------------------------address length ' +
        _custdata.custaddress.length.toString());
    return BaseView<OrderViewModel>(
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, deviceSize) => Material(
          color: Color(0xffF5F5F5),
          child: Stack(
            children: [
              // Container(
              // margin: EdgeInsets.only(
              //     bottom: deviceSize.height * 0.25, left: 10, right: 10),
              // ----------------------------------------- O R D E R   C O N T E N T  F O R   S I G N E D - I N  U S E R S
              _custdata != null
                  ? ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        SizedBox(height: 70),
                        StandardHeadingBigBlack(
                            passedText: "You're almost \nthere"),
                        StandardText1(passedDescText: "Confirm your info"),
                        SizedBox(height: 27),
                        StandardHeadingSmall(passedText: "SHIPPING DETAILS"),
                        Divider(
                          thickness: 1,
                          color: Color(0xff69AA6C),
                        ),
                        // >>>>>>>>>>>>>>>>>>>>> Customer details
                        Row(
                          children: [
                            StandardText2(
                              passedDescText: "Name: ",
                              fontWeight: FontWeight.bold,
                            ),
                            StandardText2(
                              passedDescText: _custdata.custName,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                        SizedBox(height: 0),
                        Row(
                          children: [
                            StandardText2(
                              passedDescText: "Contact: ",
                              fontWeight: FontWeight.bold,
                            ),
                            _custdata.custPhNo != ''
                                ? StandardText2(
                                    passedDescText: _custdata.custPhNo,
                                    fontWeight: FontWeight.normal)
                                : InkWell(
                                    onTap: () {
                                      print('add address presed :');
                                      _showphoneBottomSheet(context);
                                    },
                                    child: Text(
                                      "Add contact no",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: fontUniSans,
                                        fontSize: 12,
                                        color: Color(0xff0e8fff),
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        StandardText2(
                          passedDescText: "Shipping address: ",
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 10),
                        // >>>>>>>>>>>>>>>>>>>>>>> Address radio buttons

                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: _custdata.custaddress.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              setState(() {
                                _addrSelectedTitle =
                                    _custdata.custaddress.keys.elementAt(index);
                              });
                              print("------> _addrSelectedTitle: " +
                                  _addrSelectedTitle.toString());
                            },
                            child: RadioItemCustom(
                              addrTitle:
                                  _custdata.custaddress.keys.elementAt(index),
                              addrText: ConstantFtns()
                                  .removeStringTypeListBrackets(_custdata
                                      .custaddress.values
                                      .elementAt(index)
                                      .toString()),
                              isSelected: _addrSelectedTitle ==
                                      _custdata.custaddress.keys
                                          .elementAt(index)
                                  ? true
                                  : false,
                            ),
                          ),
                        ),

                        SizedBox(height: 5),
                        InkWell(
                          onTap: () {
                            print('add address presed :');
                            _showAddressBottomSheet(context);
                          },
                          child: Text(
                            "Add new address",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: fontUniSans,
                              fontSize: 12,
                              color: Color(0xff0e8fff),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),

                        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>  O R D E R I T E M

                        SizedBox(height: 15),
                        StandardHeadingSmall(passedText: "YOUR ORDER"),
                        Divider(
                          thickness: 1,
                          color: Color(0xff69AA6C),
                          endIndent: 30,
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.center,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _dishData.length,
                            itemBuilder: (context, index) => _cart.items.keys
                                    .contains(_dishData[index].dishID)
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      StandardText2(
                                        passedDescText:
                                            _dishData[index].dishName,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      StandardText2(
                                        passedDescText: ConstantFtns()
                                            .getquantity(_cart.items,
                                                _dishData[index].dishID)
                                            .toString(),
                                        fontWeight: FontWeight.normal,
                                      ),
                                      StandardText2(
                                        passedDescText: _dishData[index]
                                            .dishPrice
                                            .toString(),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    height: 0.0,
                                  ),
                          ),
                        ),

                        SizedBox(height: 15),
                      ],
                    )
                  // ----------------------------------------- O R D E R   C O N T E N T  F O R   O F F L I N E  U S E R S
                  : ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        SizedBox(height: 70),
                        StandardHeadingBigBlack(
                            passedText: "You're almost \nthere"),
                        StandardText1(passedDescText: "Confirm your info"),
                        SizedBox(height: 27),
                        StandardHeadingSmall(passedText: "SHIPPING DETAILS"),
                        Divider(
                          thickness: 1,
                          color: Color(0xff69AA6C),
                        ),
                        SizedBox(height: 27),
                        Center(
                          child: StandardText2(
                            passedDescText:
                                "ّYou must sign-in before placing an order",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () => model.goToSignIn(),
                          child: Text(
                            "Sign-in now",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: fontUniSans,
                              fontSize: 12,
                              color: Color(0xff0e8fff),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
              // ),
              // ----------------------------------------- R E C E I P T
              Align(
                alignment: Alignment.bottomCenter,
                child: ReceiptContainer(
                  isCartViewReceipt: false,
                  shippingAddr: _custdata != null
                      ? {
                          _addrSelectedTitle:
                              _custdata.custaddress[_addrSelectedTitle]
                        }
                      : {},
                ),
              ),
              model.state == ViewState.Busy ? Loading() : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
