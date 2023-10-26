import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/models/API_MODELS/FoodCentralJSONModel.dart';
import 'package:fitness_diet/ui/widgets/Buttons/tinyLeftBtn.dart';
import 'package:fitness_diet/ui/widgets/Buttons/tinyRightBtn.dart';
import 'package:flutter/material.dart';

List<FoodInfo> updatedIngrInfo = [];

// ignore: must_be_immutable
class SingleDishIngr extends StatefulWidget {
  FoodInfo singleFood;
  SingleDishIngr({@required this.singleFood});

  @override
  _SingleDishIngrState createState() => _SingleDishIngrState();
}

class _SingleDishIngrState extends State<SingleDishIngr> {
  int _singleFoodItemCount = 1;

  String isCurrentSelected = "gram"; // else case = "tsp" or "cup"

  @override
  Widget build(BuildContext context) {
    // ------------------ ADDING UPCOMING FOOD ITEM IN GLOBAL LIST IF NOT ALREADY EXIST

    if (updatedIngrInfo.length != 0) {
      int _foodExistingCount = 0;
      for (int i = 0; i < updatedIngrInfo.length; i++) {
        if (widget.singleFood.fdcId == updatedIngrInfo[i].fdcId) {
          print("O M G  INSIDE : updatedIngrInfo[i].fdcId : " +
              updatedIngrInfo[i].fdcId.toString());
          _foodExistingCount++;
        }
      }
      if (_foodExistingCount == 0) {
        print("O M G  INSIDE and equal to " + _foodExistingCount.toString());
        updatedIngrInfo.add(widget.singleFood);
      }
    }

    // * G E T T I N G   N U T R I E N T S   V A L U E S
    double _proteinAmount = double.parse(ConstantFtns().getStringAfterCharacter(
        widget.singleFood.foodNutrients[0].amount.toString(), " "));
    double _fatsAmount = double.parse(ConstantFtns().getStringAfterCharacter(
        widget.singleFood.foodNutrients[1].amount.toString(), " "));
    double _carbsAmount = double.parse(ConstantFtns().getStringAfterCharacter(
        widget.singleFood.foodNutrients[2].amount.toString(), " "));
    double _caloriesAmount = double.parse(ConstantFtns()
        .getStringAfterCharacter(
            widget.singleFood.foodNutrients[3].amount.toString(), " "));

    // * G E T T I N G   N U T R I E N T S   U N I T S
    String _proteinUnit = ConstantFtns().getStringAfterCharacter(
        widget.singleFood.foodNutrients[0].unitName.toString(), ".");
    String _fatsUnit = ConstantFtns().getStringAfterCharacter(
        widget.singleFood.foodNutrients[1].unitName.toString(), ".");
    String _carbsUnit = ConstantFtns().getStringAfterCharacter(
        widget.singleFood.foodNutrients[2].unitName.toString(), ".");
    String _caloriesUnit = ConstantFtns().getStringAfterCharacter(
        widget.singleFood.foodNutrients[3].unitName.toString(), ".");

    // final deviceSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // -------------------------------------------------- U N I T    B T N S

          Row(
            children: [
              //* G R A M S
              Expanded(
                child: InkWell(
                  onTap: () {
                    String _tempPrevious = isCurrentSelected;
                    if (_tempPrevious != "gram") {
                      double _newKcalValue, _newProtein, _newFats, _newCarbs;
                      // >>>> P R E V I O U S   U N I T   I S   C U P   O R   T S P
                      // >>>> T H E N   U P D A T E   N U T R I E N T S   A C C O R D I N G L Y
                      if (_tempPrevious == "tsp") {
                        _newKcalValue = ConstantFtns().tablespoonToGram(
                            widget.singleFood.foodNutrients[3].amount);
                        _newProtein = ConstantFtns().tablespoonToGram(
                            widget.singleFood.foodNutrients[0].amount);
                        _newFats = ConstantFtns().tablespoonToGram(
                            widget.singleFood.foodNutrients[1].amount);
                        _newCarbs = ConstantFtns().tablespoonToGram(
                            widget.singleFood.foodNutrients[2].amount);
                      } else if (_tempPrevious == "cup") {
                        _newProtein = ConstantFtns().cupsToGram(
                            widget.singleFood.foodNutrients[0].amount);
                        _newFats = ConstantFtns().cupsToGram(
                            widget.singleFood.foodNutrients[1].amount);
                        _newCarbs = ConstantFtns().cupsToGram(
                            widget.singleFood.foodNutrients[2].amount);
                        _newKcalValue = ConstantFtns().cupsToGram(
                            widget.singleFood.foodNutrients[3].amount);
                      }
                      setState(() {
                        widget.singleFood.foodNutrients[0].amount = _newProtein;
                        widget.singleFood.foodNutrients[1].amount = _newFats;
                        widget.singleFood.foodNutrients[2].amount = _newCarbs;
                        widget.singleFood.foodNutrients[3].amount =
                            _newKcalValue;

                        isCurrentSelected = "gram";

                        print("  G R A M S    S E L E C T E D: " +
                            isCurrentSelected.toString());
                      });
                    }
                  },
                  child: TinyLeftBtn(
                    isSelected: isCurrentSelected == "gram" ? true : false,
                    passedText: "Grams",
                  ),
                ),
              ),
              SizedBox(width: 2),
              //* T A B L E S P O O N
              Expanded(
                child: InkWell(
                  onTap: () {
                    String _tempPrevious = isCurrentSelected;
                    if (_tempPrevious != "tsp") {
                      double _newKcalValue, _newProtein, _newFats, _newCarbs;
                      // >>>> P R E V I O U S   U N I T   I S   G R A M   O R   C U P
                      // >>>> T H E N   U P D A T E   N U T R I E N T S   A C C O R D I N G L Y
                      if (_tempPrevious == "gram") {
                        _newProtein = ConstantFtns().gramsToTablespoon(
                            widget.singleFood.foodNutrients[0].amount);
                        _newFats = ConstantFtns().gramsToTablespoon(
                            widget.singleFood.foodNutrients[1].amount);
                        _newCarbs = ConstantFtns().gramsToTablespoon(
                            widget.singleFood.foodNutrients[2].amount);
                        _newKcalValue = ConstantFtns().gramsToTablespoon(
                            widget.singleFood.foodNutrients[3].amount);
                      } else if (_tempPrevious == "cup") {
                        _newProtein = ConstantFtns().cupsToTablespoon(
                            widget.singleFood.foodNutrients[0].amount);
                        _newFats = ConstantFtns().cupsToTablespoon(
                            widget.singleFood.foodNutrients[1].amount);
                        _newCarbs = ConstantFtns().cupsToTablespoon(
                            widget.singleFood.foodNutrients[2].amount);
                        _newKcalValue = ConstantFtns().cupsToTablespoon(
                            widget.singleFood.foodNutrients[3].amount);
                      }
                      setState(() {
                        widget.singleFood.foodNutrients[0].amount = _newProtein;
                        widget.singleFood.foodNutrients[1].amount = _newFats;
                        widget.singleFood.foodNutrients[2].amount = _newCarbs;
                        widget.singleFood.foodNutrients[3].amount =
                            _newKcalValue;
                        isCurrentSelected = "tsp";

                        print(" T A B L E S P O O N    S E L E C T E D: " +
                            isCurrentSelected.toString());
                      });
                    }
                  },
                  child: Container(
                    color:
                        isCurrentSelected == "tsp" ? Colors.brown : Colors.grey,
                    child: Center(
                      child: Text(
                        "Tablespoon",
                        style: TextStyle(
                          color: isCurrentSelected == "tsp"
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 2),
              //* C U P S
              Expanded(
                child: InkWell(
                  onTap: () {
                    String _tempPrevious = isCurrentSelected;

                    if (_tempPrevious != "cup") {
                      double _newKcalValue, _newProtein, _newFats, _newCarbs;
                      // >>>> P R E V I O U S   U N I T   I S   G R A M   O R   T S P
                      // >>>> T H E N   U P D A T E   N U T R I E N T S   A C C O R D I N G L Y
                      if (_tempPrevious == "gram") {
                        _newProtein = ConstantFtns().gramsToCups(
                            widget.singleFood.foodNutrients[0].amount);
                        _newFats = ConstantFtns().gramsToCups(
                            widget.singleFood.foodNutrients[1].amount);
                        _newCarbs = ConstantFtns().gramsToCups(
                            widget.singleFood.foodNutrients[2].amount);
                        _newKcalValue = ConstantFtns().gramsToCups(
                            widget.singleFood.foodNutrients[3].amount);
                      } else if (_tempPrevious == "tsp") {
                        _newProtein = ConstantFtns().tablespoonToCup(
                            widget.singleFood.foodNutrients[0].amount);
                        _newFats = ConstantFtns().tablespoonToCup(
                            widget.singleFood.foodNutrients[1].amount);
                        _newCarbs = ConstantFtns().tablespoonToCup(
                            widget.singleFood.foodNutrients[2].amount);
                        _newKcalValue = ConstantFtns().tablespoonToCup(
                            widget.singleFood.foodNutrients[3].amount);
                      }
                      setState(() {
                        widget.singleFood.foodNutrients[0].amount = _newProtein;
                        widget.singleFood.foodNutrients[1].amount = _newFats;
                        widget.singleFood.foodNutrients[2].amount = _newCarbs;
                        widget.singleFood.foodNutrients[3].amount =
                            _newKcalValue;
                        isCurrentSelected = "cup";

                        print(" C U P S    S E L E C T E D: " +
                            isCurrentSelected.toString());
                      });
                    }
                  },
                  child: TinyRightBtn(
                    passedText: "Cups",
                    isSelected: isCurrentSelected == "cup" ? true : false,
                  ),
                ),
              ),
            ],
          ),
          // -------------------------------------------------- N U T R I E N T   I N F O
          ListTile(
            title: Text(widget.singleFood.description.toString()),
            subtitle: isCurrentSelected == "gram"
                ? Text(
                    _caloriesAmount.toStringAsFixed(2).toString() +
                        " " +
                        _caloriesUnit +
                        ", Prot: " +
                        _proteinAmount.toStringAsFixed(2).toString() +
                        " " +
                        _proteinUnit +
                        ", Carbs " +
                        _carbsAmount.toStringAsFixed(2).toString() +
                        " " +
                        _carbsUnit +
                        ", Fats " +
                        _fatsAmount.toStringAsFixed(2).toString() +
                        " " +
                        _fatsUnit +
                        " \nper 100g",
                  )
                : Text(
                    _caloriesAmount.toStringAsFixed(2).toString() +
                        " " +
                        _caloriesUnit +
                        ", Prot: " +
                        _proteinAmount.toStringAsFixed(2).toString() +
                        " " +
                        _proteinUnit +
                        ", Carbs " +
                        _carbsAmount.toStringAsFixed(2).toString() +
                        " " +
                        _carbsUnit +
                        ", Fats " +
                        _fatsAmount.toStringAsFixed(2).toString() +
                        " " +
                        _fatsUnit +
                        " \nper $isCurrentSelected",
                  ),
            // -------------------------------------------------- A D D   /   R E M O V E   B U T T O N
            trailing: Container(
              margin: EdgeInsets.only(bottom: 10.0),
              alignment: Alignment.center,
              height: 25.0,
              width: 80.0,
              decoration: BoxDecoration(
                color: Color(0xffE4E4E4),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //* >>>>>>>>>>>>>>>>>  Remove button
                  InkWell(
                    onTap: () {
                      setState(() {
                        // //  _currentIngrList.remove(widget.singleFood);
                        // _singleFoodItemCount = 1;

                        widget.singleFood.foodNutrients[0].amount =
                            (widget.singleFood.foodNutrients[0].amount /
                                _singleFoodItemCount);
                        widget.singleFood.foodNutrients[0].amount *=
                            _singleFoodItemCount - 1;
                        //____
                        widget.singleFood.foodNutrients[1].amount =
                            (widget.singleFood.foodNutrients[1].amount /
                                _singleFoodItemCount);
                        widget.singleFood.foodNutrients[1].amount *=
                            _singleFoodItemCount - 1;
                        //____
                        widget.singleFood.foodNutrients[2].amount =
                            (widget.singleFood.foodNutrients[2].amount /
                                _singleFoodItemCount);
                        widget.singleFood.foodNutrients[2].amount *=
                            _singleFoodItemCount - 1;
                        //___
                        print(
                            "============================= single kcal before: " +
                                widget.singleFood.foodNutrients[3].amount
                                    .toString());
                        widget.singleFood.foodNutrients[3].amount =
                            (widget.singleFood.foodNutrients[3].amount /
                                _singleFoodItemCount);
                        widget.singleFood.foodNutrients[3].amount *=
                            _singleFoodItemCount - 1;
                        //___

                        print("============================= Updated kcal: " +
                            widget.singleFood.foodNutrients[3].amount
                                .toString() +
                            " count: " +
                            _singleFoodItemCount.toString());

                        print("=============================  count: " +
                            _singleFoodItemCount.toString());
                        _singleFoodItemCount -= 1;
                        if (_singleFoodItemCount < 1) {
                          _singleFoodItemCount = 1;
                        }
                      });
                    },
                    child: Icon(
                      Icons.remove_circle,
                      color: Colors.green,
                    ),
                  ),
                  //* >>>>>>>>>>>>>>>>>  Ingredient
                  Text(_singleFoodItemCount.toString()),
                  //* >>>>>>>>>>>>>>>>>  Add button
                  InkWell(
                    onTap: () {
                      setState(() {
                        // * Converting nutrient values back to orginal
                        widget.singleFood.foodNutrients[0].amount =
                            (widget.singleFood.foodNutrients[0].amount /
                                _singleFoodItemCount);
                        widget.singleFood.foodNutrients[0].amount *=
                            _singleFoodItemCount + 1;

                        //___
                        widget.singleFood.foodNutrients[1].amount =
                            (widget.singleFood.foodNutrients[1].amount /
                                _singleFoodItemCount);
                        widget.singleFood.foodNutrients[1].amount *=
                            _singleFoodItemCount + 1;
                        //___
                        widget.singleFood.foodNutrients[2].amount =
                            (widget.singleFood.foodNutrients[2].amount /
                                _singleFoodItemCount);
                        widget.singleFood.foodNutrients[2].amount *=
                            _singleFoodItemCount + 1;
                        //___
                        print(
                            "============================= single kcal before: " +
                                widget.singleFood.foodNutrients[3].amount
                                    .toString());
                        widget.singleFood.foodNutrients[3].amount =
                            (widget.singleFood.foodNutrients[3].amount /
                                _singleFoodItemCount);
                        widget.singleFood.foodNutrients[3].amount *=
                            _singleFoodItemCount + 1;
                        //___
                        print("============================= Updated kcal: " +
                            widget.singleFood.foodNutrients[3].amount
                                .toString() +
                            " count: " +
                            _singleFoodItemCount.toString());
                        _singleFoodItemCount += 1;
                      });
                      print("=============================  count: " +
                          _singleFoodItemCount.toString() +
                          "\n _______________________________________________________________________________________________________");
                    },
                    child: Icon(Icons.add_circle, color: Colors.green),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> A D D   /   R E M O V E   B U T T O N
//             trailing: Container(
//               margin: EdgeInsets.only(bottom: 10.0),
//               alignment: Alignment.center,
//               height: 25.0,
//               width: 80.0,
//               decoration: BoxDecoration(
//                 color: Color(0xffE4E4E4),
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   //* >>>>>>>>>>>>>>>>>  Remove button
//                   InkWell(
//                     onTap: () {
//                       setState(() {
//                         _proteinAmount =
//                             (_proteinAmount / _singleFoodItemCount);
//                         _proteinAmount *= _singleFoodItemCount - 1;
//                         //____
//                         _fatsAmount = (_fatsAmount / _singleFoodItemCount);
//                         _fatsAmount *= _singleFoodItemCount - 1;
//                         //____
//                         _carbsAmount = (_carbsAmount / _singleFoodItemCount);
//                         _carbsAmount *= _singleFoodItemCount - 1;
//                         //___
//                         print(
//                             "============================= single kcal before: " +
//                                 _caloriesAmount.toString());
//                         _caloriesAmount =
//                             (_caloriesAmount / _singleFoodItemCount);
//                         _caloriesAmount *= _singleFoodItemCount - 1;
//                         //___

//                         print("============================= Updated kcal: " +
//                             _caloriesAmount.toString() +
//                             " count: " +
//                             _singleFoodItemCount.toString());

//                         _singleFoodItemCount -= 1;
//                         print("=============================  count: " +
//                             _singleFoodItemCount.toString());

//                         // * If 0
//                         if (_singleFoodItemCount == 0) {
//                           //  _currentIngrList.remove(widget.singleFood);
//                           _singleFoodItemCount = 0;
//                         }
//                       });
//                     },
//                     child: Icon(
//                       Icons.remove_circle,
//                       color: Colors.green,
//                     ),
//                   ),
//                   //* >>>>>>>>>>>>>>>>>  Ingredient
//                   Text(_singleFoodItemCount.toString()),
//                   //* >>>>>>>>>>>>>>>>>  Add button
//                   InkWell(
//                     onTap: () {
//                       setState(() {
//                         // * Converting nutrient values back to orginal
//                         _proteinAmount =
//                             (_proteinAmount / _singleFoodItemCount);
//                         _proteinAmount *= _singleFoodItemCount + 1;

//                         //___
//                         _fatsAmount = (_fatsAmount / _singleFoodItemCount);
//                         _fatsAmount *= _singleFoodItemCount + 1;
//                         //___
//                         _carbsAmount = (_carbsAmount / _singleFoodItemCount);
//                         _carbsAmount *= _singleFoodItemCount + 1;
//                         //___
//                         print(
//                             "============================= single kcal before: " +
//                                 _caloriesAmount.toString());
//                         _caloriesAmount =
//                             (_caloriesAmount / _singleFoodItemCount);
//                         _caloriesAmount *= _singleFoodItemCount + 1;
//                         //___
//                         print("============================= Updated kcal: " +
//                             _caloriesAmount.toString() +
//                             " count: " +
//                             _singleFoodItemCount.toString());
//                         _singleFoodItemCount += 1;
//                       });
//                       print("=============================  count: " +
//                           _singleFoodItemCount.toString() +
//                           "\n _______________________________________________________________________________________________________");
//                     },
//                     child: Icon(Icons.add_circle, color: Colors.green),
//                   )
//                 ],
//               ),
//             ),
