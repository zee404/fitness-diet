import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fitness_diet/core/datamodel/alert_request.dart';
import 'package:fitness_diet/core/datamodel/alert_response.dart';
import 'package:fitness_diet/core/enums/dialogTypes.dart';
import 'package:fitness_diet/core/services/dialogService.dart';
import 'package:fitness_diet/locator.dart';
import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:fitness_diet/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:logger/logger.dart';
import 'package:timer_count_down/timer_count_down.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  Logger logger;
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(AlertRequest request) {
    Size deviceSize = MediaQuery.of(context).size;
    TextEditingController otpController = new TextEditingController();
    bool isTimeUp = false;

    // Below switching between the the type of dialog requested
    switch (request.dialogType) {
      case Dialog_Types.OTP:
        AwesomeDialog(
          context: context,
          animType: AnimType.LEFTSLIDE,
          dialogType: DialogType.INFO,
          dismissOnBackKeyPress: true,
          dismissOnTouchOutside: false,
          body: Center(
            child: Column(
              children: [
                // >>>>>>>>>>>>>>>>>>>>>>> O T P   H E A D E R
                Text(
                  'OTP has been sent to your mobile phone. Enter below',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "BAHNSCHRIFT",
                      fontSize: deviceSize.height * 0.017),
                ),
                SizedBox(
                  height: deviceSize.height * 0.0185,
                ),
                // >>>>>>>>>>>>>>>>>>>>>>> O T P   T E X T   F E I L D

                ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular(deviceSize.height * 0.15)),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceSize.width * 0.02),
                    height: deviceSize.height * 0.04,
                    width: deviceSize.width * 0.9,
                    // color: Colors.green.withOpacity(0.4),
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: deviceSize.height * 0.018),
                        controller: otpController,
                        cursorColor: Colors.brown,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          // hintText: hintText,
                          // hintStyle: TextStyle(
                          //   color: Colors.brown.withOpacity(0.8),
                          //   fontSize: deviceSize.height * 0.02,
                          // ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(deviceSize.height * 0.15),
                            borderSide:
                                BorderSide(color: Colors.brown, width: 0.2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(deviceSize.height * 0.15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // >>>>>>>>>>>>>>>>>>>>>>> R E S E N D    A N D   T I M E R
                SizedBox(
                  height: deviceSize.height * 0.015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Resend OTP in ",
                      style: TextStyle(
                        fontSize: deviceSize.height * 0.015,
                        fontFamily: "Montserrat",
                        color: Colors.brown.withOpacity(0.6),
                      ),
                    ),
                    Countdown(
                      seconds: 50,
                      build: (BuildContext context, double time) => Text(
                        time.toString(),
                        style: TextStyle(
                          fontFamily: "Lemon-Milk",
                          fontSize: deviceSize.height * 0.015,
                        ),
                      ),
                      interval: Duration(milliseconds: 100),
                      onFinished: () {
                        isTimeUp = true;
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          btnOkText: "Continue",
          btnOkOnPress: () async {
            if (isTimeUp) {
              return UIHelper().showErrorButtomSheet(
                  context, "    OTP verification time up.\n    Please retry");
            } else {
              _dialogService.dialogComplete(
                AlertResponse(
                  userText: otpController.text,
                  confirmed: true,
                ),
              );
              //  Navigator.pop(context);
            }
          },
        )..show();
        break;
      case Dialog_Types.PLAN_SUCCESS:
        AwesomeDialog(
          context: context,
          animType: AnimType.LEFTSLIDE,
          dialogType: DialogType.SUCCES,
          dismissOnBackKeyPress: true,
          dismissOnTouchOutside: true,
          body: Center(
            child: Column(
              children: [
                // >>>>>>>>>>>>>>>>>>>>>>> O T P   H E A D E R
                Text(
                  request.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Lemon-Milk",
                      fontSize: deviceSize.height * 0.021),
                ),
                SizedBox(
                  height: deviceSize.height * 0.0185,
                ),

                // >>>>>>>>>>>>>>>>>>>>>>> O T P   T E X T   F E I L D
                Text(
                  request.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "BAHNSCHRIFT",
                      fontSize: deviceSize.height * 0.016),
                ),
                // >>>>>>>>>>>>>>>>>>>>>>> R E S E N D    A N D   T I M E R
                SizedBox(
                  height: deviceSize.height * 0.015,
                ),
              ],
            ),
          ),
          btnOkText: request.buttonTitle,
          btnOkOnPress: () async {
            _dialogService.dialogComplete(AlertResponse(
              confirmed: true,
            ));
            //  Navigator.pop(context);
          },
        )..show();
        break;

      case Dialog_Types.Ratings:
        double _ratings;
        AwesomeDialog(
          context: context,
          animType: AnimType.LEFTSLIDE,
          dialogType: DialogType.INFO,
          dismissOnBackKeyPress: true,
          dismissOnTouchOutside: true,
          body: Center(
            child: Column(
              children: [
                // >>>>>>>>>>>>>>>>>>>>>>> O T P   H E A D E R
                Text(
                  request.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Lemon-Milk",
                      fontSize: deviceSize.height * 0.021),
                ),
                SizedBox(
                  height: deviceSize.height * 0.0185,
                ),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    _ratings = rating;
                    print(rating);
                  },
                ),
                // >>>>>>>>>>>>>>>>>>>>>>> O T P   T E X T   F E I L D
                // Text(
                //   request.description,
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //       fontFamily: "BAHNSCHRIFT",
                //       fontSize: deviceSize.height * 0.016),
                // ),

                // >>>>>>>>>>>>>>>>>>>>>>> R E S E N D    A N D   T I M E R
                SizedBox(
                  height: deviceSize.height * 0.015,
                ),
              ],
            ),
          ),
          btnOkText: request.buttonTitle,
          btnOkOnPress: () async {
            _dialogService.dialogComplete(AlertResponse(
              confirmed: true,
              userText: _ratings.toString(),
            ));
            //  Navigator.pop(context);
          },
        )..show();

        break;
      case Dialog_Types.SMALL_ERROR:
        AwesomeDialog(
          context: context,
          animType: AnimType.LEFTSLIDE,
          dialogType: DialogType.ERROR,
          dismissOnBackKeyPress: true,
          dismissOnTouchOutside: true,
          body: Center(
            child: Column(
              children: [
                // >>>>>>>>>>>>>>>>>>>>>>> O T P   H E A D E R
                // Text(
                //   request.title,
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //       fontFamily: "Lemon-Milk",
                //       fontSize: deviceSize.height * 0.021),
                // ),
                // Center(
                //   child: Lottie.asset(
                //     animEmptyList,
                //     repeat: true,
                //     reverse: false,
                //     animate: true,
                //   ),
                // ),
                // SizedBox(
                //   height: deviceSize.height * 0.0185,
                // ),

                // >>>>>>>>>>>>>>>>>>>>>>> O T P   T E X T   F E I L D
                Text(
                  request.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: fontMontserrat,
                    fontSize: deviceSize.height * 0.014,
                  ),
                ),
                // >>>>>>>>>>>>>>>>>>>>>>> R E S E N D    A N D   T I M E R
                SizedBox(
                  height: deviceSize.height * 0.015,
                ),
              ],
            ),
          ),
          btnOkText: request.buttonTitle,
          btnOkOnPress: () async {
            _dialogService.dialogComplete(AlertResponse(
              confirmed: true,
            ));
          },
        )..show();
        break;
      case Dialog_Types.New_Order:
        AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            dialogType: DialogType.SUCCES,
            dismissOnBackKeyPress: true,
            dismissOnTouchOutside: true,
            body: Center(
              child: Column(
                children: [
                  // >>>>>>>>>>>>>>>>>>>>>>> O T P   H E A D E R
                  Text(
                    request.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Lemon-Milk",
                        fontSize: deviceSize.height * 0.021),
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.0185,
                  ),

                  // >>>>>>>>>>>>>>>>>>>>>>> O T P   T E X T   F E I L D
                  Text(
                    request.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "BAHNSCHRIFT",
                        fontSize: deviceSize.height * 0.016),
                  ),
                  // >>>>>>>>>>>>>>>>>>>>>>> R E S E N D    A N D   T I M E R
                  SizedBox(
                    height: deviceSize.height * 0.015,
                  ),
                ],
              ),
            ),
            btnOkText: request.buttonTitle,
            btnOkOnPress: () async {
              _dialogService.dialogComplete(
                AlertResponse(
                  confirmed: true,
                ),
              );
            },
            btnCancelText: 'cancel',
            btnCancelOnPress: () async {
              _dialogService.dialogComplete(
                AlertResponse(
                  confirmed: false,
                ),
              );
            })
          ..show();

        break;

      default:
    }
  }
}
