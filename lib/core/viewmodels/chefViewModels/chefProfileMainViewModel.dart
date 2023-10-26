import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';

class ChefProfileMainViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  goBackToHome() {
    _navigationService.navigateTo(routes.HomeRoute);
  }
}
