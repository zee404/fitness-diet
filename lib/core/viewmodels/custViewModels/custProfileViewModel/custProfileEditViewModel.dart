import 'dart:io';

import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/constants/route_paths.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';

class CustProfileEditViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future<String> uploadCustPic() async {}

  Future updateCustData(String custName, String custContactNo,
      DateTime custdateOfBirth, File custProfilePic) async {
    setState(ViewState.Busy);
    String _currentUserID = await getUser;
    Map<String, dynamic> custdataMap = {};
    Map<String, dynamic> userdataMap = {};
    // if (Validators().verifyNameInputFeild(custName) &&
    //     Validators().verifyNameInputFeild(custContactNo) &&
    //     custdateOfBirth != null &&
    //     cusrProfilePic != null) {}

    if (Validators().verifyNameInputFeild(custName))
      custdataMap.addAll({"custName": custName});
    userdataMap.addAll({'name': custName});
    if (Validators().verifyPhoneNumber(custContactNo))
      custdataMap.addAll({"custContactNo": custContactNo});
    if (custdateOfBirth != null)
      custdataMap.addAll({"custDateOfBirth": custdateOfBirth});
    if (custProfilePic != null) {
      String _uploadedImgURL = await ConstantFtns().uploadFile(custProfilePic);
      custdataMap.addAll({"custPic": _uploadedImgURL});
      userdataMap.addAll({'urlAvatar': _uploadedImgURL});
    }

    print(
        "---------> custdataMap of user '$_currentUserID' Map inside CustProfileEditViewModel : " +
            custdataMap.toString());

    await DatabaseService().updateCustData(custdataMap, _currentUserID);
    await DatabaseService().updateUserData(userdataMap, _currentUserID);
    print("------> CustData UPLOADED.");
    setState(ViewState.Idle);
    _navigationService.navigateTo(CustProfileRoute);
  }
}
