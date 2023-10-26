import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  gotToCustSignIn() {
    _navigationService.navigateToWithoutReplacement(routes.CustSignRoute);
  }

  gotToDelivSignIn() {
    _navigationService.navigateToWithoutReplacement(routes.DelivSignRoute);
  }

  gotToChefSignIn() {
    _navigationService.navigateToWithoutReplacement(routes.ChefSignRoute);
  }

  gotToFoodMenu() {
    _navigationService.navigateToWithoutReplacement(routes.FoodMenuMainRoute);
  }

  Future redirectSignedInUser(String userID) async {
    // setState(ViewState.Busy);
    String user = await DatabaseService().checkUserID(userID);

    if (user.toString() == "cust") {
      print("user and ID form inside the HomeViewModel: " +
          user.toString() +
          " - " +
          userID);
      _navigationService.navigateTo(routes.FoodMenuMainRoute);
      // setState(ViewState.Idle);
    } else if (user.toString() == "chef") {
      print("user and ID form inside the HomeViewModel: " +
          user.toString() +
          " - " +
          userID);
      _navigationService.navigateTo(routes.ChefProfileRoute);
      // setState(ViewState.Idle);
      print("Check User ID result: " + user.toString());
    } else if (user.toString() == "deliv") {
      print("user and ID form inside the HomeViewModel: " +
          user.toString() +
          " - " +
          userID);
      _navigationService.navigateTo(routes.DelivMainRoute);
      // setState(ViewState.Idle);
      print("Check User ID result: " + user.toString());
    }
  }
}
