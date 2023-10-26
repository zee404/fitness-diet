import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  final headerBgColor1 = Color(0xff99CA96);
  final headerTextColor1 = Color(0xff2A6427);
  final mainBgColor = Color(0xffD4EBD3);
  final btnBGColor1 = Color(0xff99CA96);
//  Size deviceSize;
// Screen Height
  static double dblScreenHeight =
      window.physicalSize.height / window.devicePixelRatio;

  // Screen Width
  static double dblScreenWidth =
      window.physicalSize.width / window.devicePixelRatio;

  // void setDeviceSize(Size d_size) {
  //   this.deviceSize = d_size;
  // }

  // Size getDeviceSize() {
  //   return deviceSize;
  // }

// TEXT FORM FEILD VERIFICATION FUNCTIONS
  bool verifyPhoneNumber(String PhoneNumber) {
    bool _default = false;

    if (PhoneNumber != "") {
      if (PhoneNumber[0] == "+" &&
          PhoneNumber[1] == "9" &&
          PhoneNumber[2] == "2" &&
          PhoneNumber.length == 13) {
        print("Phone Number verified (Via constant function)");
        return true;
      } else {
        return false;
      }
    } else {
      return _default;
    }
  }

  bool verifyUsername(String username) {
    bool _default = false;
    if (username != null && username.length < 20) {
      print("Username verified (Via constant function)");
      return true;
    } else {
      return _default;
    }
  }

  bool verifyInputFeild(String inputText) {
    return inputText != null && inputText.length < 40 && inputText != ""
        ? true
        : false;
  }

    bool verifyNumericInputFeild(int inputText) {
    return inputText != null && inputText < 100000
        ? true
        : false;
  }

  // --------------------------------------- M O S T  U S E D  L O G I C A L  F U N C T I O N S
  //
  // >>>>>>>>>>>> To store golbal staus of user loggin in   <<<<<<<<<<<<<<<
  //
  Future<bool> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedInStatus = prefs.getBool("loggedInStatus");

    if (loggedInStatus == null) {
      return false;
    }
    return loggedInStatus;
  }
