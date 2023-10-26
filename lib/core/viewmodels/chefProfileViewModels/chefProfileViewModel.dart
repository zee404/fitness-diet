import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';

class ChefProfileViewModel extends BaseViewModel {
  Stream<List<ChefData>> getSingleChefData(String currentChefID) {
    setState(ViewState.Busy);
    print("--> Inside getSingleChefData in ViewModel  " +
        currentChefID.toString());
    Stream<List<ChefData>> allChefsData =
        DatabaseService().getSingleChefData(currentChefID);
    print("--> Inside getSingleChefData in ViewModel  and allChefsData " +
        allChefsData.toString());
    setState(ViewState.Idle);
    return allChefsData;
  }
}
