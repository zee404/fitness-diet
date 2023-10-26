import 'package:fitness_diet/core/models/disease.dart';
import 'package:fitness_diet/core/models/exercise.dart';
import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custProfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustProfileMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);

    var custStreamProvider;
    var planStreamProvider;
    var ordersStreamProvider;
    var usersDatastreamProvider;
    var chefDataStreamProvider;
    var exerciseStreamProvider;
    var messagedocumentprovider;
    var diseaseStreamProvider;

    try {
      chefDataStreamProvider = StreamProvider<List<ChefData>>.value(
          value: DatabaseService().getAllChefData);
      custStreamProvider = StreamProvider<CustData>.value(
          value: DatabaseService(uid: user.uid).getCustData);
      planStreamProvider = StreamProvider<Plan>.value(
          value: DatabaseService(uid: user.uid).getPlanData);
      ordersStreamProvider = StreamProvider<List<Order>>.value(
          value: DatabaseService(uid: user != null ? user.uid : null)
              .getCustOrderData());
      exerciseStreamProvider = StreamProvider<List<Exercise>>.value(
          value: DatabaseService().getAllExercises());
      usersDatastreamProvider = StreamProvider<List<ChatUser>>.value(
          value: DatabaseService().getAllUserData);
      diseaseStreamProvider = StreamProvider<List<Disease>>.value(
          value: DatabaseService().getAllDiseasesData());
      messagedocumentprovider = StreamProvider<List<String>>.value(
          value: DatabaseService().getallmessagedocument);
    } catch (e) {
      print("--------> Error in custProfileMain: " + e.toString());
    }
    return MultiProvider(
      providers: [
        custStreamProvider,
        planStreamProvider,
        ordersStreamProvider,
        exerciseStreamProvider,
        chefDataStreamProvider,
        usersDatastreamProvider,
        messagedocumentprovider,
        diseaseStreamProvider,
      ],
      child: MaterialApp(
        home: CustProfile(),
        //   ),
      ),
    );
  }
}
