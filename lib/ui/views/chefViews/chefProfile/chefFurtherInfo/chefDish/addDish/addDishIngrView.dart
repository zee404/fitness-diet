import 'dart:io';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/API_MODELS/edamamJSONModel.dart';
import 'package:fitness_diet/core/viewmodels/chefProfileViewModels/chefDishViewModels/newDishViewModel.dart';
import 'package:fitness_diet/globals.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/shared/ui_helpers.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefFurtherInfo/chefDish/addDish/newIngrSearchView.dart';
import 'package:fitness_diet/ui/widgets/Buttons/authBtnStyle.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddDishIngrView extends StatefulWidget {
  String dishCatg;
  int prepTimeHrs, prepTimeMin, totalPrepTime;
  File dishPic;

  TextEditingController dishNameContr = TextEditingController();
  TextEditingController priceContr = TextEditingController();
  TextEditingController attrContr = TextEditingController();
  AddDishIngrView();
  AddDishIngrView.withDishInfo({
    @required this.dishPic,
    @required this.dishNameContr,
    @required this.priceContr,
    @required this.totalPrepTime,
    @required this.dishCatg,
    @required this.attrContr,
  });

  @override
  _AddDishIngrViewState createState() => _AddDishIngrViewState();
}

class _AddDishIngrViewState extends State<AddDishIngrView> {
  Map<String, int> countValues = {};
  // Map<int, bool> _currentIngUnit = {};
  // int _currentSelectedIngrIndex;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return BaseView<NewAddDishViewModel>(
      builder: (context, model, child) => model.state == ViewState.Busy
          ? Loading()
          : Container(
              padding: EdgeInsets.only(
                left: deviceSize.width * 0.02,
                top: deviceSize.height * 0.02,
                right: deviceSize.height * 0.04,
                //   bottom: deviceSize.height * 0.07,
              ),
              child: Stack(
                children: [
                  // --------------------------------- S E A R C H    I N G R E D I E N T S
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewIngredientsSearchView(),
                        ),
                      ).then((value) {
                        setState(() {
                          currentIngrList = model.getCurrentFoodIngr;
                          print("------- INSIDE setState : " +
                              currentIngrList.toString());
                        });
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                          Radius.circular(deviceSize.height * 0.15)),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: deviceSize.width * 0.05),
                        height: deviceSize.height * 0.04,
                        width: deviceSize.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 0.3,
                              blurRadius: 10,
                              offset:
                                  Offset(2, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text("Select Ingredients"),
                        ),
                      ),
                    ),
                  ),
                  // ---------------------------------  I N G R E D I E N T S   L I S T
                  Container(
                    margin: EdgeInsets.only(
                      top: deviceSize.height * 0.04,
                      bottom: deviceSize.height * 0.08,
                    ),
                    height: deviceSize.height * 0.7,
                    child: currentIngrList != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: currentIngrList.length,
                            itemBuilder: (context, index) {
                              IngredientInfo singleFood =
                                  currentIngrList[index];
                              // * G E T T I N G   N U T R I E N T S   V A L U E S
                              double _proteinAmount = singleFood.ingredients[0]
                                  .parsed[0].nutrients["PROCNT"].quantity;
                              double _fatsAmount = singleFood.ingredients[0]
                                  .parsed[0].nutrients["FAT"].quantity;
                              double _carbsAmount = singleFood.ingredients[0]
                                  .parsed[0].nutrients["CHOCDF"].quantity;
                              double _caloriesAmount = singleFood.ingredients[0]
                                  .parsed[0].nutrients["ENERC_KCAL"].quantity;
                              // * S E T T I N G   N U T R I E N T S   V A L U E S
                              return Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  children: [
                                    // -------------------------------------------------- N U T R I E N T   I N F O
                                    ListTile(
                                      title: Text(singleFood.ingredients[0].text
                                          .toString()),
                                      subtitle: Text(
                                        _caloriesAmount
                                                .toStringAsFixed(2)
                                                .toString() +
                                            " Kcal , Prot: " +
                                            _proteinAmount
                                                .toStringAsFixed(2)
                                                .toString() +
                                            " G , Carbs: " +
                                            _carbsAmount
                                                .toStringAsFixed(2)
                                                .toString() +
                                            " G , Fats: " +
                                            _fatsAmount
                                                .toStringAsFixed(2)
                                                .toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : Center(child: Text("Select ingredients to proceed")),
                  ),
                  // --------------------------------------- U P L O A D    B U T T O N
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      // color: Colors.white,
                      padding: EdgeInsets.all(20),
                      height: deviceSize.height * 0.08,
                      width: deviceSize.width,
                      //  margin: EdgeInsets.only(bottom: deviceSize.height * 0.02),

                      child: FlatButton(
                        onPressed: () async {
                          model.uploadDishInfo(
                            widget.dishNameContr.text,
                            widget.priceContr.text,
                            widget.totalPrepTime,
                            widget.dishPic,
                            widget.dishCatg,
                            widget.attrContr.text,
                            currentIngrList,
                            
                          );
                          model.hasErrorMessage
                              ? WidgetsBinding.instance.addPostFrameCallback(
                                  (_) => _showErrorMessage(
                                    context,
                                    model.errorMessage,
                                  ),
                                )
                              : Container();
                        },
                        child: AuthBtnStyle(
                          deviceSize: deviceSize,
                          passedText: "Upload",
                        ),
                      ),
                    ),
                  ),
                  model.state == ViewState.Busy ? Loading() : SizedBox(),
                ],
              ),
            ),
    );
  }
}

_showErrorMessage(BuildContext context, String error) async {
  showModalBottomSheet(
    context: (context),
    builder: (context) => UIHelper().showErrorButtomSheet(context, error),
  );
}
