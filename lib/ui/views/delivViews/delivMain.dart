import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/ui/views/delivViews/delivProfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DelivMainDataProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);

    var delivStreamProvider;
    var ordersStreamProvider;

    try {
      delivStreamProvider = StreamProvider<DelivData>.value(
          value: DatabaseService(uid: user.uid).getDelivData);

      ordersStreamProvider = StreamProvider<List<Order>>.value(
          value: DatabaseService().getAllOrdersData());
    } catch (e) {
      print("--------> Error in custProfileMain: " + e.toString());
    }
    return MultiProvider(
      providers: [
        delivStreamProvider,
        ordersStreamProvider,
      ],
      child: MaterialApp(
        home: DelivProfile(),
      ),
    );
  }
}
