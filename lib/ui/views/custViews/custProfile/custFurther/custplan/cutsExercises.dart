import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custPlanViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../baseView.dart';

class CustExercise extends StatefulWidget {
  Map<String, dynamic> exerciseList;
  // String exerciseTime;
  // String exerciseName;
  // String caloriesBurnt;
  // String duration;

  CustExercise({
    // @required this.exerciseTime,
    // @required this.exerciseName,
    // @required this.caloriesBurnt,
    // @required this.duration,

    @required this.exerciseList,
  });
  @override
  _CustExerciseState createState() => _CustExerciseState();
}

class _CustExerciseState extends State<CustExercise> {
  @override
  Widget build(BuildContext context) {
    final _custData = Provider.of<CustData>(context);

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
                        borderRadius:
                            BorderRadius.circular(widgetSize.height * 0.05),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image.asset(
                          //   "assets/images/AppIcons/left-arrow.png",
                          //   height: widgetSize.height * 0.05,
                          //   width: widgetSize.height * 0.05,
                          // ),
                          // FlatButton(
                          //   onPressed: null,
                          //   child: Icon(Icons.arrow_back_ios),
                          // ),
                          Text(
                            model.formateDate(
                                widget.exerciseList.keys.elementAt(0)),
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
                    SizedBox(
                      height: widgetSize.height * 0.01,
                    ),
                    //-----------------------  A  D D  E X E R C I S E ----------------------

                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: widget.exerciseList.length,
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
                          child: Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.exerciseList.values
                                      .elementAt(index)[0],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    color: Color(0xff4d3814),
                                  ),
                                ),
                                Text(
                                  "Calories burnet :" +
                                      widget.exerciseList.values
                                          .elementAt(index)[1],
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    color: Color(0xff4d3814).withOpacity(0.38),
                                  ),
                                ),
                                Text(
                                  'Duration :' +
                                      widget.exerciseList.values
                                          .elementAt(index)[2],
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    color: Color(0xff4d3814).withOpacity(0.38),
                                  ),
                                ),
                              ],
                            ),
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
                        borderRadius:
                            BorderRadius.circular(widgetSize.height * 0.05),
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
                                .calculateTotalDaily(widget.exerciseList)
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
                    // SizedBox(
                    //   height: widgetSize.height * 0.01,
                    // ),

                    ///-------------------------------- A D D L U N C H
                    ///
                    // InkWell(
                    //   onTap: () {},
                    //   child: Container(
                    //     height: widgetSize.height * 0.15,
                    //     width: widgetSize.width,
                    //     decoration: BoxDecoration(
                    //       color: Color(0xffffffff),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           offset: Offset(0.00, 3.00),
                    //           color: Color(0xff000000).withOpacity(0.16),
                    //           blurRadius: 6,
                    //         ),
                    //       ],
                    //       borderRadius:
                    //           BorderRadius.circular(widgetSize.height * 0.05),
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         Image.asset(
                    //           "assets/images/AppIcons/lunch.png",
                    //           height: widgetSize.height * 0.20,
                    //           width: widgetSize.height * 0.20,
                    //         ),
                    //         Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               "Add Lunch",
                    //               style: TextStyle(
                    //                 fontFamily: "Montserrat",
                    //                 fontSize: widgetSize.height * 0.045,
                    //                 color: Color(0xff4d3814),
                    //               ),
                    //             ),
                    //             Text(
                    //               "Recommended 774 - 1032 Kcal",
                    //               style: TextStyle(
                    //                 fontFamily: "Montserrat",
                    //                 fontSize: widgetSize.height * 0.035,
                    //                 color: Color(0xff4d3814).withOpacity(0.38),
                    //               ),
                    //             ),
                    //           ],
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: widgetSize.height * 0.01,
                    // ),
                    // //
                    // //-------------------------  A D D  -- D I N E R

                    // InkWell(
                    //   onTap: () {},
                    //   child: Container(
                    //     height: widgetSize.height * 0.15,
                    //     width: widgetSize.width,
                    //     decoration: BoxDecoration(
                    //       color: Color(0xffffffff),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           offset: Offset(0.00, 3.00),
                    //           color: Color(0xff000000).withOpacity(0.16),
                    //           blurRadius: 6,
                    //         ),
                    //       ],
                    //       borderRadius:
                    //           BorderRadius.circular(widgetSize.height * 0.05),
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         Image.asset(
                    //           "assets/images/AppIcons/snacks.png",
                    //           height: widgetSize.height * 0.20,
                    //           width: widgetSize.height * 0.20,
                    //         ),
                    //         Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               "Add Diner",
                    //               style: TextStyle(
                    //                 fontFamily: "Montserrat",
                    //                 fontSize: widgetSize.height * 0.045,
                    //                 color: Color(0xff4d3814),
                    //               ),
                    //             ),
                    //             Text(
                    //               "Recommended 774 - 1032 Kcal",
                    //               style: TextStyle(
                    //                 fontFamily: "Montserrat",
                    //                 fontSize: widgetSize.height * 0.035,
                    //                 color: Color(0xff4d3814).withOpacity(0.38),
                    //               ),
                    //             ),
                    //           ],
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: widgetSize.height * 0.01,
                    // ),
                    // //------------------------------- A D D - S N A C K S
                    // InkWell(
                    //   onTap: () {},
                    //   child: Container(
                    //     height: widgetSize.height * 0.15,
                    //     width: widgetSize.width,
                    //     decoration: BoxDecoration(
                    //       color: Color(0xffffffff),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           offset: Offset(0.00, 3.00),
                    //           color: Color(0xff000000).withOpacity(0.16),
                    //           blurRadius: 6,
                    //         ),
                    //       ],
                    //       borderRadius:
                    //           BorderRadius.circular(widgetSize.height * 0.05),
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         Image.asset(
                    //           "assets/images/AppIcons/snacks.png",
                    //           height: widgetSize.height * 0.20,
                    //           width: widgetSize.height * 0.20,
                    //         ),
                    //         Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               "Add Snacks",
                    //               style: TextStyle(
                    //                 fontFamily: "Montserrat",
                    //                 fontSize: widgetSize.height * 0.045,
                    //                 color: Color(0xff4d3814),
                    //               ),
                    //             ),
                    //             Text(
                    //               "Recommended 774 - 1032 Kcal",
                    //               style: TextStyle(
                    //                 fontFamily: "Montserrat",
                    //                 fontSize: widgetSize.height * 0.035,
                    //                 color: Color(0xff4d3814).withOpacity(0.38),
                    //               ),
                    //             ),
                    //           ],
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ));
  }
}
