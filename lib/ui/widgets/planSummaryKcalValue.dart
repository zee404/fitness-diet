import 'package:fitness_diet/core/models/plan.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PlanSummaryKcalValue extends StatelessWidget {
  Plan planData;
  String passedText;
  PlanSummaryKcalValue({@required this.planData, @required this.passedText});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          planData.custEatenKcal > planData.custReqKcal
              ? '0'
              : ((planData.custReqKcal - planData.custEatenKcal) +
                      planData.custburntKcal)
                  .toStringAsFixed(0),
          // planData.custEatenKcal.toStringAsFixed(0),
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 17,
            color: Color(0xffd6d8ff),
            shadows: [
              Shadow(
                offset: Offset(0.00, 3.00),
                color: Color(0xff000000).withOpacity(0.16),
                blurRadius: 6,
              ),
            ],
          ),
        ),
        Text(
          passedText,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 12.5,
            color: Color(0xffffffff),
            shadows: [
              Shadow(
                offset: Offset(0.00, 3.00),
                color: Color(0xff000000).withOpacity(0.16),
                blurRadius: 6,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
