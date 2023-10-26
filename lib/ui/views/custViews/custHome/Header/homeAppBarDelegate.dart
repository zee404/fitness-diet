import 'dart:math';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/imagesURLs.dart';
import 'package:fitness_diet/ui/views/custViews/custHome/Header/searchBar.dart';
import 'package:fitness_diet/ui/views/searchdishview.dart';
import 'package:flutter/material.dart';

class HomeAppBarDelegate extends SliverPersistentHeaderDelegate {
  HomeAppBarDelegate({@required this.maxExtent, @required this.minExtent});
  final double maxExtent;
  final double minExtent;
  double animationVal = 0;
  double temp = 0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    animationVal = 10.0 - max(10.0, shrinkOffset * 10) / maxExtent;
    temp = maxExtent / 1.1 - shrinkOffset;

    return ResponsiveSafeArea(
      builder: (context, deviceSize) => Stack(
        fit: StackFit.loose,
        overflow: Overflow.visible, // * Overflowing children will be visible.
        children: <Widget>[
          //
          //  >>>>>>>>> Cover Picture
          //
          Container(
            margin: EdgeInsets.only(bottom: deviceSize.height * 0.09),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(foodMenuCoverImage),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(deviceSize.height * 0.20),
                bottomRight: Radius.circular(deviceSize.height * 0.20),
              ),
            ),
          ),
          //
          //  >>>>>>>>> Fitness Diet (Heading)
          //
          Container(
            margin: EdgeInsets.only(
                left: deviceSize.width * 0.061, top: deviceSize.height * 0.59),
            child: Text(
              "Fitness Diet",
              style: TextStyle(
                fontFamily: "Bahnschrift",
                fontSize: deviceSize.height * 0.14,
                color: Color(0xffd6d625).withOpacity(animationVal / 10),
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
          //
          //  >>>>>>>>> Slogan
          //
          Container(
            margin: EdgeInsets.only(
              //     top: deviceSize.height * animationVal / 13,
              top: deviceSize.height * 0.75,
              left: deviceSize.width * 0.07,
            ),
            child: Text(
              "Eat healthy, Stay healthy",
              style: TextStyle(
                fontFamily: "Bahnschrift",
                fontSize: deviceSize.height * 0.05,
                color: Color(0xfffcfcfc).withOpacity(animationVal / 10),
              ),
            ),
          ),
          // ---------------------------------------------------- S E A R C H   B A R
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchDishView(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                  top: animationVal < 3.9 ? 3.9 * 20 : temp - 15),
              padding:
                  EdgeInsets.symmetric(horizontal: deviceSize.width * 0.06),

              //    color: Colors.amber,
              child: SearchBar(),
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // double get maxExtent => maxExtent;

  // @override
  // double get minExtent => minExtent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
