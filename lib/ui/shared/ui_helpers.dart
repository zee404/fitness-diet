import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:timer_count_down/timer_count_down.dart';

/// Contains useful functions to reduce boilerplate code
class UIHelper {
  // Vertical spacing constants. Adjust to your liking.
  static const double _VerticalSpaceSmall = 10.0;
  static const double _VerticalSpaceMedium = 20.0;
  static const double _VerticalSpaceLarge = 60.0;

  // Vertical spacing constants. Adjust to your liking.
  static const double _HorizontalSpaceSmall = 10.0;
  static const double _HorizontalSpaceMedium = 20.0;
  static const double HorizontalSpaceLarge = 60.0;

  /// Returns a vertical space with height set to [_VerticalSpaceSmall]
  static Widget verticalSpaceSmall() {
    return verticalSpace(_VerticalSpaceSmall);
  }

  /// Returns a vertical space with height set to [_VerticalSpaceMedium]
  static Widget verticalSpaceMedium() {
    return verticalSpace(_VerticalSpaceMedium);
  }

  /// Returns a vertical space with height set to [_VerticalSpaceLarge]
  static Widget verticalSpaceLarge() {
    return verticalSpace(_VerticalSpaceLarge);
  }

  /// Returns a vertical space equal to the [height] supplied
  static Widget verticalSpace(double height) {
    return Container(height: height);
  }

  /// Returns a vertical space with height set to [_HorizontalSpaceSmall]
  static Widget horizontalSpaceSmall() {
    return horizontalSpace(_HorizontalSpaceSmall);
  }

  /// Returns a vertical space with height set to [_HorizontalSpaceMedium]
  static Widget horizontalSpaceMedium() {
    return horizontalSpace(_HorizontalSpaceMedium);
  }

  /// Returns a vertical space with height set to [HorizontalSpaceLarge]
  static Widget horizontalSpaceLarge() {
    return horizontalSpace(HorizontalSpaceLarge);
  }

  /// Returns a vertical space equal to the [width] supplied
  static Widget horizontalSpace(double width) {
    return Container(width: width);
  }

  /// Returns a Error Dialog
  Widget showErrorButtomSheet(BuildContext context, String errorText) {
    Size deviceSize = MediaQuery.of(context).size;
    return
        // showModalBottomSheet(
        //   context: context,
        //   builder: (context) =>

        Container(
      color: Colors.red.withOpacity(0.7),
      padding: EdgeInsets.all(deviceSize.width * 0.04),
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter) {
          return Row(
            children: <Widget>[
              Icon(
                Icons.error,
                color: Colors.white,
              ),
              Text(
                errorText,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontSize: deviceSize.height * 0.012,
                ),
              ),
            ],
          );
        },
      ),
      // ),
    );
  }
}
