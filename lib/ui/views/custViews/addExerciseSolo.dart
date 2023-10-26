import 'package:fitness_diet/core/models/exercise.dart';
import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custPlanViewModel.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custFurther/custplan/addExerciseView.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custProfileMain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../baseView.dart';

// ignore: must_be_immutable
class AddExerciseSolo extends StatefulWidget {
  Exercise selectedExercise;
  AddExerciseSolo({
    @required this.selectedExercise,
  });
  @override
  _AddExerciseSoloState createState() => _AddExerciseSoloState();
}

String duration = '30';
double exerciseCalories;

class _AddExerciseSoloState extends State<AddExerciseSolo> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final _planData = Provider.of<Plan>(context);

    return BaseView<CustPlanViewModel>(
        onModelReady: (model) {
          exerciseCalories = model.getExerciseCalories(
                  _planData.custWeight, widget.selectedExercise) *
              30;
        },
        builder: (context, model, child) => Scaffold(
              body: Column(
                children: [
                  Container(
                    height: deviceSize.height * 0.4,
                    width: double.infinity,
                    color: Colors.pinkAccent,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        widget.selectedExercise.exerciseName,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: deviceSize.height * 0.04),
                      ),
                    ),
                  ),

                  //--------------------------------- D I P S PL A Y I N G -- C A L O R I E S
                  //

                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      exerciseCalories.toStringAsFixed(0) + " Cal",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: deviceSize.height * 0.045,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  // -----------------------------SELECTING TIME
                  Row(
                    children: [
                      SizedBox(
                        width: deviceSize.width * 0.02,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          initialValue: '30',
                          onChanged: (value) {
                            setState(() {
                              exerciseCalories = model.getExerciseCalories(
                                      _planData.custWeight,
                                      widget.selectedExercise) *
                                  double.parse(value);
                              duration = value;
                            });
                          },
                          style: TextStyle(
                            fontSize: deviceSize.height * 0.02,
                            color: Colors.black,
                          ),
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            counterText: '',
                            // hintText: '30',
                            focusColor: Colors.pink,
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: deviceSize.height * 0.03,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            hintText: 'Minutes',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                            ),
                            enabled: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      backgroundColor: Colors.green,
                      onPressed: () {
                        print('------------ add exercise pressed');
                        model.addExercise(
                            _planData.planID,
                            widget.selectedExercise.exerciseName,
                            exerciseCalories.toStringAsFixed(2),
                            duration);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustProfileMain(),
                          ),
                        );
                      },
                      child: Text('Add'),
                    ),
                  ),
                ],
              ),
            ));
  }
}
