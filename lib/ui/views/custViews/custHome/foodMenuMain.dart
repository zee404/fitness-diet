import 'package:fitness_diet/core/models/cart.dart';
import 'package:fitness_diet/core/models/disease.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/ui/views/custViews/custHome/foodMenuView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitness_diet/core/models/plan.dart';

class FoodMenuMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _custData = Provider.of<CurrentUser>(context);

    print("------> FoodMenuMain REACHED");
    var dishStreamProvider,
        chefDataStreamProvider,
        cartProvider,
        planStreamProvider,
        custStreamProvider,
        allCustStreamProvider;

    var diseaseStreamProvider;
    StreamProvider ordersStreamProvider;
    try {
      // - Dish data stream
      dishStreamProvider = StreamProvider<List<Dish>>.value(
          value: DatabaseService().getAllDishData);
      chefDataStreamProvider = StreamProvider<List<ChefData>>.value(
          value: DatabaseService().getAllChefData);

      custStreamProvider = StreamProvider<CustData>.value(
          value: DatabaseService(uid: _custData != null ? _custData.uid : null)
              .getCustData);
      allCustStreamProvider = StreamProvider<List<CustData>>.value(
          value: DatabaseService().getAllCustData);
      planStreamProvider = StreamProvider<Plan>.value(
          value: DatabaseService(uid: _custData != null ? _custData.uid : null)
              .getPlanData);
      cartProvider = StreamProvider<Cart>.value(
          value: DatabaseService()
              .getCartData(_custData != null ? _custData.uid : null));
      ordersStreamProvider = StreamProvider<List<Order>>.value(
        value: DatabaseService(uid: _custData != null ? _custData.uid : null)
            .getCustOrderData(),
      );

      diseaseStreamProvider = StreamProvider<List<Disease>>.value(
          value: DatabaseService().getAllDiseasesData());
    } catch (error) {
      print("-----> Error in ChefProfileMain : " + error.toString());
    }
    return MultiProvider(
      providers: [
        dishStreamProvider,
        chefDataStreamProvider,
        cartProvider,
        custStreamProvider,
        allCustStreamProvider,
        planStreamProvider,
        ordersStreamProvider,
        diseaseStreamProvider
      ],
      child: MaterialApp(home: FoodMenuView()),
    );
  }
}
