import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class BriefChefInfo extends StatelessWidget {
  ChefData passedChefData;
  BriefChefInfo({@required this.passedChefData});
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: 96.00,
      width: 345.00,
      margin: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Color(0xffe4d7cb),
        boxShadow: [
          BoxShadow(
            offset: Offset(2.00, 3.00),
            color: Color(0xff000000).withOpacity(0.4),
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(50.00),
      ),
      child: Row(
        children: [
          new Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(passedChefData.chefPic),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                width: 2.00,
                color: Color(0xff707070),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 3.00),
                  color: Color(0xff000000).withOpacity(0.16),
                  blurRadius: 6,
                ),
              ],
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                passedChefData.chefName.toString(),
                style: TextStyle(
                  fontFamily: fontUniSans,
                  fontSize: 17,
                  color: Color(0xff000000),
                ),
              ),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: passedChefData.chefRatings,
                    itemCount: 5,
                    itemSize: deviceSize.height * 0.015,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  Text(
                    "(" + passedChefData.chefRatings.toString() + ")",
                    style: TextStyle(
                      fontSize: deviceSize.height * 0.015,
                    ),
                  ),
                ],
              ),
              Text(
                "Followers (" +
                    passedChefData.chefFollowers.length.toString() +
                    ")",
                style: TextStyle(
                  fontFamily: fontUniSans,
                  fontSize: 12,
                  color: Color(0xff000000).withOpacity(0.61),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
