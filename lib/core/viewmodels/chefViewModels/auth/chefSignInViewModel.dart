import 'dart:async';
import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';

class ChefSignInViewModel extends BaseViewModel {
    final NavigationService _navigationService = locator<NavigationService>();

  dynamic verifiedUserID;

  Future signInChef(String phNo) async {
    setState(ViewState.Busy);
    bool dataValidated;
    var updatedPhoneNo = phNo.replaceFirst(RegExp(r'0'), '+92');

    String phoneNoAlreadyRegistered =
        await DatabaseService().isPhoneNoAlreadyRegistered(updatedPhoneNo);

    Validators().verifyPhoneNumber(phNo)
        ? dataValidated = true
        : dataValidated = false;

    if (phoneNoAlreadyRegistered == "chef") {
      //   verifiedUserID = await AuthService().verifyPhone(updatedPhoneNo);
      verifiedUserID = await AuthService().verifyPhone(updatedPhoneNo);

      if (dataValidated) {
        if (verifiedUserID != null) {
          _navigationService.navigateTo(routes.ChefProfileRoute);
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
          "     Try again with different number\n     Not registered by any chef");
    }
  }


}
