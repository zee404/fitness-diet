import 'dart:ui';

import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/disease.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custPlanViewModel.dart';
import 'package:fitness_diet/ui/shared/fonts.dart';

import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/shared/ui_helpers.dart';
import 'package:fitness_diet/ui/widgets/TextFeilds/textFeildWithWhiteBGSmall.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../baseView.dart';

class CustStartPlan extends StatefulWidget {
  @override
  _CustStartPlanState createState() => _CustStartPlanState();
}

class _CustStartPlanState extends State<CustStartPlan> {
  double _activitylevel = 1.55;
  //String _activitylevelWORKOUT = 'Average';
  String _gender = 'Female';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _heightControler = TextEditingController();
  TextEditingController _weightControler = TextEditingController();
  TextEditingController _goalWeightControler = TextEditingController();

// >>>>>>>>>>>>>>>>>>>>>>>> Disease related variables
  GlobalKey<SimpleGroupedChipsState<int>> chipKey =
      GlobalKey<SimpleGroupedChipsState<int>>();
  List _updatedDiseaseList = [];
  List<int> _statusListValues = [];
  List<String> _statusListText = [];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final _custData = Provider.of<CustData>(context);
    final _diseasesData = Provider.of<List<Disease>>(context);

    Widget _smallLightSubHeading(String _passedText) {
      return Text(
        _passedText,
        style: TextStyle(
          fontFamily: fontMontserrat,
          fontSize: screenSize.height * 0.014,
          color: Color(0xff2a6427).withOpacity(0.50),
        ),
      );
    }

    Widget _smallBlackHeading(String _passedText) {
      return Text(
        _passedText,
        style: TextStyle(
          fontFamily: "Montserrat",
          fontSize: screenSize.height * 0.018,
          color: Color(0xff000500),
        ),
      );
    }

    Widget _brownkHeading(
        String _passedPrimaryText, String _passedSecondaryText) {
      return Row(
        children: [
          Expanded(
            child: Text(
              _passedPrimaryText,
              style: TextStyle(
                fontFamily: "UniSansW01-Regular",
                fontSize: screenSize.height * 0.02,
                color: Color(0xff2a6427),
              ),
            ),
          ),
          Expanded(
            child: Text(
              _passedSecondaryText,
              style: TextStyle(
                fontFamily: "UniSansW01-Regular",
                fontSize: screenSize.height * 0.01,
                color: Colors.black,
              ),
            ),
          ),
        ],
      );
    }

