import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefProfileView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChefProfileMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);

    var dishStreamProvider,
        chefDataStreamProvider,
        dishCatgStreamProvider,
        usersDatastreamProvider,
        messagedocumentprovider,
        dishAttrStreamProvider,
        custDataStreamProvider;

    try {
      // - Chef data stream
      chefDataStreamProvider = StreamProvider<List<ChefData>>.value(
          value: DatabaseService().getAllChefData);
      // - Dish data stream
      dishStreamProvider = StreamProvider<List<Dish>>.value(
          value: DatabaseService().getAllDishData);
      // - DishCategory data stream
      dishCatgStreamProvider = StreamProvider<List<DishCategory>>.value(
          value: DatabaseService().getDishCatgData);
      // - Chef data stream
      dishAttrStreamProvider = StreamProvider<List<Attribute>>.value(
          value: DatabaseService().getDishAttrData);
      usersDatastreamProvider = StreamProvider<List<ChatUser>>.value(
          value: DatabaseService().getAllUserData);
      messagedocumentprovider = StreamProvider<List<String>>.value(
          value: DatabaseService().getallmessagedocument);
      custDataStreamProvider = StreamProvider<List<CustData>>.value(
          value: DatabaseService().getAllCustData);

      // print("========= chefDataStreamProvider : " +
      //     dishStreamProvider.toString());
    } catch (error) {
      print("-----> Error in ChefProfileMain : " + error.toString());
    }
    return MultiProvider(
      providers: [
        dishStreamProvider,
        chefDataStreamProvider,
        dishCatgStreamProvider,
        dishAttrStreamProvider,
        usersDatastreamProvider,
        messagedocumentprovider,
        custDataStreamProvider
      ],
      child: MaterialApp(home: ChefProfileView()),
    );
  }
}
