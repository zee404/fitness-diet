import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';

class CustAppDrawerViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future signOut() async {
    setState(ViewState.Busy);
    AuthService().signOut();
    _navigationService.navigateToWithPopandPushName(routes.HomeRoute);
    setState(ViewState.Idle);
  }

  goToProfile() {
    _navigationService.navigateToWithoutReplacement(routes.CustProfileRoute);
  }

  goToHome() {
    _navigationService.navigateToWithoutReplacement(routes.FoodMenuMainRoute);
  }
}
