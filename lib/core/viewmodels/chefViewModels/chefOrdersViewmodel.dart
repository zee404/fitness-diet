import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';

class ChefOrdersViewModel extends BaseViewModel {
  Stream<List<Order>> getAllOrders() {
    setState(ViewState.Busy);
    Stream<List<Order>> _allOrderStream = DatabaseService().getAllOrdersData();

    setState(ViewState.Idle);
    return _allOrderStream;
  }

  Stream<List<Order>> getSingleOrderInfo(String orderID) {
    setState(ViewState.Busy);
    Stream<List<Order>> singleOrderStream =
        DatabaseService().getSingleOrderData(orderID.trim());
    setState(ViewState.Idle);
    print(
        '************* inside getOrders in productlistView model orderIDID is ' +
            orderID);
    return singleOrderStream;
  }

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

  CustData getSingleCustInfo(List<CustData> _custData, String passedCustID) {
    CustData _singleCustData;
    for (int i = 0; i < _custData.length; i++) {
      if (_custData[i].custId == passedCustID) {
        _singleCustData = _custData[i];
      }
    }
    return _singleCustData;
  }
}
