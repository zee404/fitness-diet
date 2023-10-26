import 'package:fitness_diet/core/models/exercise.dart';
import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custPlanViewModel.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/custViews/addExerciseSolo.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingNoBgUniSan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../../../baseView.dart';

class AddExerciseView extends StatefulWidget {
  @override
  _AddExerciseViewState createState() => _AddExerciseViewState();
}

var _controller = TextEditingController();
String selectedValue;

class _AddExerciseViewState extends State<AddExerciseView> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final _exerciseData = Provider.of<List<Exercise>>(context);
    final _planData = Provider.of<Plan>(context);

    return BaseView<CustPlanViewModel>(
        builder: (context, model, child) => Scaffold(
              body: Stack(
                children: [
                  _exerciseData != null
                      ? Container(
                          height: deviceSize.height * 0.17,
                          width: deviceSize.width,
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StandardHeadingNoBgUniSans(
                                    passedText: "Search Exercise: "),
                                Container(
                                  width: deviceSize.width * 0.9,
                                  height: deviceSize.height * 0.07,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              deviceSize.height * 0.05))),
                                  child: SearchableDropdown.single(
                                    value: selectedValue,
                                    hint: "Select Exercise",
                                    searchHint: "Select Exercise",
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value;
                                        print(
                                            "Selected value is : $selectedValue");
                                      });
                                    },
                                    isExpanded: true,
                                    items: _exerciseData.map((value) {
                                      // print(
                                      //     "---> Inside _productsList.map and value  : " +
                                      //         value.toString() +
                                      //         " and pic : " +
                                      //         value.exerciseName.toString());
                                      return DropdownMenuItem<String>(
                                        value: value.exerciseName,
                                        child: Card(
                                          margin: EdgeInsets.all(
                                              deviceSize.height * 0.03),
                                          child: Container(
                                            color: Color(0xffFFFBF3),
                                            padding: EdgeInsets.all(
                                                deviceSize.height * 0.03),
                                            child: InkWell(
                                              onTap: () {
                                                print(
                                                    'ink well pressed go to solo ');

                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddExerciseSolo(
                                                      selectedExercise: value,
                                                    ),
                                                  ),
                                                );
                                                // Navigator.of(context).pop();
                                              },
                                              child: ListTile(
                                                // leading: CircleAvatar(
                                                //   backgroundImage: NetworkImage(
                                                //       "https://firebasestorage.googleapis.com/v0/b/storeifie-e72e3.appspot.com/o/images%2F20-09-23%3A36%3A81.png?alt=media&token=6f622754-994f-47ed-b683-d3c3c673f444"),
                                                // ),
                                                subtitle: Text('30 minutes'
                                                    // model
                                                    //   .getExerciseCalories(
                                                    //       _planData.custWeight, value)
                                                    //   .toString()
                                                    ),
                                                title: Text(
                                                  value.exerciseName,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Loading(),
                  // Center(
                  //   child: Text(
                  //     _exerciseData[1].exerciseName,
                  //   ),
                  // )
                ],
              ),
            ));
  }
}
