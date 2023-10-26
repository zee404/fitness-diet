import 'package:fitness_diet/core/models/API_MODELS/edamamJSONModel.dart';
import 'package:flutter/material.dart';

List<IngredientInfo> newUpdatedIngrInfo = [];

// ignore: must_be_immutable
class NewSingleDishIngr extends StatefulWidget {
  IngredientInfo singleFood;
  NewSingleDishIngr({@required this.singleFood});

  @override
  _NewSingleDishIngrState createState() => _NewSingleDishIngrState();
}

class _NewSingleDishIngrState extends State<NewSingleDishIngr> {
  String isCurrentSelected = "gram"; // else case = "tsp" or "cup"

  @override
  Widget build(BuildContext context) {
    // ------------------ ADDING UPCOMING FOOD ITEM IN GLOBAL LIST IF NOT ALREADY EXIST

    if (newUpdatedIngrInfo != null) {
      int _foodExistingCount = 0;
      for (int i = 0; i < newUpdatedIngrInfo.length; i++) {
        if (widget.singleFood.ingredients[0].text ==
            newUpdatedIngrInfo[i].ingredients[0].text) {
          print("O M G  INSIDE : newUpdatedIngrInfo[i].ingredients[0].text : " +
              newUpdatedIngrInfo[i].ingredients[0].text.toString());
          _foodExistingCount++;
        }
      }
      if (_foodExistingCount == 0) {
        print("O M G  INSIDE and equal to " + _foodExistingCount.toString());
        newUpdatedIngrInfo.add(widget.singleFood);
      }
    }

    // * G E T T I N G   N U T R I E N T S   V A L U E S
    double _proteinAmount =
        widget.singleFood.ingredients[0].parsed[0].nutrients["PROCNT"].quantity;
    double _fatsAmount =
        widget.singleFood.ingredients[0].parsed[0].nutrients["FAT"].quantity;
    double _carbsAmount =
        widget.singleFood.ingredients[0].parsed[0].nutrients["CHOCDF"].quantity;
    double _caloriesAmount = widget
        .singleFood.ingredients[0].parsed[0].nutrients["ENERC_KCAL"].quantity;

    // * G E T T I N G   N U T R I E N T S   U N I T S
    // String _proteinUnit = widget
    //     .singleFood.ingredients[0].parsed[0].nutrients["PROCNT"].unit
    //     .toString();
    // String _fatsUnit = widget
    //     .singleFood.ingredients[0].parsed[0].nutrients["PROCNT"].unit
    //     .toString();
    // String _carbsUnit = widget
    //     .singleFood.ingredients[0].parsed[0].nutrients["PROCNT"].unit
    //     .toString();
    // String _caloriesUnit = widget
    //     .singleFood.ingredients[0].parsed[0].nutrients["PROCNT"].unit
    //     .toString();

    // final deviceSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // -------------------------------------------------- N U T R I E N T   I N F O
          ListTile(
            title: Text(widget.singleFood.ingredients[0].text.toString()),
            subtitle: Text(
              _caloriesAmount.toStringAsFixed(2).toString() +
                  " Kcal , Prot: " +
                  _proteinAmount.toStringAsFixed(2).toString() +
                  " G , Carbs: " +
                  _carbsAmount.toStringAsFixed(2).toString() +
                  " G , Fats: " +
                  _fatsAmount.toStringAsFixed(2).toString(),
            ),
          ),
        ],
      ),
    );
  }
}
