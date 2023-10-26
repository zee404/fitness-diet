import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/dialogService.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/core/viewmodels/chatsviewmodels/chatviewmodel.dart';
import 'package:fitness_diet/core/viewmodels/chefProfileViewModels/chefAppDrawerViewmodel.dart';
import 'package:fitness_diet/core/viewmodels/chefProfileViewModels/chefDishViewModels/addDishViewModel.dart';
import 'package:fitness_diet/core/viewmodels/chefProfileViewModels/chefDishViewModels/chefDishesViewModel.dart';
import 'package:fitness_diet/core/viewmodels/chefProfileViewModels/chefDishViewModels/newDishViewModel.dart';
import 'package:fitness_diet/core/viewmodels/chefProfileViewModels/chefProfileEditViewModel.dart';
import 'package:fitness_diet/core/viewmodels/chefProfileViewModels/chefProfileViewModel.dart';
import 'package:fitness_diet/core/viewmodels/chefViewModels/auth/chefReg2ViewModel.dart';
import 'package:fitness_diet/core/viewmodels/chefViewModels/auth/chefRegViewModel.dart';
import 'package:fitness_diet/core/viewmodels/chefViewModels/auth/chefSignInViewModel.dart';
import 'package:fitness_diet/core/viewmodels/chefViewModels/chefOrdersViewmodel.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/auth/custReg2ViewModel.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/auth/custRegViewModel.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/auth/custSignInViewModel.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/cartViewModel.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custAppDrawerViewModel.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custInfoViewModel/custInfoViewModel.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custPlanViewModel.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custProfileEditViewModel.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custProfileViewmodel.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/foodmenueViewModel.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/orderViewModel.dart';
import 'package:fitness_diet/core/viewmodels/delivViewModel.dart';
import 'package:fitness_diet/core/viewmodels/homeViewModel.dart';
import 'package:fitness_diet/core/viewmodels/loginViewModel.dart';
import 'package:fitness_diet/core/viewmodels/searchviewModel.dart';
import 'package:fitness_diet/core/viewmodels/soleDishViewModel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

// * This is where we register all our services and models
void setupLocator() {
  // * Lazy -  There will be only one instance of the service and
  //           will only be created once the service is required for the first time

  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  // locator.registerLazySingleton(() => Api());

  locator.registerFactory(() => LoginViewModel());

  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => BaseViewModel());
  locator.registerFactory(() => SoleDishViewModel());
  locator.registerFactory(() => ChatViewModel());
  locator.registerFactory(() => SearchviewModel());
  // Customer
  locator.registerFactory(() => CustRegViewModel());
  locator.registerFactory(() => CustReg2ViewModel());
  locator.registerFactory(() => CustSignInViewModel());
  locator.registerFactory(() => CustProfileViewModel());
  locator.registerFactory(() => CustAppDrawerViewModel());
  locator.registerFactory(() => CustInfoViewModel());
  locator.registerFactory(() => CustPlanViewModel());
  locator.registerFactory(() => CustProfileEditViewModel());
  locator.registerFactory(() => FoodMenueViewModel());
  locator.registerFactory(() => CartViewModel());
  locator.registerFactory(() => OrderViewModel());

  // Chef
  locator.registerFactory(() => ChefRegViewModel());
  locator.registerFactory(() => ChefReg2ViewModel());
  locator.registerFactory(() => ChefSignInViewModel());
  locator.registerFactory(() => ChefAppDrawerViewModel());
  locator.registerFactory(() => AddDishViewModel());
  locator.registerFactory(() => ChefDishesViewmodel());
  locator.registerFactory(() => ChefProfileEditViewModel());
  locator.registerFactory(() => ChefProfileViewModel());
  locator.registerFactory(() => ChefOrdersViewModel());
  locator.registerFactory(() => NewAddDishViewModel());

  // locator.registerFactory(() => IngrViewModel());

  // Deliv
  locator.registerFactory(() => DelivViewModel());
}
