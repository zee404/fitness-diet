import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/viewmodels/chefViewModels/auth/chefReg2ViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/shared/ui_helpers.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/Buttons/authBtnStyle.dart';
import 'package:fitness_diet/ui/widgets/authHeader.dart';
import 'package:fitness_diet/ui/widgets/chefAuthBg.dart';
import 'package:fitness_diet/ui/widgets/dateOfBirthSelector.dart';
import 'package:fitness_diet/ui/widgets/Texts/stepHeaderWithBg.dart';
import 'package:fitness_diet/ui/widgets/TextFeilds/textFeildWithPrefix.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class ChefRegView_2 extends StatefulWidget {
  @override
  _ChefRegView_2State createState() => _ChefRegView_2State();
}

// ignore: camel_case_types
class _ChefRegView_2State extends State<ChefRegView_2> {
  DateTime dateOfBirth;
  final TextEditingController chefNameContr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BaseView<ChefReg2ViewModel>(
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, widgetSize) => Material(
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
                        top: widgetSize.height * 0.25),
                    child: AuthHeader(
                      firstText: "Hello",
                      secondText: "There.",
                      processText: "register",
                      deviceSize: deviceSize,
                    ),
                  ),
                  SizedBox(height: widgetSize.height * 0.02),
                  StepHeaderWithBG(
                      stepsText: "Step 2 of 2", deviceSize: deviceSize),
                  SizedBox(height: widgetSize.height * 0.02),

                  // ------------------------------------------------------   T E X T   F E I L D S   A N D   B U T T O N S
                  Container(
                    margin: EdgeInsets.only(left: widgetSize.width * 0.05),
                    child: Text(
                      "Add info ",
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
                    controller: chefNameContr,
                    deviceSize: deviceSize,
                    isTypeInt: false,
                    preIcon: Icons.person,
                    isObscureText: false,
                    hintText: "Enter your name",
                  ),
                  SizedBox(height: deviceSize.height * 0.01),

                  DateOfBirthSelector(
                    deviceSize: deviceSize,
                    onDateTimeChanged: (newDateTime) {
                      dateOfBirth = newDateTime;
                    },
                  ),

                  SizedBox(height: deviceSize.height * 0.01),
// ------------------------------------------------------    T E X T    W I T H    L O G I N    B U T T O N
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FlatButton(
                      onPressed: () {
                        model.addChefData(
                          chefNameContr.text,
                          dateOfBirth,
                        );
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
                        passedText: "Register",
                      ),
                    ),
                  ),
                  SizedBox(height: widgetSize.height * 0.04),
                  // ------------------------------------------------------    T E X T    W I T H    R E G I S T E R    B U T T O N
                  Container(
                    margin: EdgeInsets.only(left: widgetSize.width * 0.05),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: widgetSize.height * 0.02,
                            fontFamily: 'Uni-Sans',
                            color: Colors.brown,
                          ),
                        ),
                        InkResponse(
                          onTap: () {
                            print("Tapped");
                            Navigator.pushNamed(context, 'chefSignIn');
                          },
                          child: Text(
                            "Sign-in",
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
              model.hasErrorMessage
                  ? Container(
                      color: Colors.red,
                      child: Text(
                        model.errorMessage,
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Container(),

              model.state == ViewState.Busy ? Loading() : Container(),
            ],
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
