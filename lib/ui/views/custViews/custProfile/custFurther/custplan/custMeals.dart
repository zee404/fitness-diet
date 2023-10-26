import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custPlanViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:flutter/material.dart';

import '../../../../baseView.dart';

// ignore: must_be_immutable
class CustMeals extends StatefulWidget {
  Map<String, dynamic> mealsList;
  CustMeals({
    @required this.mealsList,
  });
  @override
  _CustMealsState createState() => _CustMealsState();
}

class _CustMealsState extends State<CustMeals> {
  @override
  Widget build(BuildContext context) {
    return BaseView<CustPlanViewModel>(
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, widgetSize) => Container(
          // height: widgetSize.height * 0.2,
          width: widgetSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: widgetSize.width,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.00, 3.00),
                      color: Color(0xff000000).withOpacity(0.16),
                      blurRadius: 6,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(widgetSize.height * 0.05),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // FlatButton(
                    //   onPressed: null,
                    //   child: Icon(Icons.arrow_back_ios),
                    // ),
                    Text(
                      model.formateDate(widget.mealsList.keys.elementAt(0)),
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 20,
                        color: Color(0xff4d3814).withOpacity(0.71),
                      ),
                    ),
                    // FlatButton(
                    //   onPressed: null,
                    //   child: Icon(Icons.arrow_forward_ios),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: widgetSize.height * 0.01),
              //-----------------------  A  D D  B R E A K F A S T ----------------------

              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: widget.mealsList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                    ),
                    padding: EdgeInsets.only(left: 10.0),
                    height: 60,
                    width: widgetSize.width,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.00, 3.00),
                          color: Color(0xff000000).withOpacity(0.16),
                          blurRadius: 6,
                        ),
                      ],
                      borderRadius:
                          BorderRadius.circular(widgetSize.height * 0.05),
                    ),
                    child: Row(
                      children: [
                        // Image.asset(
                        //   "assets/images/AppIcons/breakfast.png",
                        //   height: widgetSize.height * 0.20,
                        //   width: widgetSize.height * 0.20,
                        // ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.mealsList.values.elementAt(index)[0],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 14,
                                  color: Color(0xff4d3814),
                                ),
                              ),
                              Text(
                                "Calories Eaten :" +
                                    widget.mealsList.values.elementAt(index)[1],
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 14,
                                  color: Color(0xff4d3814).withOpacity(0.38),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                padding: EdgeInsets.only(left: 10.0),
                height: 55,
                width: widgetSize.width,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.00, 3.00),
                      color: Color(0xff000000).withOpacity(0.16),
                      blurRadius: 6,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(widgetSize.height * 0.05),
                ),
                child: Row(
                  children: [
                    Text(
                      'Total Calories Eaten : ',
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 12,
                        color: Color(0xff4d3814),
                      ),
                    ),
                    // Spacer(),
                    Text(
                      model
                          .calculateTotalDaily(widget.mealsList)
                          .toStringAsFixed(0),
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 13,
                        color: Color(0xff4d3814),
                      ),
                    ),
                    // Spacer(),
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
