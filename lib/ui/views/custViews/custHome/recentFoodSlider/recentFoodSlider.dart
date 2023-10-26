import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/orderViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/widgets/foodSliderItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../baseView.dart';
import '../../../soleDishView.dart';

class RecentFoodSlider extends StatefulWidget {
  @override
  _RecentFoodSliderState createState() => _RecentFoodSliderState();
}

class _RecentFoodSliderState extends State<RecentFoodSlider> {
  List<String> _recentFoods = List<String>();
  Order singleOrderInfo;
  @override
  Widget build(BuildContext context) {
    final _dishData = Provider.of<List<Dish>>(context);
    final _user = Provider.of<CurrentUser>(context);
    final _allChefsData = Provider.of<List<ChefData>>(context);
    final _allOrdersInfo = Provider.of<List<Order>>(context);

    return BaseView<OrderViewModel>(
      onModelReady: (model) {
        print("READY");
        int length = _allOrdersInfo.length > 3 ? 3 : _allOrdersInfo.length;
        for (int i = 0; i < length; i++) {
          for (int j = 0; j < _allOrdersInfo[i].items.length; j++) {
            if (!_recentFoods
                .contains(_allOrdersInfo[i].items.keys.elementAt(j))) {
              _recentFoods.add(_allOrdersInfo[i].items.keys.elementAt(j));
            }
          }
        }
        // _chefData =
        //     model.getSingleChefData(_allOrdersInfo.elementAt(0).chefID);
      },
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, widgetSize) => Container(
          height: widgetSize.height,
          child: _recentFoods.length > 0
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _recentFoods.length > 5 ? 5 : _recentFoods.length,
                  itemBuilder: (context, index) {
                    final _singleItemID = _recentFoods.elementAt(index);
                    return StreamBuilder<Dish>(
                        stream: DatabaseService()
                            .getSingleDishforordersummary(_singleItemID),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Dish _singleiteminfo = snapshot.data;
                            return Container(
                              width: widgetSize.width * 0.53,
                              margin: index == 0
                                  ? EdgeInsets.only(
                                      left: widgetSize.width * 0.025)
                                  : EdgeInsets.only(
                                      left: widgetSize.width * 0.015),
                              child: FoodSliderItem(_singleiteminfo),
                            );
                          } else {
                            return Container();
                          }
                        });
                  },
                )
              : Text('No Recent Dish '),
        ),
      ),
    );
  }
}
