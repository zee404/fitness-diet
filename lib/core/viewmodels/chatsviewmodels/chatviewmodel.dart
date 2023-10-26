import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';

class ChatViewModel extends BaseViewModel {
  // Future<bool> checkuser(String uid) async {
  //   String user = await DatabaseService().checkUserID(uid);
  //   return user == 'cust' ? true : false;
  // }
  bool checkuser(String uid) {
    return true;
  }

  // Future<List<ChefData>> getallchefdata() async {
  //   // List<ChefData> cheflist = await DatabaseService().getAllChefData;
  // }

  bool checkUserinChef(String uid, List<ChefData> cheflist) {
    for (int i = 0; i < cheflist.length; i++) {
      if (cheflist.elementAt(i).chefID == uid) {
        return true;
      }
    }

    return false;
  }

  bool checkalreadychated(String chatid, List<String> messgaedocuments) {
    for (int i = 0; i < messgaedocuments.length; i++) {
      if (messgaedocuments.elementAt(i) == chatid) {
        return true;
      }
    }
    return false;
  }

  // Future<List<String>> getmessagedocuments() async {
  //   //  List<String> list = await DatabaseService().getallmessagedocument;
  // }
}
