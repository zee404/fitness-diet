import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custPlanViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../../../baseView.dart';

class MealsSwiper extends StatelessWidget {
  Plan planData;

  MealsSwiper({
    @required this.planData,
  });

  @override
  Widget build(BuildContext context) {
    String previousdateMeals;
    return BaseView<CustPlanViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Swiper(
          // containerHeight: 10.0,
          // itemHeight: 10.0,
          loop: false,
          // pagination: new SwiperPagination(),
          itemCount: model.getUnigueDateCount(planData.custMeals) < 7
              ? model.getUnigueDateCount(planData.custMeals)
              : 7,
          itemBuilder: (BuildContext context, int index) {
            // geting list of exercise on the same day

            if (previousdateMeals !=
                model.formateDateForDifference(
                    planData.custMeals.keys.elementAt(index))) {
              Map<String, dynamic> newList = model.getExerciseList(
                  planData.custMeals.keys.elementAt(index), planData.custMeals);
              previousdateMeals = model.formateDateForDifference(
                  planData.custMeals.keys.elementAt(index));
              print(
                  '---------------------------------new list length in list builder in meals ' +
                      newList.length.toString());
              return Container(
                height: 10.0,
                color: Colors.yellow,
              );
              // CustMeals(mealsList: newList);
              //

            }
          },
        ),
      ),
    );
  }
}
