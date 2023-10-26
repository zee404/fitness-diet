

import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';

import '../../locator.dart';

class LoginViewModel extends BaseViewModel {
  final AuthService _authenticationService = locator<AuthService>();

  String errorMessage;

  Future<bool> login(String userIdText) async {
    setState(ViewState.Busy);

    var userId = int.tryParse(userIdText);

    // Not a number
    if (userId == null) {
      errorMessage = 'Value entered is not a number';
      setState(ViewState.Idle);
      return false;
    }

   // var success = await _authenticationService.;

    // Handle potential error here too.

    setState(ViewState.Idle);
  //  return success;
    return true;
  }
}
