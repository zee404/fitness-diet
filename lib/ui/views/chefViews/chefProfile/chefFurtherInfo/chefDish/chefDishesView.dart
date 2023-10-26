import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/chefProfileViewModels/chefDishViewModels/chefDishesViewModel.dart';
import 'package:fitness_diet/globals.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefFurtherInfo/chefDish/addDish/editDishInfoView.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefFurtherInfo/chefDish/chefSoleDishView.dart';
import 'package:fitness_diet/ui/views/soleDishView.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardText1.dart';
import 'package:fitness_diet/ui/widgets/dishViewSingleListItemDesign.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingNoBg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addDish/addDishInfoView.dart';

// ignore: must_be_immutable
class ChefDishes extends StatefulWidget {
  String chefID;
  bool isfromchef;
  ChefDishes({@required this.chefID, @required this.isfromchef});
  @override
  _ChefDishesState createState() => _ChefDishesState();
}

class _ChefDishesState extends State<ChefDishes> {
  @override
  Widget build(BuildContext context) {
    final _chefDish = Provider.of<List<Dish>>(context);
    final _chefData = Provider.of<List<ChefData>>(context);
    final _user = Provider.of<CurrentUser>(context);

    // int count = 0;
    // print("---------> _chefData inside chefDishes: " + _chefData.toString());

    return BaseView<ChefDishesViewmodel>(
      onModelReady: (model) async {
        String currentChefID = widget.chefID;

        print("currentChefID: " + currentChefID.toString());
      },
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, widgetSize) => Scaffold(
          body: ListView(
            children: <Widget>[
              // ----------- A D D   D I S H   B T N
              widget.isfromchef
                  ? FlatButton(
                      onPressed: () {
                        currentIngrList = [];
                        return Navigator.push(
                          (context),
                          MaterialPageRoute(
                            builder: (context) => AddDishInfo(),
                          ),
                        );
                      },
                      child: Text("Add new dish"),
                    )
                  : SizedBox(),
              // ----------- A V A L A I B L E   D I S H E S   H E A D I N G
              Container(
                padding: EdgeInsets.only(left: widgetSize.width * 0.025),
                child: StandardHeadingNoBg(
                  passedText: "Available dishes",
                ),
              ),
              SizedBox(height: 10),
              Divider(
                height: 2,
                thickness: 2,
                color: Colors.black12,
                endIndent: 10,
                indent: 10,
              ),
              // ----------- D I S H E S   L I S T
              SizedBox(height: 15),
              _chefDish == null
                  ? Loading()
                  : Column(
                      children: _chefDish.map((dish) {
                        // count += 1;

                        // if (dish.chefID == _user.uid) {
                        return dish.chefID == widget.chefID
                            ? InkWell(
                                onTap: () async {
                                  print(" dish: " + dish.dishID);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => widget.isfromchef
                                          ? ChefSoleDishView(
                                              passedDish: dish,
                                              isFromCustView: false,
                                            )
                                          : SoleDishView(
                                              isFromCustView: true,
                                              passedDish: dish,
                                            ),
                                    ),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(height: 10),
                                    DishViewSingleListItemDesign(
                                      dishName: dish.dishName,
                                      chefName: model.getChefNameManually(
                                          dish.chefID, _chefData),
                                      kcal: dish.dishKcal,
                                      price: dish.dishPrice,
                                      ratings: dish.dishRatings,
                                      dishPic: dish.dishPic,
                                    ),
                                  ],
                                ),
                              )
                            : Container();
                        // } else {
                        //   return Container();
                        // }
                      }).toList(),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
