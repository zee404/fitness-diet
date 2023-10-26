import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custPlanViewModel.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/planSummaryKcalValue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sleek_circular_slider/sleek_circular_slider.dart';

// ignore: must_be_immutable
class SummaryCard extends StatefulWidget {
  Size widgetSize;

  SummaryCard(Size widgetSize) {
    this.widgetSize = widgetSize;
  }
  @override
  _SummaryCardState createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  int remaningValue = 2045;
  int eatenValue = 30;
  int burnedValue = 40;

  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;
    final _planData = Provider.of<Plan>(context);

    return BaseView<CustPlanViewModel>(
      builder: (context, model, child) => Container(
        // padding: EdgeInsets.only(
        //   left: widget.widgetSize.width * 0.06,
        //   right: widget.widgetSize.width * 0.05,
        //   top: widget.widgetSize.height * 0.03,
        // ),
        height: 200,
        width: widget.widgetSize.width,
        decoration: BoxDecoration(
          color: Color(0xff800080),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.widgetSize.height * 0.15),
            topRight: Radius.circular(widget.widgetSize.height * 0.05),
            bottomRight: Radius.circular(widget.widgetSize.height * 0.15),
            bottomLeft: Radius.circular(widget.widgetSize.height * 0.05),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //
                    // R E M A N I N G --   C A LA O R I E S //
                    //
                    PlanSummaryKcalValue(
                      planData: _planData,
                      passedText: "Remaining",
                    ),
                    //
                    //
                    //  E A T E N  -- S L I D E R   //
                    //

                    Container(
                      padding: EdgeInsets.symmetric(vertical: 7),

                      // width: widget.widgetSize.width * 0.4,
                      // height: widget.widgetSize.height * 0.3,
                      child: SleekCircularSlider(
                        initialValue:
                            _planData.custEatenKcal >= _planData.custReqKcal
                                ? _planData.custReqKcal
                                : _planData.custEatenKcal,
                        // initialValue: 2560,
                        max: _planData.custReqKcal,

                        appearance: CircularSliderAppearance(
                          angleRange: 180,
                          startAngle: 180,
                          infoProperties: InfoProperties(
                            mainLabelStyle: TextStyle(
                                fontFamily: "Montserrat",
                                color: Color(0xffd6d8ff),
                                fontSize: 16),
                            modifier: (percentage) {
                              final roundedValue =
                                  percentage.ceil().toInt().toString();
                              return '$roundedValue ';
                            },
                            bottomLabelText: 'Eaten',
                            bottomLabelStyle: TextStyle(
                              fontFamily: "Montserrat",
                              color: Color(0xffffffff),
                              fontSize: 13.5,
                            ),
                          ),
                          customColors: CustomSliderColors(
                            progressBarColor: Color(0xffffffff),
                            trackColor: Color(0xffd6d8ff),
                            dotColor: Colors.transparent,
                          ),
                          customWidths: CustomSliderWidths(
                            progressBarWidth: widget.widgetSize.height * 0.02,
                            trackWidth: widget.widgetSize.height * 0.01,
                          ),
                        ),
                        // onChange: (v) {},
                      ),
                    ),

                    //
                    // B U R N T  --   C A LA O R I E S //
                    //
                    // PlanSummaryKcalValue(
                    //   planData: _planData,
                    //   passedText: "Burnt",
                    // ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _planData.custburntKcal.toStringAsFixed(0),
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
                          'Burnt',
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
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ///
                    //C  A  R  B  S -- C O N T A I N E R
                    //
                    ///
                    caloriesContainer(
                        'Carbs',
                        _planData.custEatenCarbs,
                        model.getCarbsVlaue(_planData.custReqKcal).round(),
                        widget.widgetSize),
                    //
                    //P R  O  T  E  I  N -- C O N T A I N E R
                    //
                    caloriesContainer(
                        'Protein',
                        _planData.custEatenProtein,
                        model.getProteinvalue(_planData.custReqKcal).round(),
                        widget.widgetSize),
                    //
                    // F A T S -- C O N T A I N E R
                    //
                    caloriesContainer(
                        'Fats',
                        _planData.custEatenFats,
                        model.getFatsValue(_planData.custReqKcal).round(),
                        widget.widgetSize),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget caloriesContainer(
    String heading, double eatencal, int value, Size widgetSize) {
  String eaten = eatencal.toStringAsFixed(0);
  return Container(
    height: widgetSize.height * 0.18,
    width: widgetSize.width * 0.2,
    child: Column(
      children: [
        //
        // C A R B S -- C O N T A I N E R
        //
        Text(
          heading,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 14,
            color: Color(0xffd6d8ff),
          ),
        ),
        LinearProgressIndicator(
          value: int.parse(eaten) / value,
          backgroundColor: Color(0xffd6d8ff),
          valueColor: AlwaysStoppedAnimation<Color>(
            Color(0xffffffff),
          ),
        ),
        Text(
          eaten + " / $value g",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 11.5,
            color: Color(0xffe4d7cb),
          ),
        )
      ],
    ),
  );
}
