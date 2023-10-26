import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';

class CustReg2ViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future addCustData(String custName, DateTime dateOfBirth) async {
    // String userUID = await getUser;
    print("-----------> CustReg2ViewModel reached");
    String userID = getUser;
    bool dataValidated;
    setState(ViewState.Busy);
    Validators().verifyNameInputFeild(custName) && dateOfBirth != null
        ? dataValidated = true
        : dataValidated = false;

    if (dataValidated) {
      print("--------------User().getUid: " + userID);
      bool check = await DatabaseService(uid: userID).addNewCustData({
        'custName': custName,
        'custDateOfBirth': dateOfBirth,
      });
      await DatabaseService(uid: userID).addnewuser(custName);
      print("Data entered in the DataBase from CustReg2ViewModel status:" +
          check.toString() +
          "    Going to foodMenu");
      if (check) {
        _navigationService.navigateTo(routes.HomeRoute);
        setState(ViewState.Idle);
      }
    } else {
      setErrorMessage("   Registration failed\n   Add valid info");
      setState(ViewState.Idle);
    }
  }

  goToCustSignin() {
    _navigationService.navigateTo(routes.CustSignRoute);
  }
}
