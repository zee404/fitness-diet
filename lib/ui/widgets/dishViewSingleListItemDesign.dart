import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class DishViewSingleListItemDesign extends StatelessWidget {
  String dishName, chefName, dishPic;
  double kcal, ratings;
  int price;

  DishViewSingleListItemDesign({
    @required this.dishName,
    @required this.chefName,
    @required this.kcal,
    @required this.price,
    @required this.ratings,
    @required this.dishPic,
  });

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;

// ---------------------------------------------------- R E D I R E C T I N G   T O   N E W P A G E   O N   C L I C K
// * Returning new screen of dish view (Some clickable widgets : GestureDetector, InkWell, InkResponse.)
    return Container(
      height: _deviceSize.height * 0.13,
      width: _deviceSize.width,
      margin: EdgeInsets.symmetric(horizontal: _deviceSize.width * 0.017),

      //color: Colors.amber,
      child: Stack(
        children: <Widget>[
          Container(
            width: _deviceSize.width * 5,
            margin: EdgeInsets.only(
              left: _deviceSize.width * 0.08,
              top: _deviceSize.height * 0.012,
              bottom: _deviceSize.height * 0.012,
            ),
            decoration: BoxDecoration(
              color: Color(0xffe4d7cb),
              // color: Colors.amber,
              boxShadow: [
                BoxShadow(
                  offset: Offset(2.00, 3.00),
                  color: Colors.black45,
                  blurRadius: 5,
                ),
              ],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(_deviceSize.height * 0.03),
                bottomRight: Radius.circular(_deviceSize.height * 0.03),
              ),
            ),
            //
            // >>>>>>>>   D I S H E S    C O N T E N T
            //
            child: Container(
              margin: EdgeInsets.only(
                top: _deviceSize.height * 0.002,
                left: (_deviceSize.width * 0.265 - _deviceSize.width * 0.08) +
                    10, // Food Image width - BG conatiner left margin
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // >>>>>>>>>>>>>> Dish Name
                  Text(
                    dishName.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: _deviceSize.height * 0.02,
                      color: Color(0xff4e7a0b),
                    ),
                  ),
                  // >>>>>>>>>>>>>> Chef Name
                  Text(
                    chefName.toString(),
                    style: TextStyle(
                      fontFamily: "UniSansRegular",
                      fontSize: _deviceSize.height * 0.015,
                      color: Color(0xff000000),
                    ),
                  ),
                  // >>>>>>>>>>>>>> Dish Ratings
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: ratings,
                        itemCount: 5,
                        itemSize: _deviceSize.height * 0.015,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                      Text(
                        "($ratings)",
                        style: TextStyle(fontSize: _deviceSize.height * 0.015),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // -------------- Price
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(
                right: _deviceSize.width * 0.05,
                bottom: _deviceSize.height * 0.018),
            child: Text(
              price.toString() + "Rs",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Lemon-Milk",
                fontSize: _deviceSize.height * 0.023,
                color: Color(0xff030300),
              ),
            ),
          ),
          // --------------- Calories bar
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: _deviceSize.height * 0.026,
              width: _deviceSize.width * 0.38,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(
                left:
                    (_deviceSize.width * 0.265 - _deviceSize.width * 0.08) / 2,
                bottom: _deviceSize.height * 0.003,
              ),
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
                margin: EdgeInsets.only(right: _deviceSize.width * 0.02),
                child: Text(
                  kcal.toString() + " Kcal",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Lemon-Milk",
                    fontSize: _deviceSize.height * 0.012,
                    color: Color(0xff38631d),
                  ),
                ),
              ),
            ),
          ),
          // =============> IMage
          Container(
            height: _deviceSize.width * 0.265,
            width: _deviceSize.width * 0.265,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(dishPic), fit: BoxFit.cover),
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
    );
  }
}
