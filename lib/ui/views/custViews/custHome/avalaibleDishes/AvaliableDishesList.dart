import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:flutter/material.dart';

class AvailableDishesList extends StatelessWidget {
  AvailableDishesList({
    @required this.foodItem,
  });
  final Map foodItem;

  final double widthFactor = 0;

  @override
  Widget build(BuildContext context) {
// ---------------------------------------------------- R E D I R E C T I N G   T O   N E W P A G E   O N   C L I C K
// * Returning new screen of dish view (Some clickable widgets : GestureDetector, InkWell, InkResponse.)
    return ResponsiveSafeArea(
      builder: (context, deviceSize) => InkResponse(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
              // builder: (context) => DishView(
              //   foodItem: foodItem,
              //   foodItemID: foodItem['id'],
              // ),
            ),
          );
        },

        // * Returning new screen of dish view (Some clickable widgets : GestureDetector, InkWell, InkResponse.)

        child: Container(
          margin: EdgeInsets.all(8),
          child: Stack(
            children: <Widget>[
              Container(
                height: deviceSize.height * 0.7,
                width: deviceSize.width * 0.85,
                margin: EdgeInsets.only(
                  left: deviceSize.width * 0.20,
                  top: deviceSize.height * 0.09,
                  bottom: deviceSize.height * 0.09,
                ),
                decoration: BoxDecoration(
                  color: Color(0xffe4d7cb),
                  // color: Colors.amber,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(5.00, 5.00),
                      color: Colors.black.withOpacity(0.16),
                      blurRadius: 12,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(deviceSize.height * 0.11),
                    bottomRight: Radius.circular(deviceSize.height * 0.11),
                  ),
                ),
                // >>>>>>>>   D I S H E S    C O N T E N T
                // child: Container(
                //   margin: EdgeInsets.only(
                //     top: deviceSize.height * 0.032,
                //     left: deviceSize.width * 0.15,
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: <Widget>[
                //       Text(
                //         foodItem['dishName'].toString().toUpperCase(),
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //           fontFamily: "Montserrat",
                //           fontSize: deviceSize.height * 0.15,
                //           color: Color(0xff4e7a0b),
                //         ),
                //       ),
                //       Text(
                //         " By Khan",
                //         style: TextStyle(
                //           fontFamily: "UniSansRegular",
                //           fontSize: deviceSize.height * 0.09,
                //           color: Color(0xff000000),
                //         ),
                //       ),
                //       Container(
                //         height: deviceSize.height * 0.1,
                //         width: deviceSize.width * 0.3,
                //         child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Icon(
                //               Icons.star,
                //               color: Colors.green,
                //               size: deviceSize.height * 0.1,
                //             ),
                //             Icon(
                //               Icons.star,
                //               color: Colors.green,
                //               size: deviceSize.height * 0.1,
                //             ),
                //             Icon(
                //               Icons.star,
                //               color: Colors.green,
                //               size: deviceSize.height * 0.1,
                //             ),
                //             Icon(
                //               Icons.star,
                //               color: Colors.green,
                //               size: deviceSize.height * 0.1,
                //             ),
                //             Icon(
                //               Icons.star_half,
                //               color: Colors.green,
                //               size: deviceSize.height * 0.1,
                //             ),
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ),

              // -------------- Price
              Container(
                margin: EdgeInsets.only(
                    left: deviceSize.width * 0.7, top: deviceSize.height * 0.5),
                child: Text(
                  "Rs500",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Lemon-Milk",
                    fontSize: deviceSize.height * 0.12,
                    color: Color(0xff030300),
                  ),
                ),
              ),
              // --------------- Calories bar
              Container(
                height: deviceSize.height * 0.16,
                width: deviceSize.width * 0.38,
                margin: EdgeInsets.only(
                    left: deviceSize.width * 0.18,
                    top: deviceSize.height * 0.67),
                padding: EdgeInsets.only(
                    top: deviceSize.height * 0.02,
                    left: deviceSize.width * 0.09),
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  border: Border.all(
                    width: 1.00,
                    color: Color(0xffc48551),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.00, 3.00),
                      color: Color(0xff000000).withOpacity(0.16),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Container(
                  child: Text(
                    "280 Kcal",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Lemon-Milk",
                      fontSize: deviceSize.height * 0.08,
                      color: Color(0xff38631d),
                    ),
                  ),
                ),
              ),
              Container(
                height: deviceSize.height * 0.85,
                width: deviceSize.height * 0.85,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(foodItem['dishPic']),
                      fit: BoxFit.cover),
                  border: Border.all(
                    width: 3.00,
                    color: Color(0xff707070).withOpacity(0.5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.00, 3.00),
                      color: Color(0xff000000).withOpacity(0.16),
                      blurRadius: 6,
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(111.00, 116.00),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
