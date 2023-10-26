import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/DatabaseServices/dbHelperFtns.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';

class ChefDishesViewmodel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  var _currentUser;

  Future getChefName(String _chefID) async {
    String _chefName = await DBHelperFtns().documentIDToName(
        DatabaseService().chefCollection, "chefID", "chefName", _chefID);
    return _chefName;
  }

  String getChefNameManually(
      String passedChefID, List<ChefData> passedChefData) {
    String _chefName = "";
    for (int i = 0; i < passedChefData.length; i++) {
      if (passedChefData[i].chefID == passedChefID) {
        _chefName = passedChefData[i].chefName;
        break;
      }
    }
    return _chefName;
  }

  Future isDishAvalaible() async {
    setState(ViewState.Busy);
    _currentUser = getUser;
    bool _chefHaveDishes = await DBHelperFtns().feildExistInCollection(
        DatabaseService().dishCollection, "chefID", _currentUser);
    setState(ViewState.Idle);
    return _chefHaveDishes;
  }

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

  ChefData extractedChefData(List<ChefData> _allChefsData, String chefID) {
    ChefData _chefData;
    for (int i = 0; i < _allChefsData.length; i++) {
      if (_allChefsData[i].chefID == chefID) {
        _chefData = _allChefsData[i];
      }
    }
    return _chefData;
  }

  getChefImage() {}
  gotTodishMenu() {
    _navigationService.navigateTo(routes.SoleDishRoute);
  }
}
