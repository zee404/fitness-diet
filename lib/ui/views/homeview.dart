import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/homeViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveBuilder.dart';
import 'package:fitness_diet/ui/shared/imagesURLs.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/Buttons/skip_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("----> 'HomeView' reached");
    final user = Provider.of<CurrentUser>(context);
    return BaseView<HomeViewModel>(
        onModelReady: (model) =>
            user != null ? model.redirectSignedInUser(user.uid) : null,
        builder: (context, model, child) {
          if (user == null) {
            print("----------> User is null inside the 'HomeView'");
            return ResponsiveBuilder(
              builder: (context, sizingInformation) => Scaffold(
                body: Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(child: custBgImage1Ftn()),
                        Expanded(child: chefBgImage1Ftn()),
                      ],
                    ),
//
                    // >>>>>>>>>> H E A D E R   T E X T
                    //
                    Container(
                      margin: EdgeInsets.only(
                        top: 150,
                        left: 19,
                      ),
                      child: Text(
                        "Fitness",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 55,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 200,
                        left: 20,
                      ),
                      child: Text(
                        "DIET",
                        style: TextStyle(
                          fontFamily: "Lemon-Milk",
                          fontSize: 57,
                          color: Color(0xff05355a),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(
                        top: 200,
                        // left: sizingInformation.localWidgetSize.width * 0.03,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment:CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  startAsText(sizingInformation.screenSize),
                                  FlatButton(
                                    onPressed: () => model.gotToCustSignIn(),
                                    child: startAsButtonStyle("Customer",
                                        sizingInformation.screenSize),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  startAsText(sizingInformation.screenSize),
                                  FlatButton(
                                    onPressed: () => model.gotToChefSignIn(),
                                    child: startAsButtonStyle(
                                        "Chef", sizingInformation.screenSize),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    //
                    // >>>>>>>>>> "S T A R T   A S"   B U T T O N S  D E L I V E R Y
                    //
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(
                          bottom:
                              sizingInformation.localWidgetSize.height * 0.07),
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              sizingInformation.localWidgetSize.width * 0.04),
                      child: InkWell(
                        onTap: () => model.gotToDelivSignIn(),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Start as",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              " Delivery Guy",
                              style: TextStyle(
                                fontFamily: "BigNoodle",
                                fontSize:
                                    sizingInformation.localWidgetSize.height *
                                        0.026,
                                color: Color(0xff7A400B),
                              ),
                            ),
                            Spacer(),
                            // >>>>>>>>>>>>>>>>>>>> S K I P
                            InkWell(
                              onTap: () => model.gotToFoodMenu(),
                              child: SkipBtn(
                                passedText: "SKIP",
                                deviceSize: sizingInformation.screenSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            if (model.state == ViewState.Busy) {
              return Loading();
            } else {
              print(
                  "User is already signed in hence redirecting control to respective user - (Message from within 'HomeView')");
              model.redirectSignedInUser(user.uid);
            }
            // return SplashWidget(
            //   deviceSize: MediaQuery.of(context).size,
            // );
            return Loading();
          }
        });
  }

  Widget custBgImage1Ftn() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(custBGImage_1),
          colorFilter: new ColorFilter.mode(
            Colors.lightBlue.withOpacity(0.6),
            BlendMode.srcOver,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget chefBgImage1Ftn() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(chefBGImage_1),
            colorFilter: ColorFilter.mode(
              Colors.lightBlue.withOpacity(0.6),
              BlendMode.srcATop,
            ),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget startAsText(Size widgetSize) {
    return Text(
      "Start as",
      style: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 15,
        color: Color(0xffffffff),
        shadows: [
          Shadow(
            offset: Offset(0.00, 3.00),
            color: Color(0xff000000).withOpacity(0.16),
            blurRadius: 6,
          ),
        ],
      ),
    );
  }

  Widget startAsButtonStyle(String _passedText, Size widgetSize) {
    return Container(
      height: 30,
      width: 120,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 3.00),
            color: Colors.black.withOpacity(0.8),
            blurRadius: 6,
          ),
        ],
        color: Color(0xff28F5FA),
        borderRadius: BorderRadius.all(
          Radius.circular(widgetSize.height * 0.03),
        ),
      ),
      child: Center(
        child: Text(
          _passedText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 15,
            color: Color(0xff020000),
          ),
        ),
      ),
    );
  }
}
