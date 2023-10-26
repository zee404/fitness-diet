import 'dart:async';
import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';

class CustRegViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  dynamic verifiedUserID;

  Future register(String phoneNo) async {
    print("---------> CustRegViewModel reached");
    var updatedPhoneNo = phoneNo.replaceFirst(RegExp(r'0'), '+92');

    setState(ViewState.Busy);
    String phoneNoAlreadyRegistered =
        await DatabaseService().isPhoneNoAlreadyRegistered(phoneNo);
    //
    // >>>>>>>>>>>>> Validate phone no
    //
    if (Validators().verifyPhoneNumber(phoneNo) == false) {
      setErrorMessage('  Enter valid phone no i.e 03xxxxxxxxx');
      setState(ViewState.Idle);
    }
    //
    // >>>>>>>>>>>>> Check if user already registered
    //

    else if (await DatabaseService()
            .isPhoneNoAlreadyRegistered(updatedPhoneNo) !=
        null) {
      print("Already exist ______________" +
          DatabaseService()
              .isPhoneNoAlreadyRegistered(updatedPhoneNo)
              .toString());
      setErrorMessage(
          '  This phone no is already registered. \n  Try again with new number');
      setState(ViewState.Idle);
      return false;
    } else {
      //
      // >>>>>>>>>>>>> Upon successful authentication
      //
      if (phoneNoAlreadyRegistered == null) {
        verifiedUserID = await AuthService().verifyPhone(updatedPhoneNo);

        print("New user result at the end : " + verifiedUserID.toString());

        if (verifiedUserID != null) {
          String cartid =
              await DatabaseService().addNewCartData(verifiedUserID);
          await DatabaseService(uid: verifiedUserID).addNewCustData({
            'custPhNo': updatedPhoneNo,
            'custContactNo': updatedPhoneNo,
            'cartID': cartid,
          });
          print(
              "PhoneNo verified and added to DB (Message from within 'CustRegViewmodel')");
          _navigationService.navigateTo(routes.CustReg2Route);

          setState(ViewState.Idle);
        } else {
          setErrorMessage(
              "   Something went wrong while\n   verification. Please try again");
          setState(ViewState.Idle);
        }
      } else {
        setErrorMessage(
            "   Phone no is already registered\n   Please try again with new number");
        setState(ViewState.Idle);
      }
    }
  }
}
