import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_diet/core/enums/dialogTypes.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/dialogService.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';
import 'package:fitness_diet/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class PhoneVer extends BaseViewModel {
  BuildContext context;
  PhoneVer({this.context});
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  // String newUserResult;
  //final DialogService _dialogService = locator<DialogService>();

  Future<void> verifyPhone(phoneNo) async {
    var updatedPhoneNo = phoneNo.replaceFirst(RegExp(r'0'), '+92');
    print("‎ Verify Phone reached __________________");
    String smsCode;
    final AuthService _authService = locator<AuthService>();
    dynamic newUserResult;

    final DialogService _dialogService = locator<DialogService>();

    Future<String> getOTPresult() async {
      var dialogResult =
          await _dialogService.showDialog(dialogType: Dialog_Types.OTP);

      return dialogResult.userText;
    }

    //
    //  >>>>>>>>>>>>> On verification complete
    //
    final PhoneVerificationCompleted verificationComplete =
        (AuthCredential authCred) async {
      // AuthResult newUserResult =
      //     await FirebaseAuth.instance.signInWithCredential(authCred);
      // FirebaseUser user = newUserResult.user;
      // User(uid: user.uid);

      newUserResult = await _authService.signInWithPhoneNumber(authCred);
      if (newUserResult != null) {
        print("Phone no is : " + phoneNo);
        print("__Result: " + newUserResult.toString());
        print("AuthCredential : _______ " + authCred.toString());

        // --- Proceeding to screen 2 of chef registration
      }
      await DatabaseService(uid: newUserResult).addNewCustData({
        'custPhNo': updatedPhoneNo,
      });
      //  Navigator.popAndPushNamed(context, "foodMenu");

      //navigatorKey.currentState.pushNamed('/someRoute');
      // print("--------------------> Build context: " + context.toString());
      // Navigator.pushNamed(context, 'foodMenu').then((_) {
      //   Navigator.of(context).pushReplacementNamed('custSignIn');
      // });
    };
    //
    ///  >>>>>>>>>>>>> On Timeout
    //
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verID) {
      print("\n2. Auto retrieval time out");
    };

    // >>>>>>>>>>>>>  On manual code verification

    final PhoneCodeSent smsCodeSent =
        (String verID, [int forceCodeResend]) async {
      print(" --------------> Code sent reached ");
      // ignore: non_constant_identifier_names
      var OTPDialogResult = await getOTPresult();

      AuthCredential authCred = PhoneAuthProvider.getCredential(
          verificationId: verID, smsCode: OTPDialogResult);

      newUserResult = await AuthService().signInWithPhoneNumber(authCred);
      await DatabaseService(uid: newUserResult).addNewCustData({
        'custPhNo': updatedPhoneNo,
      });
      // Navigator.popAndPushNamed(context, "foodMenu");
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => FoodMenuView()));
      print("--------------------> Build context: " + context.toString());
      Navigator.pushNamed(context, 'foodMenu').then((_) {
        Navigator.of(context).pushReplacementNamed('custSignIn');
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (Exception authException) {
      // print('${Exception(smsCode, "message")}');

      // if (authException.message.contains('not authorized'))
      //   UIHelper().showErrorButtomSheet(context, '   App not authroized');
      // else if (authException.message.contains('Network'))
      //   UIHelper().showErrorButtomSheet(context,
      //       '   Please check your internet \n    connection and try again ');
      // else
      //   UIHelper().showErrorButtomSheet(
      //       context, '   Something has gone wrong, \n    Please try later ');
      // print('Something has gone wrong, please try later ' +
      //     authException.message);
    };

    await FirebaseAuth.instance
        .verifyPhoneNumber(
      phoneNumber: updatedPhoneNo,
      timeout: Duration(seconds: 50),
      verificationCompleted: verificationComplete,
      verificationFailed: verificationFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    )
        .catchError((error) {
      print(error.toString());
    });

    // logger.wtf("New user result at the end : " + newUserResult.toString());
  }
}
