import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class OrderSingleStage extends StatelessWidget {
  String primaryText, secondaryText;
  IconData passedIcon;
  bool isDone;
  OrderSingleStage({
    @required this.primaryText,
    @required this.secondaryText,
    @required this.passedIcon,
    @required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.white.withOpacity(0.3),
      child: Row(
        children: [
          SizedBox(width: 15),
          IconButton(
            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
            icon: FaIcon(
              passedIcon,
              color: isDone ? Colors.green : Colors.green.withOpacity(0.4),
            ),
            onPressed: () {},
          ),
          SizedBox(width: 15),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  primaryText,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: fontMontserrat,
                    color:
                        isDone ? Colors.brown : Colors.brown.withOpacity(0.4),
                  ),
                ),
                Text(
                  secondaryText,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDone
                        ? Colors.black54
                        : Colors.black54.withOpacity(0.4),
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