    return BaseView<CustPlanViewModel>(
      onModelReady: (model) {
        // if (_diseasesData != null) {
        for (int i = 0; i < _diseasesData.length; i++) {
          _statusListValues.add(i);
          _statusListText.add(_diseasesData[i].name);
        }
        // }
      },
      builder: (context, model, child) => SafeArea(
        child: model.state == ViewState.Busy
            ? Loading()
            : Scaffold(
                body: Stack(
                  children: [
                    Column(
                      children: <Widget>[
                        //upper header container
                        Container(
                          height: screenSize.height * 0.25,
                          width: screenSize.width,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: screenSize.height * 0.06,
                              ),
                              //
                              //
                              //
                              // ********************* S  T  A  R  T ---- P  L  A  N --------A  N  D --- I  M  A  G  E ------- C  O  N  T  A  I  N  E  R//
                              //
                              //
                              Container(
                                width: screenSize.width,
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: screenSize.width * 0.08,
                                    ),
                                    Text(
                                      "Start\nyour plan",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: screenSize.height * 0.05,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        //
                        //>>>>>>>> F O R M  -- C O N T A I N E R >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                        //
                        //
                        Expanded(
                          flex: 2,
                          child: Container(
                            //height: screenSize.height * 0.609,

                            width: screenSize.width,
                            decoration: BoxDecoration(
                              color: Color(0xffe4d7cb).withOpacity(0.36),
                              borderRadius: BorderRadius.only(
                                topRight:
                                    Radius.circular(screenSize.width * 0.3),
                              ),
                              // boxShadow: [
                              //   BoxShadow(
                              //     offset: Offset(0.01, -0.02),
                              //     color: Color(0xff000000).withOpacity(0.16),
                              //     blurRadius: 2,
                              //   ),
                              // ],
                            ),

                            // container for viewing form  list view
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: screenSize.height * 0.06,
                                left: 15,
                              ),
                              child: Form(
                                child: ListView(
                                  children: <Widget>[
                                    SizedBox(
                                      height: screenSize.height * 0.06,
                                    ),
                                    //container 1 for gender

                                    Container(
                                      margin: EdgeInsets.only(
                                          left: screenSize.width * 0.04),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          //******************************* G  E  N  D  E  R -- C  O  N  T  A  I  N  E  R */
                                          _brownkHeading("Gender", ""),

                                          Container(
                                              child: Row(
                                            children: <Widget>[
                                              Radio(
                                                value: 'Female',
                                                groupValue: _gender,
                                                onChanged: (String value) {
                                                  setState(() {
                                                    _gender = value;
                                                  });
                                                },
                                              ),
                                              _smallBlackHeading("Female"),
                                              SizedBox(
                                                  width:
                                                      screenSize.width * 0.09),
                                              Radio(
                                                value: 'Male',
                                                groupValue: _gender,
                                                onChanged: (String value) {
                                                  setState(() {
                                                    _gender = value;
                                                  });
                                                },
                                              ),
                                              _smallBlackHeading("Male"),
                                            ],
                                          )),

                                          //  <<<<<<<<<<<<<<<<<<<<<<<<  H  E  I  G  H  T >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                          _brownkHeading('Height', ' (cm)'),

                                          SizedBox(
                                              height: screenSize.height * 0.02),
                                          TextFieldWithWhiteBGSmall(
                                              controller: _heightControler,
                                              isTypeInt: true,
                                              hintText: '',
                                              isObscureText: false),

                                          SizedBox(
                                            height: screenSize.height * 0.04,
                                          ),
                                          //<<<<<<<<<<<<<<<<<<<<<<<< W E I G H T >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                          _brownkHeading('Weight', ' (kg)'),

                                          SizedBox(
                                              height: screenSize.height * 0.02),
                                          TextFieldWithWhiteBGSmall(
                                              controller: _weightControler,
                                              isTypeInt: true,
                                              hintText: '',
                                              isObscureText: false),
                                          SizedBox(
                                            height: screenSize.height * 0.04,
                                          ),
                                          //<<<<<<<<<<<<<<<<<<<<<<<< G O A L - W E I G H T >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                          _brownkHeading(
                                              'Goal Weight', ' (kg)'),

                                          SizedBox(
                                              height: screenSize.height * 0.02),
                                          TextFieldWithWhiteBGSmall(
                                            controller: _goalWeightControler,
                                            isTypeInt: true,
                                            hintText: '',
                                            isObscureText: false,
                                          ),

                                          SizedBox(
                                              height: screenSize.height * 0.04),
                                          _brownkHeading(
                                              "Level of activity during the day\nEXCL. WORKOUTS",
                                              ""),

                                          _smallLightSubHeading(
                                              "(at work, school, home)"),
                                        ],
                                      ),
                                    ),
                                    //
                                    //
                                    //************************************ A  C  T  I  V  I  T  Y -- L  E  V  E  L**********************************  */
                                    //
                                    //
                                    // level of activity text and radio buttons

                                    // SizedBox(height: screenSize.height * 0.01),
                                    //activity level very low
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: screenSize.width * 0.25),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Radio(
                                              value: 1.2,
                                              groupValue: _activitylevel,
                                              onChanged: (double value) {
                                                setState(() {
                                                  _activitylevel = value;
                                                });
                                              },
                                            ),
                                            title:
                                                _smallBlackHeading("Very low"),
                                            subtitle: _smallLightSubHeading(
                                                "little or No Exercise "),
                                          ),
                                          //activity level  low
                                          ListTile(
                                            leading: Radio(
                                              value: 1.375,
                                              groupValue: _activitylevel,
                                              onChanged: (double value) {
                                                setState(() {
                                                  _activitylevel = value;
                                                });
                                              },
                                            ),
                                            title: _smallBlackHeading("Low"),
                                            subtitle: _smallLightSubHeading(
                                                "Light exercise/sports 1-3 days/week"),
                                          ),
                                          //activity level  high
                                          ListTile(
                                            leading: Radio(
                                              value: 1.55,
                                              groupValue: _activitylevel,
                                              onChanged: (double value) {
                                                setState(() {
                                                  _activitylevel = value;
                                                });
                                              },
                                            ),
                                            title:
                                                _smallBlackHeading("Average"),
                                            subtitle: _smallLightSubHeading(
                                                "Moderate exercise/sports 3-5 days/week "),
                                          ),
                                          //activity level  high
                                          ListTile(
                                            leading: Radio(
                                              value: 1.725,
                                              groupValue: _activitylevel,
                                              onChanged: (double value) {
                                                setState(() {
                                                  _activitylevel = value;
                                                });
                                              },
                                            ),
                                            title: _smallBlackHeading("High"),
                                            subtitle: _smallLightSubHeading(
                                                "Hard exercise /sports 6-7 days a week "),
                                          ),
                                          //activity level very  high
                                          ListTile(
                                            leading: Radio(
                                              value: 1.9,
                                              groupValue: _activitylevel,
                                              onChanged: (double value) {
                                                setState(() {
                                                  _activitylevel = value;
                                                });
                                              },
                                            ),
                                            title:
                                                _smallBlackHeading("Very High"),
                                            subtitle: _smallLightSubHeading(
                                                "Very hard exercise/sports and physical job or 2X training"),
                                          ),
                                          SizedBox(
                                            height: screenSize.height * 0.04,
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      height: screenSize.height * 0.04,
                                    ),
                                    // //>>>>>>>>>>>>>>>>>>>>>>>>> W O R K O U T --- A C T I V I T Y -- L E V E L >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                    // ---------------------------- A L L E R G I E S / D I S E A S E S
                                    _brownkHeading("Diseases", ""),
                                    _smallLightSubHeading(
                                        " (Let us know if you suffer from any of the following diseases frequntly or occasionally. We'll reccomend what's best for your health)"),
                                    SizedBox(height: 7),
                                    Center(
                                      child: SimpleGroupedChips<int>(
                                        isMultiple: true,
                                        preSelection: [],
                                        key: chipKey,
                                        isScrolling: false,
                                        values: _statusListValues,
                                        itemTitle: _statusListText,
                                        backgroundColorItem: Colors.black26,
                                        onItemSelected: (selected) {
                                          print("selected " +
                                              selected.toString());
                                          setState(() {
                                            _updatedDiseaseList = selected;
                                          });
                                          // _updatedDiseaseList.add(selected);

                                          print(
                                              "---> _updatedDiseaseList inside checkBox: " +
                                                  _updatedDiseaseList
                                                      .toString());
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.04,
                                    ),
                                    Container(
                                      height: screenSize.height * 0.05,
                                      margin: EdgeInsets.only(
                                        left: screenSize.width * 0.2,
                                        right: screenSize.width * 0.30,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xffe4d7cb),
                                        borderRadius:
                                            BorderRadius.circular(50.00),
                                      ),
                                      child: FlatButton(
                                        onPressed: () {
                                          List _diseasesID = [];
                                            // Adding disease ID
                                          for (int i = 0;
                                              i < _updatedDiseaseList.length;
                                              i++) {
                                            _diseasesID.add(_diseasesData[
                                                    _updatedDiseaseList[i]]
                                                .diseaseID);
                                          }
                                          model.startPlan(
                                            _gender,
                                            _heightControler.text,
                                            _weightControler.text,
                                            _goalWeightControler.text,
                                            _custData.custDateOfBirth,
                                            _activitylevel,
                                            _diseasesID,
                                          );

                                          model.hasErrorMessage
                                              ? WidgetsBinding.instance
                                                  .addPostFrameCallback(
                                                  (_) => _showErrorMessage(
                                                    context,
                                                    model.errorMessage,
                                                  ),
                                                )
                                              : Container();
                                        },
                                        // DatabaseService()
                                        //     .addPlanData(({'planid': 'dsad'})),
                                        child: Center(
                                          child: Text(
                                            "Start plan",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: "UniSansRegular",
                                              fontSize:
                                                  screenSize.height * 0.023,
                                              color: Color(0xff5f2424),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: screenSize.height * 0.02,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    model.state == ViewState.Busy ? Loading() : Container(),
                  ],
                ),
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