// --------------------------------------- E R R O R    M E S S A G E S
  Future<void> setLoginStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("loggedInStatus", status);
  }

  Future showFillInfoErrorDialog(BuildContext context, Size deviceSize) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: Colors.red.withOpacity(0.7),
        padding: EdgeInsets.all(deviceSize.width * 0.04),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter stateSetter) {
            return Row(
              children: <Widget>[
                Icon(
                  Icons.error,
                  color: Colors.white,
                ),
                Text(
                  "  Fill all the required info",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Montserrat",
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // --------------------------------------- D E C O R A T I O N A L    W I D G E T S

  // ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ B U T T O N S
  //
  // >>>>>>>>>>>> Standard Button Style # 1   ( R O U N D   B I G - Light )   <<<<<<<<<<<<<<<
  //
  Widget standardBtnStyle1(String _btnText) {
    return Container(
      width: _btnText.length.toDouble() > 5
          ? _btnText.length.toDouble() * 19
          : 120,
      height: 35,
      decoration: BoxDecoration(
        color: btnBGColor1,
        borderRadius: BorderRadius.all(
          Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.brown,
            blurRadius: 20.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal
              1.0, // vertical
            ),
          )
        ],
      ),
      child: Center(
        child: Text(
          _btnText,
          style: TextStyle(
            fontSize: 17,
            fontFamily: "Montserrat",
            color: Colors.brown,
          ),
        ),
      ),
    );
  }

  //
  // >>>>>>>>>>>> Standard T A B  Button  Style # 1.1   ( R O U N D   B I G - B L U E )   <<<<<<<<<<<<<<<
  //
  Widget standardTabButton(String _btnText, Size deviceSize) {
    return Container(
      width: deviceSize.width,
      height: deviceSize.height * 0.06,
      decoration: BoxDecoration(
        color: Color(0xffD6D8FF),
        border: Border.all(
          width: deviceSize.width * 0.003,
          color: Color(0xff4E7A0B),
        ),
        borderRadius: BorderRadius.circular(deviceSize.height * 0.1),
      ),
      child: Center(
        child: Text(
          _btnText,
        ),
      ),
    );
  }

  //
  // >>>>>>>>>>>> Standard Button Style # 2   ( R O U N D   S M A L L  -  D A R K )   <<<<<<<<<<<<<<<
  //
  Widget standardBtnStyle2(String _btnText, Size widgetSize) {
    return Container(
      width: _btnText.length.toDouble() > 5
          ? _btnText.length.toDouble() * widgetSize.height * 0.015
          : widgetSize.height * 0.1,
      height: widgetSize.height * 0.04,
      decoration: BoxDecoration(
        color: Color(0xffe4d7cb),
        borderRadius: BorderRadius.all(
          Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.brown,
            blurRadius: 20.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal
              1.0, // vertical
            ),
          )
        ],
      ),
      child: Center(
        child: Text(
          _btnText,
          style: TextStyle(
            fontSize: widgetSize.height * 0.02,
            fontFamily: "Uni-Sans",
            color: Color(0xff5f2424),
          ),
        ),
      ),
    );
  }

  //
  // >>>>>>>>>>>> Standard Flexible Button Style # 3   ( R O U N D   F L E X I B L E  -  G R E E N / B L A C K )   <<<<<<<<<<<<<<<
  //
  Widget standardBtnStyle3(String _btnText, Size widgetSize) {
    return Container(
      width: widgetSize.width * 0.7,
      height: widgetSize.height * 0.045,
      decoration: BoxDecoration(
        color: Colors.green,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(1, 6),
            blurRadius: 8,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(widgetSize.height * 0.03),
        ),
      ),
      child: Center(
        child: Text(
          _btnText,
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Montserrat',
            fontSize: widgetSize.height * 0.02,
          ),
        ),
      ),
    );
  }

  //
  // >>>>>>>>>>>> Advanced Button Style # 4   ( S K I P   H O M E   S C R E E M )   <<<<<<<<<<<<<<<
  //
  Widget advancedBtnStyle4(String _btnText, Size deviceSize) {
    return Container(
      height: deviceSize.height * 0.036,
      width: deviceSize.width * 0.23,
      decoration: BoxDecoration(
        color: Color(0xffe4d7cb),
        borderRadius: BorderRadius.circular(deviceSize.width * 0.07),
      ),
      child: Row(
        children: <Widget>[
          Text(
            "   " + _btnText,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: deviceSize.height * 0.022,
              color: Color(0xff0c0101),
            ),
          ),
          Spacer(),
          Container(
            height: deviceSize.height * 0.035,
            width: deviceSize.height * 0.035,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              size: deviceSize.height * 0.02,
            ),
          )
        ],
      ),
    );

    //   Container(
    //       alignment: Alignment.bottomCenter,
    //       height: deviceSize.height * 0.04,
    //       width: deviceSize.width * 0.17,
    //       //  color: Colors.amber,
    //       child: Center(
    //         child: Stack(
    //           children: <Widget>[
    //             Container(
    //               height: deviceSize.height * 0.03,
    //               width: deviceSize.height * 0.07,
    //               decoration: BoxDecoration(
    //                 color: Color(0xffe4d7cb),
    //                 border: Border.all(
    //                   width: 1.00,
    //                   color: Color(0xff707070),
    //                 ),
    //                 borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(11.00),
    //                   bottomLeft: Radius.circular(11.00),
    //                 ),
    //               ),
    //               child: Text(
    //                 "SKIP",
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(fontFamily: "Montserrat"),
    //               ),
    //             ),
    //             Container(
    //               margin: EdgeInsets.only(
    //                 left: deviceSize.width * 0.08,
    //               ),
    //               width: deviceSize.height * 0.03,
    //               height: deviceSize.height * 0.03,
    //               // alignment: Alignment.bottomLeft,
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 shape: BoxShape.circle,
    //               ),
    //               child: Center(
    //                 child: Icon(
    //                   Icons.arrow_forward_ios,
    //                   size: deviceSize.height * 0.02,
    //                 ),
    //               ),
    //             )
    //             // Container(
    //             //   alignment: Alignment.centerRight,
    //             //   decoration: BoxDecoration(
    //             //     shape: BoxShape.circle,  color: Colors.red,
    //             //   ),
    //             // // button color
    //             //   child: Container(
    //             //     width: deviceSize.height * 0.03,
    //             //     height: deviceSize.height * 0.03,
    //             //     child: Icon(
    //             //       Icons.arrow_forward_ios,
    //             //       size: deviceSize.height * 0.02,
    //             //     ),
    //             //   ),
    //             // )

    //             // Container(
    //             //   alignment: Alignment.centerRight,
    //             //   height: deviceSize.height * 0.05,

    //             //   child: Container(
    //             //     padding: EdgeInsets.all(2.5),
    //             //     decoration: BoxDecoration(
    //             //    shape: BoxShape.circle,
    //             //    color: Colors.white,
    //             //   ),
    //             //     child: Center(
    //             //       child: Icon(
    //             //         Icons.arrow_forward_ios
    //             //       ),
    //             //     ),
    //             //   ),
    //             // )
    //           ],
    //           // height: 25.00,
    //           // width: 63.00,
    //         ),
    //       ));
  }

  // ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ T E X T S
  //
  // >>>>>>>>>>>> Standard Medium Text Style # 1 ( B R O W N )<<<<<<<<<<<<<<<
  //
  Widget standardTextStyle1(String _text) {
    return Text(
      _text,
      style: TextStyle(
        fontSize: 15,
        fontFamily: "Montserrat",
        color: Colors.brown,
      ),
    );
  }

  //
  // >>>>>>>>>>>> Standard Medium Text Style # 2 ( B L A C K ) <<<<<<<<<<<<<<<
  //
  Widget standardTextStyle2(String _text) {
    return Text(
      _text,
      style: TextStyle(
        fontSize: 15,
        fontFamily: "Montserrat",
        color: Colors.black,
      ),
    );
  }

  //
  // >>>>>>>>>>>> Standard Medium Text Style # 3 ( UNI - G R E E N ) <<<<<<<<<<<<<<<
  //
  Widget standardTextStyle3(String _text) {
    return Text(
      _text,
      style: TextStyle(
        fontSize: 15,
        fontFamily: "Uni-Sans",
        color: Colors.green,
      ),
    );
  }

  //
  // >>>>>>>>>>>> Standard Medium Text Style # 3 ( UNI - G R E E N ) <<<<<<<<<<<<<<<
  //
  Widget standardTextStyle4(String _text, Size widgetSize) {
    return Text(
      _text,
      style: TextStyle(
        fontSize: widgetSize.height * 0.025,
        fontFamily: "Montserrat",
        color: Colors.brown,
      ),
    );
  }

  //
  // >>>>>>>>>>>> Standard BASIC Heading Style # 1 (Brown) <<<<<<<<<<<<<<<
  //
  Widget standardBasicHeadingStyle1(String _text, Size deviceSize) {
    return Text(
      _text,
      style: TextStyle(
        fontFamily: "Montserrat",
        fontSize: deviceSize.height * 0.031,
        color: Color(0xff4d3814).withOpacity(0.71),
      ),
    );
  }

  //
  // >>>>>>>>>>>> Standard Heading Style # 1 (Light) <<<<<<<<<<<<<<<
  //
  Widget standardHeadingStyle1(String _text, Size deviceSize) {
    return Container(
      color: Constants().headerBgColor1,
      height: deviceSize.height * 0.04,
      width: deviceSize.width,
      padding: EdgeInsets.all(5),
      child: Text(
        _text,
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'Montserrat',
          color: Constants().headerTextColor1,
        ),
      ),
    );
  }

  //
  // >>>>>>>>>>>> Standard Heading Style # 2 (Dark) <<<<<<<<<<<<<<<
  //
  Widget standardHeadingStyle2(String _text, Size deviceSize) {
    return Container(
      color: Colors.brown,
      height: deviceSize.height * 0.05,
      width: deviceSize.width,
      padding: EdgeInsets.all(deviceSize.width * 0.013),
      child: Text(
        _text,
        style: TextStyle(
          fontSize: deviceSize.height * 0.022,
          fontFamily: 'Montserrat',
          color: Colors.white,
        ),
      ),
    );
  }

  // ------------------------------------------ T E X T   F E I L D S
  //
  // >>>>>>>>>>>> Standard Text Feild <<<<<<<<<<<<<<<
  //
