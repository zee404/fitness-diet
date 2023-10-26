import 'package:fitness_diet/core/models/API_MODELS/edamamJSONModel.dart';
import 'package:fitness_diet/core/viewmodels/chefProfileViewModels/chefDishViewModels/newDishViewModel.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/Buttons/bigLightGreenBtn.dart';
import 'package:fitness_diet/ui/widgets/TextFeilds/textFeildWithoutPrefix.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingNoBgUniSan.dart';
import 'package:flutter/material.dart';

class NewIngredientsSearchView extends StatefulWidget {
  @override
  _NewIngredientsSearchViewState createState() =>
      _NewIngredientsSearchViewState();
}

class _NewIngredientsSearchViewState extends State<NewIngredientsSearchView> {
  IngredientInfo _singleIngrInfo;
  List<IngredientInfo> selectedFoodIngrInfoList = [];
  TextEditingController searchedIng = TextEditingController();
  bool isTextFeildEmpty = false;
  bool isLoading = false;
  bool addStatus = false;

  // Map<String, bool> selectionStatus = {};
  bool selectionStatus = false;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BaseView<NewAddDishViewModel>(
      onModelReady: (model) {
        print(
            "--- Setting Ing list to empty from with in onModelReady ingrSearchView");
        model.setIngList([]);
      },
      builder: (context, model, child) => Scaffold(
        body: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          // padding: EdgeInsets.symmetric(horizontal: 20),

          child: Stack(
            children: [
              // ------------------------- F O O D   I N F O   L I S T
              Container(
                margin: EdgeInsets.only(top: deviceSize.height * 0.12),
                child: ListView(
                  children: [
                    SizedBox(height: 20),

                    // >>>>>>>>>>>>>>>>>>>>>>>>> F O O D   I N F O
                    isLoading
                        ? Loading()
                        : isTextFeildEmpty
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error,
                                    size: 15,
                                    color: Colors.red.withOpacity(0.8),
                                  ),
                                  Text(
                                    " Textfeild is empty",
                                    style: TextStyle(color: Colors.black54),
                                  )
                                ],
                              )
                            : _singleIngrInfo != null
                                ? CheckboxListTile(
                                    title: Text(
                                        _singleIngrInfo.ingredients[0].text),
                                    activeColor: Colors.green,
                                    subtitle: Text(_singleIngrInfo
                                            .ingredients[0]
                                            .parsed[0]
                                            .nutrients["ENERC_KCAL"]
                                            .quantity
                                            .toString() +
                                        ", Protein: " +
                                        _singleIngrInfo.ingredients[0].parsed[0]
                                            .nutrients["PROCNT"].quantity
                                            .toString() +
                                        ", FAT: " +
                                        _singleIngrInfo.ingredients[0].parsed[0]
                                            .nutrients["FAT"].quantity
                                            .toString() +
                                        ", CHOCDF: " +
                                        _singleIngrInfo.ingredients[0].parsed[0]
                                            .nutrients["CHOCDF"].quantity
                                            .toString()),
                                    value: selectionStatus,
                                    onChanged: (val) {
                                      setState(() {
                                        selectionStatus = val;
                                      });
                                      selectionStatus == true
                                          ? selectedFoodIngrInfoList
                                              .add(_singleIngrInfo)
                                          : selectedFoodIngrInfoList
                                              .remove(_singleIngrInfo);
                                    },
                                  )
                                : Container(
                                    color: Colors.red,
                                    child: Center(
                                      child: Text(
                                        "No result for particular search",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                  ],
                ),
              ),

              // >>>>>>>>>>>>>>  Add ingredients button
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    model.setIngList(selectedFoodIngrInfoList);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 70,
                    width: deviceSize.width,
                    padding: EdgeInsets.all(20),
                    //    margin: EdgeInsets.only(bottom: 30),
                    color: Colors.white,
                    child: BigLightGreenBtn(
                      passedText: "Add ingredients",
                      isDisabled: false,
                    ),
                  ),
                ),
              ),
              // ------------------------- H E A D E R
              Container(
                height: deviceSize.height * 0.17,
                width: deviceSize.width,
                padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // >>>>>>>>>>>>>>>>>>>>>>>>> H E A D I N G
                    StandardHeadingNoBgUniSans(
                        passedText: "Search Ingredients: "),

                    // >>>>>>>>>>>>>>>>>>>>>>>>> T E X T F E I L D
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: TextFeildWitouthPrefix(
                            controller: searchedIng,
                            deviceSize: deviceSize,
                            isTypeInt: false,
                            hintText: "Enter ingredient",
                            isObscureText: false,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            color: Colors.black.withOpacity(0.5),
                            icon: Icon(
                              Icons.search,
                              size: deviceSize.height * 0.025,
                              color: Colors.brown.withOpacity(0.7),
                            ),
                            onPressed: () async {
                              if (searchedIng.text.length == 0) {
                                setState(() {
                                  isTextFeildEmpty = true;
                                });
                              } else {
                                setState(() {
                                  isTextFeildEmpty = false;
                                });
                                setState(() {
                                  isLoading = true;
                                });
                                // * Getting the searched food list
                                _singleIngrInfo =
                                    await model.getSearchedIngredientsList(
                                        searchedIng.text);
                                // * Setting the check status of all foods to false
                                if (_singleIngrInfo != null) {
                                  setState(() {
                                    selectionStatus = false;
                                  });

                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  print(
                                      "---> Inside else of on press of Search inside search view");
                                  setState(() {
                                    _singleIngrInfo = null;
                                  });
                                }
                              }

                              print("isTextFeildEmpty: " +
                                  isTextFeildEmpty.toString() +
                                  " and " +
                                  searchedIng.text.length.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
