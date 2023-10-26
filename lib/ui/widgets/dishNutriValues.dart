import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:fitness_diet/ui/widgets/Texts/nutriHeadingAndValueSmall.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DishNutriValues extends StatelessWidget {
  Dish passedDish;
  DishNutriValues({@required this.passedDish});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 3.00),
            color: Colors.black26,
            blurRadius: 15,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                "KCAL",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: fontLemonMilk,
                  fontSize: 20,
                  color: Color(0xff240303).withOpacity(0.51),
                ),
              ),
              Text(
                passedDish.dishKcal.toStringAsFixed(0),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: fontLemonMilk,
                  fontSize: 20,
                  color: Color(0xffCAB5A1),
                ),
              ),
            ],
          ),
          Spacer(),
          NutriHeadingAndValueSmall(
            passedHeading: "Fat",
            passedValue: passedDish.dishFat.toStringAsFixed(0),
          ),
          SizedBox(width: 10),
          NutriHeadingAndValueSmall(
            passedHeading: "Protein",
            passedValue: passedDish.dishProtein.toStringAsFixed(0),
          ),
          SizedBox(width: 10),
          NutriHeadingAndValueSmall(
            passedHeading: "Carbs",
            passedValue: passedDish.dishCarb.toStringAsFixed(0),
          ),
        ],
      ),
    );
  }
}
