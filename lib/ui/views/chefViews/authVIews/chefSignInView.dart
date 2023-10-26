import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/viewmodels/chefViewModels/auth/chefSignInViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/shared/ui_helpers.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/Buttons/authBtnStyle.dart';
import 'package:fitness_diet/ui/widgets/authHeader.dart';
import 'package:fitness_diet/ui/widgets/chefAuthBg.dart';
import 'package:fitness_diet/ui/widgets/TextFeilds/textFeildWithPrefix.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// ignore: mhef_be_immutable

class ChefSignInView extends StatefulWidget {
  @override
  _ChefSignInViewState createState() => _ChefSignInViewState();
}

class _ChefSignInViewState extends State<ChefSignInView> {
  Logger logger;
  final TextEditingController _phNocontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BaseView<ChefSignInViewModel>(
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, widgetSize) => Scaffold(
          body: Material(
            type: MaterialType.card,
            //  color: Color(0xffD4EBD3),
            child: Stack(
              children: <Widget>[
                //
                // >>>>>>>>> Registor background image
                //
                ChefAuthBg(),

                ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    // ------------------------------------------------------   T I T L E
                    Container(
                      margin: EdgeInsets.only(
                          left: widgetSize.width * 0.05,
                          top: widgetSize.height * 0.35),
                      child: AuthHeader(
                        firstText: "Welcome",
                        secondText: "Back.",
                        processText: "sign-in",
                        deviceSize: deviceSize,
                      ),
                    ),
                    SizedBox(height: widgetSize.height * 0.02),

                    // ------------------------------------------------------   T E X T   F E I L D S   A N D   B U T T O N S
                    Container(
                      margin: EdgeInsets.only(left: widgetSize.width * 0.05),
                      child: Text(
                        "Verify phone ",
                        style: TextStyle(
                          fontSize: widgetSize.height * 0.02,
                          fontFamily: 'Montserrat',
                          color: Colors.brown,
                        ),
                      ),
                    ),
                    SizedBox(height: widgetSize.height * 0.01),
                    // :::::::>>>||||--------------------------------------------------   Phone verification initiated

                    TextFeildWithPrefix(
                      controller: _phNocontroller,
                      deviceSize: deviceSize,
                      isTypeInt: true,
                      preIcon: Icons.phone,
                      isObscureText: false,
                      hintText: " 03xxxxxxxxx",
                    ),

                    SizedBox(height: widgetSize.height * 0.02),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: FlatButton(
                        onPressed: () async {
                          model.signInChef(_phNocontroller.text);
                          model.hasErrorMessage
                              ? WidgetsBinding.instance.addPostFrameCallback(
                                  (_) => _showErrorMessage(
                                    context,
                                    model.errorMessage,
                                  ),
                                )
                              : Container();
                        },
                        child: AuthBtnStyle(
                          deviceSize: deviceSize,
                          passedText: "Verify",
                        ),
                      ),
                    ),
                    SizedBox(height: widgetSize.height * 0.03),
                    // ------------------------------------------------------    T E X T    W I T H    R E G I S T E R    B U T T O N
                    Container(
                      margin: EdgeInsets.only(left: widgetSize.width * 0.05),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: widgetSize.height * 0.02,
                              fontFamily: 'Uni-Sans',
                              color: Colors.brown,
                            ),
                          ),
                          InkResponse(
                            onTap: () {
                              print("Tapped");
                              Navigator.pushNamed(context, 'chefReg_1');
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontSize: widgetSize.height * 0.02,
                                fontFamily: 'Uni-Sans',
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                model.state == ViewState.Busy ? Loading() : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_showErrorMessage(BuildContext context, String error) async {
  showModalBottomSheet(
    context: (context),
    builder: (context) => UIHelper().showErrorButtomSheet(context, error),
  );
}
