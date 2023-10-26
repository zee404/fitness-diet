import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';
import 'package:fitness_diet/core/constants/route_paths.dart' as routes;

class DelivViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  dynamic verifiedUserID;
  Future signInDeliv(String phNo) async {
    setState(ViewState.Busy);
    bool dataValidated;
    var updatedPhoneNo = phNo.replaceFirst(RegExp(r'0'), '+92');
    String phoneNoAlreadyRegistered =
        await DatabaseService().isPhoneNoAlreadyRegistered(updatedPhoneNo);

    Validators().verifyPhoneNumber(phNo)
        ? dataValidated = true
        : dataValidated = false;

    if (phoneNoAlreadyRegistered == "deliv") {
      verifiedUserID = await AuthService().verifyPhone(updatedPhoneNo);

      if (verifiedUserID != null) {
        _navigationService.navigateTo(routes.DelivMainRoute);
      }

      if (dataValidated) {
        if (verifiedUserID != null) {
          setState(ViewState.Idle);
        } else {
          setState(ViewState.Idle);
          setErrorMessage(
              "   Something went wrong while\n   verification. Please try again");
        }
      } else {
        setState(ViewState.Idle);
        setErrorMessage("     Enter valid phone no i.e 03xxxxxxxxx");
      }
    } else {
      setState(ViewState.Idle);
      setErrorMessage(
          "   Try again with different number\n   Not registered by any customer");
    }
  }

// --------------------------- R E G I S T E R   D E L I V E R Y   G U Y   I N F O
  Future register(String phoneNo) async {
    var updatedPhoneNo = phoneNo.replaceFirst(RegExp(r'0'), '+92');
    setState(ViewState.Busy);

    String userID = getUser;
    print(
      "-----------> CustReg2ViewModel reached ========= register, userID: " +
          userID.toString(),
    );
    String phoneNoAlreadyRegistered =
        await DatabaseService().isPhoneNoAlreadyRegistered(phoneNo);
    //
    // >>>>>>>>>>>>> Validate phone no
    //
    if (Validators().verifyPhoneNumber(phoneNo) == false) {
      setErrorMessage('  Enter valid phone no i.e 03xxxxxxxxx');
      setState(ViewState.Idle);
    }
    //
    // >>>>>>>>>>>>> Check if user already registered
    //

    else if (phoneNoAlreadyRegistered != null) {
      setErrorMessage(
          '  This phone no is already registered. \n  Try again with new number');
      setState(ViewState.Idle);
      return false;
    } else {
      //
      // >>>>>>>>>>>>> Upon successful authentication
      //
      verifiedUserID = await AuthService().verifyPhone(updatedPhoneNo);
      if (verifiedUserID != null) {
        await DatabaseService(uid: verifiedUserID).addNewDelivData({
          'phoneNo': updatedPhoneNo,
        });
      }

      _navigationService.navigateTo(routes.DelivReg2Route);

      setState(ViewState.Idle);
    }
  }
// --------------------------- A D D   D E L I V E R Y   G U Y   I N F O

  Future addDelivData(String delivName, DateTime dateOfBirth) async {
    String userID = getUser;
    print(
      "-----------> CustReg2ViewModel reached ========= addDelivData, userID: " +
          userID.toString(),
    );
    bool dataValidated;
    setState(ViewState.Busy);
    Validators().verifyNameInputFeild(delivName) && dateOfBirth != null
        ? dataValidated = true
        : dataValidated = false;

    if (dataValidated) {
      bool check = await DatabaseService(uid: userID).addNewDelivData({
        'delivName': delivName,
        'delivDateOfBirth': dateOfBirth,
      });

      print("Data entered in the DataBase from CustReg2ViewModel status:" +
          check.toString());
      if (check) {
        _navigationService.navigateTo(routes.DelivMainRoute);
        setState(ViewState.Idle);
      }
    } else {
      setErrorMessage("   Registration failed\n   Add valid info");
      setState(ViewState.Idle);
    }
  }

// ----------------------------------------------------- G E T   O R D E R   S T A T U S
  List<int> getOrderStatusPreSelectedList(Order _order) {
    print(
        "---> Inside getOrderStatusPreSelectedList ftn of OrdersViewModel and _order.orderStatus: " +
            _order.orderStatus.toString() +
            " and length: " +
            _order.orderStatus.length.toString());
    List<int> _orderStatusPreSelectedList = [];

    for (int i = 0; i < _order.orderStatus.length; i++) {
      if (_order.orderStatus[i] == "ORDER_PLACED")
        _orderStatusPreSelectedList.add(1);

      if (_order.orderStatus[i] == "ORDER_PROCESSED")
        _orderStatusPreSelectedList.add(2);

      if (_order.orderStatus[i] == "ORDER_DISPATCHED")
        _orderStatusPreSelectedList.add(3);

      if (_order.orderStatus[i] == "ORDER_COMPLETED")
        _orderStatusPreSelectedList.add(4);

      if (_order.orderStatus[i] == "ORDER_CANCELLED")
        _orderStatusPreSelectedList.add(5);

      if (_order.orderStatus[i] == "ORDER_FAILED")
        _orderStatusPreSelectedList.add(6);
    }
    print("--- PRE-SELECTED : " + _orderStatusPreSelectedList.toString());
    return _orderStatusPreSelectedList;
  }

  Future<bool> updateOrderStatus(
      List<int> _updatedStatusList, String _orderID) async {
    setState(ViewState.Busy);

    List _orderStatusPreSelectedList = [];
    bool _updateResult = false;
    _updatedStatusList.sort();

    for (int i = 0; i < _updatedStatusList.length; i++) {
      if (_updatedStatusList[i] == 1)
        _orderStatusPreSelectedList.add("ORDER_PLACED");

      if (_updatedStatusList[i] == 2)
        _orderStatusPreSelectedList.add("ORDER_PROCESSED");

      if (_updatedStatusList[i] == 3)
        _orderStatusPreSelectedList.add("ORDER_DISPATCHED");

      if (_updatedStatusList[i] == 4)
        _orderStatusPreSelectedList.add("ORDER_COMPLETED");

      if (_updatedStatusList[i] == 5)
        _orderStatusPreSelectedList.add("ORDER_CANCELLED");

      if (_updatedStatusList[i] == 6)
        _orderStatusPreSelectedList.add("ORDER_FAILED");
    }

    _updateResult = await DatabaseService().updateOrderData(
        {"orderStatus": _orderStatusPreSelectedList}, _orderID);

    setState(ViewState.Idle);

    return _updateResult;
  }

  Future signOut() async {
    setState(ViewState.Busy);
    AuthService().signOut();
    _navigationService.navigateToWithPopandPushName(routes.HomeRoute);
    setState(ViewState.Idle);
  }

  goToDelivSignin() {
    _navigationService.navigateTo(routes.DelivSignRoute);
  }

  goToDelivReg1() {
    _navigationService.navigateTo(routes.DelivReg1Route);
  }
}
