import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_diet/core/enums/dialogTypes.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/dialogService.dart';
import 'package:fitness_diet/locator.dart';
import 'package:logger/logger.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthService {
//  final FirebaseAuth _auth = FirebaseAuth.instance;
  Logger logger;
  CurrentUser _userFormFirebaseUser(User user) {
    return user != null ? CurrentUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<CurrentUser> get user =>
      _auth.authStateChanges().map(_userFormFirebaseUser);

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // ------------------------------------------------------ S I G N   I N   W I T H   P H O M E  N U M B E R

  Future signInWithPhoneNumber(AuthCredential authCreds) async {
    try {
      UserCredential result = await _auth.signInWithCredential(authCreds);
      User customUser = result.user;

      if (user != null) {
        print('AUTHENTICATONI SUCCESSFULL. Id: ' + customUser.uid);

        return _userFormFirebaseUser(customUser).uid;
      } else {
        print('Invalid code/invalid authentication');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<dynamic> verifyPhone(phoneNo) async {
    final DialogService _dialogService = locator<DialogService>();
    var completer = Completer<dynamic>();
    print("‎ Verify Phone reached __________________");
    // String smsCode;
    dynamic newUserResult;

    Future<String> getOTPresult() async {
      print("Dialog shown");
      // setState(ViewState.Idle);
      var dialogResult =
          await _dialogService.showDialog(dialogType: Dialog_Types.OTP);

      return dialogResult.userText;
    }

    //
    //  >>>>>>>>>>>>> On verification complete
    //
    final PhoneVerificationCompleted verificationComplete =
        (AuthCredential authCred) async {
      newUserResult = await signInWithPhoneNumber(authCred);

      print("Why the fuck are you running?");
      if (newUserResult != null) {
        print("Phone no is : " + phoneNo);
        print("__Result: " + newUserResult.toString());
        print("AuthCredential : _______ " + authCred.toString());

        // --- Proceeding to screen 2 of chef registration
      }
      completer.complete(newUserResult);
    };
    //
    ///  >>>>>>>>>>>>> On Timeout
    //
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verID) {
      print("\n2. Auto retrieval time out");
      completer.complete(newUserResult);
    };

    // >>>>>>>>>>>>>  On manual code verification

    final PhoneCodeSent smsCodeSent =
        (String verID, [int forceCodeResend]) async {
      print(" --------------> Code sent reached ");

      // ignore: non_constant_identifier_names
      var OTPDialogResult = await getOTPresult();

      print("OTP entered by user: " + OTPDialogResult.toString());

      // if (isCorrectOTP) {
      AuthCredential authCred = PhoneAuthProvider.credential(
          verificationId: verID, smsCode: OTPDialogResult);
      print("SMS code sent reached OTP is : " + OTPDialogResult.toString());

      newUserResult = AuthService().signInWithPhoneNumber(authCred);
      completer.complete(newUserResult);
      // }
    };

    final PhoneVerificationFailed verificationFailed =
        (Exception authException) {
      // print('${AuthException(smsCode, "message")}');

      // if (authException.message.contains('not authorized'))
      //   print('   App not authroized');
      // // UIHelper().showErrorButtomSheet(context, '   App not authroized');
      // else if (authException.message.contains('Network'))
      //   print('   Please check your internet \n    connection and try again ');
      // else
      //   print('Something has gone wrong, please try later ' +
      //       authException.message);
      // //  setState(ViewState.Idle);
      // completer.complete(newUserResult);
    };

    await FirebaseAuth.instance
        .verifyPhoneNumber(
          phoneNumber: phoneNo,
          timeout: Duration(seconds: 50),
          verificationCompleted: verificationComplete,
          verificationFailed: verificationFailed,
          codeSent: smsCodeSent,
          codeAutoRetrievalTimeout: autoRetrieve,
        )
        .then((value) =>
            print("then newuser Reslut: " + newUserResult.toString()))
        .catchError((error) {
      print(error.toString());
    });
    print("New user result at the end : " + newUserResult.toString());
    return completer.future;
  }

  // signInWithOTP(smsCode, verId) {
  //   AuthCredential authCreds = PhoneAuthProvider.getCredential(
  //       verificationId: verId, smsCode: smsCode);
  //   signInWithPhoneNumber(authCreds);
  // }
  // Future<dynamic> verifyPhone(phoneNo, context) async {
  //   var updatedPhoneNo = phoneNo.replaceFirst(RegExp(r'0'), '+92');
  //   print("‎ Verify Phone reached __________________");
  //   String smsCode;

  //   Future<String> getOTPresult() async {
  //     var dialogResult =
  //         await _dialogService.showDialog(dialogType: Dialog_Types.OTP);

  //     return dialogResult.userText;
  //   }

  //   //
  //   //  >>>>>>>>>>>>> On verification complete
  //   //
  //   final PhoneVerificationCompleted verificationComplete =
  //       (AuthCredential authCred) async {
  //     // AuthResult newUserResult =
  //     //     await FirebaseAuth.instance.signInWithCredential(authCred);
  //     // FirebaseUser user = newUserResult.user;
  //     // User(uid: user.uid);

  //     newUserResult = await signInWithPhoneNumber(authCred);
  //     if (newUserResult != null) {
  //       print("Phone no is : " + phoneNo);
  //       print("__Result: " + newUserResult.toString());
  //       print("AuthCredential : _______ " + authCred.toString());

  //       // --- Proceeding to screen 2 of chef registration
  //     }
  //     await DatabaseService(uid: newUserResult).updateCustData({
  //       'custPhNo': updatedPhoneNo,
  //     });
  //     Navigator.pushNamed(context, "foodMenu");
  //   };
  //   //
  //   ///  >>>>>>>>>>>>> On Timeout
  //   //
  //   final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verID) {
  //     print("\n2. Auto retrieval time out");
  //   };

  //   // >>>>>>>>>>>>>  On manual code verification

  //   final PhoneCodeSent smsCodeSent =
  //       (String verID, [int forceCodeResend]) async {
  //     print(" --------------> Code sent reached ");
  //     // ignore: non_constant_identifier_names
  //     var OTPDialogResult = await getOTPresult();

  //     AuthCredential authCred = PhoneAuthProvider.getCredential(
  //         verificationId: verID, smsCode: OTPDialogResult);

  //     newUserResult = await AuthService().signInWithPhoneNumber(authCred);
  //     await DatabaseService(uid: newUserResult).updateCustData({
  //       'custPhNo': updatedPhoneNo,
  //     });
  //     // Navigator.pushNamed(context, "foodMenu");
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => FoodMenuView()));
  //   };

  //   final PhoneVerificationFailed verificationFailed =
  //       (AuthException authException) {
  //     print('${AuthException(smsCode, "message")}');

  //     if (authException.message.contains('not authorized'))
  //       UIHelper().showErrorButtomSheet(context, '   App not authroized');
  //     else if (authException.message.contains('Network'))
  //       UIHelper().showErrorButtomSheet(context,
  //           '   Please check your internet \n    connection and try again ');
  //     else
  //       UIHelper().showErrorButtomSheet(
  //           context, '   Something has gone wrong, \n    Please try later ');
  //     print('Something has gone wrong, please try later ' +
  //         authException.message);
  //   };

  //   await FirebaseAuth.instance
  //       .verifyPhoneNumber(
  //     phoneNumber: updatedPhoneNo,
  //     timeout: Duration(seconds: 50),
  //     verificationCompleted: verificationComplete,
  //     verificationFailed: verificationFailed,
  //     codeSent: smsCodeSent,
  //     codeAutoRetrievalTimeout: autoRetrieve,
  //   )
  //       .catchError((error) {
  //     print(error.toString());
  //   });

  //   // logger.wtf("New user result at the end : " + newUserResult.toString());
  // }

}

// ----------------------:::::::|||||||| Useless Comments

// >>>>>>>>> S I G N   I N   W I T H   P H O M E  N U M B E R   P R O C E S S

/// Below function will return the userID upon successfull phone verification
// ignore: missing_return
