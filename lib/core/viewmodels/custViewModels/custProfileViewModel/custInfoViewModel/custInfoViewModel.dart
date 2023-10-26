import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:intl/intl.dart';

class CustInfoViewModel extends BaseViewModel {
  String parseDate(DateTime firebasedate) {
    // DateTime newDate = DateTime.parse('2020-10-25 08:03:18.068031');

    var newFormat = DateFormat("dd-MMM-yyyy");
    return newFormat.format(firebasedate);
  }

  void removeAddress(String custID, String title) {
    print('********** inside remove address in profile view model :');
    DatabaseService().removeCustAddress(custID, title);
  }
}
