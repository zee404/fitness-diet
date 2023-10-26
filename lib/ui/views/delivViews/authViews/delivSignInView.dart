import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/viewmodels/delivViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/shared/ui_helpers.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/Buttons/authBtnStyle.dart';
import 'package:fitness_diet/ui/widgets/authHeader.dart';
import 'package:fitness_diet/ui/widgets/TextFeilds/textFeildWithPrefix.dart';
import 'package:fitness_diet/ui/widgets/delivAuthBg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

class DelivSigninView extends StatefulWidget {
  @override
  _DelivSigninViewState createState() => _DelivSigninViewState();
}

class _DelivSigninViewState extends State<DelivSigninView> {
  bool timeComplete = true;
  final TextEditingController _phNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Countdown(
      seconds: 2,
      build: (BuildContext context, double time) => Text(time.toString()),
      interval: Duration(milliseconds: 100),
      onFinished: () {
        setState(() {
          timeComplete = false;
        });
      },
    );

    return BaseView<DelivViewModel>(
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, widgetSize) => Scaffold(
          resizeToAvoidBottomPadding: false,
          body: StreamProvider<DelivData>.value(
            value: DatabaseService().getDelivData,
            child: Material(
              type: MaterialType.card,
              //  color: Color(0xffD4EBD3),
              child: Stack(
                children: <Widget>[
                  //
                  // >>>>>>>>> Registor background image
                  //
                  DelivAuthBg(),

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
                          processText: "login",
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
                            fontSize: widgetSize.height * 0.025,
                            fontFamily: 'Montserrat',
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      SizedBox(height: widgetSize.height * 0.01),
                      // :::::::>>>||||--------------------------------------------------   Phone verification initiated

                      TextFeildWithPrefix(
                        controller: _phNoController,
                        deviceSize: deviceSize,
                        isTypeInt: true,
                        preIcon: Icons.phone,
                        isObscureText: false,
                        hintText: "Enter phone no",
                      ),

                      SizedBox(height: widgetSize.height * 0.02),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: FlatButton(
                          onPressed: () {
                            model.signInDeliv(_phNoController.text);
                            model.hasErrorMessage ||
                                    _phNoController.text == null
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
                            passedText: "Login",
                          ),
                        ),
                      ),
                      SizedBox(height: widgetSize.height * 0.1),
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
                                model.goToDelivReg1();
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: widgetSize.height * 0.02,
                                  fontFamily: 'Uni-Sans',
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
