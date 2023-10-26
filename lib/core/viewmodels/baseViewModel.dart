import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  String _errorMessage;
  ViewState get state => _state;
  // final NavigationService navigationService = locator<NavigationService>();

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  String get errorMessage => _errorMessage;
  bool get hasErrorMessage => _errorMessage != null && _errorMessage.isNotEmpty;
  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  // FirebaseUser baseUser;
  String get getUser {
    setState(ViewState.Busy);
    User baseUser;
    baseUser = FirebaseAuth.instance.currentUser;
    // print('current user in baseview model ' + baseUser.toString());
    setState(ViewState.Idle);
    if (baseUser == null) {
      return null;
    } else {
      return baseUser.uid;
    }
  }

//  dynamic x = AuthService().user;

  // void setUser(String user) {
  //   _userID = user;
  //   notifyListeners();
  // }

}
