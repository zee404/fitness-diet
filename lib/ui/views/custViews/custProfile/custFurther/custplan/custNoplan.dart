import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custPlanViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custFurther/custplan/custStartPlan.dart';
import 'package:flutter/material.dart';

class CustNoPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<CustPlanViewModel>(
      builder: (context, model, child) => ResponsiveSafeArea(
          builder: (context, deviceSize) => Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: deviceSize.height * 0.3,
                      ),
                      Text(
                        "No active plan",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 15,
                          color: Color(0xff554141),
                        ),
                      ),
                      SizedBox(
                        height: deviceSize.height * 0.02,
                      ),
                      FlatButton(
                        onPressed: () {
                          // model.goToStartPlan();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustStartPlan()));
                        },
                        child: Container(
                          height: deviceSize.height * 0.07,
                          width: deviceSize.width * 0.5,
                          decoration: BoxDecoration(
                            color: Color(0xffe4d7cb),
                            borderRadius: BorderRadius.circular(50.00),
                          ),
                          child: Center(
                            child: Text(
                              "Start new plan",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "UniSansRegular",
                                fontSize: 18,
                                color: Color(0xff5f2424),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}
