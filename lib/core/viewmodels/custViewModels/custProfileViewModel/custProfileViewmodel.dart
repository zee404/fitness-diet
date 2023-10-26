import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';
import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CustProfileViewModel extends BaseViewModel {
  // CustData _custData;
  final NavigationService _navigationService = locator<NavigationService>();

  // Future <CustData> fetchCustData(String userID) async{

  //    Stream xyz =   DatabaseService(uid: userID).getCustData,

  //     // stream: ,
  //     // builder: (context, snapshot) {
  //     //   if (snapshot.hasData && !snapshot.hasError) {
  //     //     _custData = snapshot.data;
  //     //     return _custData;
  //     //   }
  //     // },

  //   // Stream<CustData> fetchData(String userID) {
  //   //   setState(ViewState.Busy);

  //   //   Stream<CustData> custData = DatabaseService(uid: userID).getCustData;
  //   //   setState(ViewState.Idle);
  //   //   print("Custdata from Stream: " + custData.toString());
  //   //   return custData;
  //   // }
  // }
  String calculateAge(DateTime dob) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(dob);
    DateTime date = DateTime.parse(formattedDate);

    int difference = DateTime.now().difference(date).inDays;
    int age = (difference / 365).round();
    return age.toString();
  }

  void updaetAddress(
      String custID, String title, String houseno, String street, String city) {
    DatabaseService().updateCustAddress(custID, title, houseno, street, city);
  }

  void removeAddress(String custID, String title) {
    print('********** inside remove address in profile view model :');
    DatabaseService().removeCustAddress(custID, title);
  }

//
//
// >>>>>>>>>>>>>>> A  D  D  I  N  G -- P  H  O  N  E -- N  U  M  B  E  R
//
//

  bool addphoneNO(String custID, String phoneNo, BuildContext context) {
    print('************ inside add phone no functrion in profile view model ');

    var updatedPhoneNo = phoneNo.replaceFirst(RegExp(r'0'), '+92');

    if (Validators().verifyPhoneNumber(phoneNo) == false) {
      print('inside validator if condition ....');
      print('Enter valid phone no i.e 03xxxxxxxxx');
      setErrorMessage('  Enter valid phone no i.e 03xxxxxxxxx');
      //TODO display dialg box here
      return false;
    } else {
      //
      // >>>>>>>>>>>>> Upon successful authentication
      DatabaseService().updateCustData({
        'phoneNo': updatedPhoneNo,
      }, custID);

      return true;
    }
  }

  goToStartPlan() {
    _navigationService.navigateTo(routes.CustStartPlanRoute);
  }

  DateTime calcMaxDate(Plan planData) {
    DateTime maxDate = DateTime.now();
    if (planData.custExercise.length > 0) {
      maxDate = DateTime.parse(planData.custExercise.keys.elementAt(0));

      planData.custExercise.forEach((key, value) {
        DateTime temp = DateTime.parse(key);
        if (temp.isAfter(maxDate)) {
          maxDate = temp;
        }
      });

      // dates.forEach((date) {
      //   if (date.isAfter(maxDate)) {
      //     maxDate = date;
      //   }
      // });
    } else if (planData.custMeals.length > 0) {
      maxDate = DateTime.parse(planData.custMeals.keys.elementAt(0));

      planData.custMeals.forEach((key, value) {
        DateTime temp = DateTime.parse(key);
        if (temp.isAfter(maxDate)) {
          maxDate = temp;
        }
      });
    }
    print('---------------max date is :' + maxDate.toString());
    return maxDate;
  }
}