// Widget standardTextFeild(){
//   return
// }

//
//  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> standard information style 1 <<<<<<<<<<<<<<<<<<
//
  Widget standardInfoStyle(String text1, String text2, Size widgetSize) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: widgetSize.height * 0.015),
          height: widgetSize.height * 0.02,
          width: widgetSize.width * 0.02,
          decoration: BoxDecoration(
            color: Color(0xff000000),
            border: Border.all(
              width: 1.00,
              color: Color(0xff000000),
            ),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: widgetSize.width * 0.04),
        Text(
          text1,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: widgetSize.height * 0.042,
            color: Color(0xff4D3814),
            shadows: [
              Shadow(
                offset: Offset(0.00, 3.00),
                color: Color(0xff000000).withOpacity(0.16),
                blurRadius: 6,
              ),
            ],
          ),
        ),
        Container(
          child: Text(
            text2,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: widgetSize.height * 0.044,
              color: Color(0xff2A6427),
              shadows: [
                Shadow(
                  offset: Offset(0.00, 3.00),
                  color: Color(0xff000000).withOpacity(0.16),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget standardButtonStyle1(String text, Size widgetSize) {
    return Container(
      height: widgetSize.height * 0.1,
      width: widgetSize.width,
      decoration: BoxDecoration(
        color: Color(0xffd6d8ff),
        border: Border.all(
          width: 1.00,
          color: Color(0xffffffff),
        ),
        borderRadius: BorderRadius.circular(23.00),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            color: Color(0xff2a6427),
          ),
        ),
      ),
    );
  }

  // ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ T E X T    F E I L D
  // Widget standardtextFeildStyle1(String  ){
  //  return  ClipRRect(
  //                 borderRadius: BorderRadius.all(
  //                   Radius.circular(widgetSize.height * 0.15),
  //                 ),
  //                 child: Container(
  //                   padding: EdgeInsets.symmetric(horizontal: widgetSize.width * 0.05),
  //                   height: widgetSize.height * 0.05,
  //                   width: widgetSize.width * 0.9,
  //                   color: Colors.white.withOpacity(0.7),
  //                   child: TextFormField(
  //                     style: TextStyle(fontSize: widgetSize.height * 0.03),
  //                     onChanged: (val) {
  //                       setState(() => dishName = val);
  //                     },
  //                     maxLines: 1,
  //                     obscureText: false,
  //                     cursorColor: Colors.brown,
  //                   ),
  //                 ),
  //               ),

  // }
}
