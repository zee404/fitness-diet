import 'package:fitness_diet/ui/responsive/responsiveBuilder.dart';
import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class RadioItemCustom extends StatelessWidget {
  // final AddrRadioModel _item;
  // RadioItemCustom(this._item);
  String addrTitle, addrText;
  bool isSelected;
  RadioItemCustom({
    @required this.addrTitle,
    @required this.addrText,
    @required this.isSelected,
  });
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Container(
        alignment: Alignment.centerLeft,
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 10),
        //  width: sizingInformation.screenSize.width * 0.89,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.white,
          // border: Border.all(
          //   width: 1.0,
          //   color: _item.isSelected
          //       ? Colors.lightGreenAccent.withOpacity(0.3)
          //       : Colors.grey,
          // ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 3.00),
              color: Color(0xff000000).withOpacity(0.16),
              blurRadius: 6,
            ),
          ],
          borderRadius: const BorderRadius.all(
            const Radius.circular(30),
          ),
        ),
        child: Row(
          children: [
            isSelected
                ? Icon(
                    FontAwesomeIcons.solidCheckCircle,
                    color: Colors.white,
                    size: 17,
                  )
                : Icon(
                    FontAwesomeIcons.circle,
                    size: 17,
                  ),
            SizedBox(width: 10),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    addrTitle,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 14.0,
                      fontFamily: fontMontserrat,
                    ),
                  ),
                  Text(
                    addrText,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 10,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class RadioModel {
//   bool isSelected;
//   final String buttonText;
//   final String text;

//   RadioModel(this.isSelected, this.buttonText, this.text);
// }
// class CustomRadio extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CustomCheckBoxGroup(
//       buttonTextStyle: ButtonTextStyle(
//         selectedColor: Colors.red,
//         unSelectedColor: Colors.orange,
//         textStyle: TextStyle(fontSize: 10),
//       ),
//       unSelectedColor: Theme.of(context).canvasColor,
//       buttonLables: [
//         "Home",
//         "Office",
//       ],
//       buttonValuesList: [
//         "home",
//         "officeq",
//       ],
//       checkBoxButtonValues: (values) {
//         print(values);
//       },
//       spacing: 0,
//       defaultSelected: ["Monday"],
//       horizontal: true,
//       enableButtonWrap: true,
//       width: 20,
//       absoluteZeroSpacing: false,
//       selectedColor: Theme.of(context).accentColor,
//       padding: 10,
//     );
//   }
// }
