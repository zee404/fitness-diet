import 'dart:async';
import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';

class CustSignInViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  dynamic verifiedUserID;

  Future signInCust(String phNo) async {
    setState(ViewState.Busy);
    bool dataValidated;
    var updatedPhoneNo = phNo.replaceFirst(RegExp(r'0'), '+92');
    String phoneNoAlreadyRegistered =
        await DatabaseService().isPhoneNoAlreadyRegistered(updatedPhoneNo);

    Validators().verifyPhoneNumber(phNo)
        ? dataValidated = true
        : dataValidated = false;

    if (phoneNoAlreadyRegistered == "cust") {
      verifiedUserID = await AuthService().verifyPhone(updatedPhoneNo);

      if (verifiedUserID != null) {
        _navigationService.navigateTo(routes.FoodMenuMainRoute);
      }

      if (dataValidated) {
        if (verifiedUserID != null) {
          setState(ViewState.Idle);
        } else {
          setState(ViewState.Idle);
          setErrorMessage(
              "   Something went wrong while\n   verification. Please try again");
        }
      } else {
        setState(ViewState.Idle);
        setErrorMessage("     Enter valid phone no i.e 03xxxxxxxxx");
      }
    } else {
      setState(ViewState.Idle);
      setErrorMessage(
          "   Try again with different number\n   Not registered by any customer");
    }
  }

  // Future<dynamic> verifyPhone(phoneNo) async {
  //   final DialogService _dialogService = locator<DialogService>();
  //   var completer = Completer<dynamic>();
  //   print("‎ Verify Phone reached __________________");
  //   String smsCode;
  //   dynamic newUserResult;

  //   Future<String> getOTPresult() async {
  //     print("Dialog shown");
  //     setState(ViewState.Idle);
  //     var dialogResult =
  //         await _dialogService.showDialog(dialogType: Dialog_Types.OTP);

  //     Result.userText;
  //   }

  //   //
  //   //  >>>>>>>>>>>>> On verification complete
  //   //
  //   final PhoneVerificationCompleted verificationComplete =
  //       (AuthCredential authCred) async {
  //     newUserResult = await AuthService().signInWithPhoneNumber(authCred);

  //     print("Why the fuck are you running?");
  //     if (newUserResult != null) {
  //       print("Phone no is : " + phoneNo);
  //       print("__Result: " + newUserResult.toString());
  //       print("AuthCredential : _______ " + authCred.toString());

  //       // --- Proceeding to screen 2 of chef registration
  //     }
  //     completer.complete(newUserResult);
  //   };
  //   //
  //   ///  >>>>>>>>>>>>> On Timeout
  //   //
  //   final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verID) {
  //     print("\n2. Auto retrieval time out");
  //     completer.complete(newUserResult);
  //   };

  //   // >>>>>>>>>>>>>  On manual code verification

  //   final PhoneCodeSent smsCodeSent =
  //       (String verID, [int forceCodeResend]) async {
  //     print(" --------------> Code sent reached ");

  //     // ignore: non_constant_identifier_names
  //     var OTPDialogResult = await getOTPresult();

  //     print("OTP entered by user: " + OTPDialogResult.toString());

  //     // bool isCorrectOTP =
  //     //     FlutterOtp().resultChecker(int.parse(OTPDialogResult));

  //     //   print("Result of OTP verification: " + isCorrectOTP.toString());

  //     // if (isCorrectOTP) {
  //     AuthCredential authCred = PhoneAuthProvider.getCredential(
  //         verificationId: verID, smsCode: OTPDialogResult);
  //     print("SMS code sent reached OTP is : " + OTPDialogResult.toString());

  //     newUserResult = AuthService().signInWithPhoneNumber(authCred);
  //     completer.complete(newUserResult);
  //     // }
  //   };

  //   final PhoneVerificationFailed verificationFailed =
  //       (AuthException authException) {
  //     print('${AuthException(smsCode, "message")}');

  //     if (authException.message.contains('not authorized'))
  //       print('   App not authroized');
  //     // UIHelper().showErrorButtomSheet(context, '   App not authroized');
  //     else if (authException.message.contains('Network'))
  //       print('   Please check your internet \n    connection and try again ');
  //     else
  //       print('Something has gone wrong, please try later ' +
  //           authException.message);
  //     setState(ViewState.Idle);
  //     completer.complete(newUserResult);
  //   };

  //   await FirebaseAuth.instance
  //       .verifyPhoneNumber(
  //         phoneNumber: phoneNo,
  //         timeout: Duration(seconds: 50),
  //         verificationCompleted: verificationComplete,
  //         verificationFailed: verificationFailed,
  //         codeSent: smsCodeSent,
  //         codeAutoRetrievalTimeout: autoRetrieve,
  //       )
  //       .then((value) =>
  //           print("then newuser Reslut: " + newUserResult.toString()))
  //       .catchError((error) {
  //     print(error.toString());
  //   });
  //   print("New user result at the end : " + newUserResult.toString());
  //   return completer.future;
  // }

  goToCustReg1() {
    _navigationService.navigateTo(routes.CustReg1Route);
  }
}
