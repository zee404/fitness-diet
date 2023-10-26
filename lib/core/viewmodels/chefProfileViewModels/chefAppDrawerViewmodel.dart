import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';

class ChefAppDrawerViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future signOut() async {
    setState(ViewState.Busy);
    AuthService().signOut();
    setState(ViewState.Idle);
    _navigationService.navigateTo(routes.HomeRoute);
  }

  goToProfile() {
    _navigationService.navigateTo(routes.ChefProfileRoute);
  }

  goToChefOrdersView() {
    _navigationService.navigateTo(routes.ChefOrdersView);
  }
}
