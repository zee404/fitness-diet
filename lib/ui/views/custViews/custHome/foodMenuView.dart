import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/foodmenueViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/soleDishView.dart';
import 'package:fitness_diet/ui/views/custViews/custHome/Header/custAppDrawer.dart';
import 'package:fitness_diet/ui/views/custViews/custHome/Header/guestappdrawer.dart';
import 'package:fitness_diet/ui/views/custViews/custHome/Header/homeAppBarDelegate.dart';
import 'package:fitness_diet/ui/views/custViews/custHome/Header/locationHeader.dart';
import 'package:fitness_diet/ui/views/custViews/custHome/recentFoodSlider/recentFoodSlider.dart';
import 'package:fitness_diet/ui/widgets/dishViewSingleListItemDesign.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingNoBg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FoodMenuView extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _dishData = Provider.of<List<Dish>>(context);
    final _user = Provider.of<CurrentUser>(context);
    final _allChefsData = Provider.of<List<ChefData>>(context);

    final deviceSize = MediaQuery.of(context).size;

    return BaseView<FoodMenueViewModel>(
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, widgetSize) => Scaffold(
          key: _scaffoldKey,
          endDrawer: _user != null ? CustAppDrawer() : GuestAppDrawer(),
          body: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  // ---------------------------------------------------- A P P   B A R   H E A D E R
                  SliverPersistentHeader(
                    delegate: HomeAppBarDelegate(
                      maxExtent: widgetSize.height * 0.36,
                      minExtent: widgetSize.height * 0.05,
                    ),
                    pinned: false,
                    floating: false,
                  ),
// ---------------------------------------------------- R E C E N T   F O O D   C O U R S A L   S L I D E R
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        //
                        // >>>>>>>>> R E C E N T  Heading
                        //
                        Container(
                          // * To align the text container to the left
                          alignment: Alignment.bottomLeft,

                          padding: EdgeInsets.all(widgetSize.width * 0.022),

                          child: StandardHeadingNoBg(
                            passedText: "Recent",
                          ),
                        ),
                        // SizedBox(
                        //   height: widgetSize.height * 0.01,
                        // ),
                        Container(
                          height: widgetSize.height * 0.13,
                          child: RecentFoodSlider(),
                        ),
                        SizedBox(
                          height: widgetSize.height * 0.017,
                        ),
                      ],
                    ),
                  ),

                  // ---------------------------------------------------- A V A L A I B L E    D I S H E S    L I S T
                  SliverToBoxAdapter(
                    child: Container(
                      // * To align the text container to the left
                      alignment: Alignment.bottomLeft,

                      padding: EdgeInsets.all(widgetSize.width * 0.022),

                      child: StandardHeadingNoBg(
                        passedText: "Available dishes",
                      ),
                    ),
                  ),

                  _dishData != null
                      ? SliverFixedExtentList(
                          itemExtent: deviceSize.height * 0.13,
                          delegate: SliverChildListDelegate(
                            [
                              ..._dishData.map((dish) {
                                // print(
                                //     ">>>>>>>>>>>> dish._chefName inside chefDishesView: " +
                                //         dish.dishName);
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: widgetSize.height * 0.002,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SoleDishView(
                                            passedDish: dish,
                                            isFromCustView: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: DishViewSingleListItemDesign(
                                      dishName: dish.dishName,
                                      chefName: model.extractedChefName(
                                          _allChefsData, dish.chefID),
                                      kcal: dish.dishKcal,
                                      price: dish.dishPrice,
                                      ratings: dish.dishRatings,
                                      dishPic: dish.dishPic,
                                    ),
                                  ),
                                );
                              }).toList()
                            ],
                          ),
                        )
                      : SliverToBoxAdapter(
                          child: Container(),
                        ),
                ],
              ),
              // ---------------------------------------------------- A P P   B A R   H E A D E R

              LocationHeader(),

              //  ---------------------------------------------------- M E N U   D R A W E R
              Container(
                //color: Colors.amber,
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(
                  top: widgetSize.height * 0.0001,
                  left: widgetSize.width * 0.09,
                  bottom: widgetSize.height * 0.93,
                ),
                child: IconButton(
                  // color: Colors.white,
                  icon: Icon(
                    Icons.menu,
                    size: widgetSize.height * 0.033,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openEndDrawer();
                  },
                ),
              ),

              model.state == ViewState.Busy ? Loading() : Container(),
              model.hasErrorMessage
                  ? Container(
                      color: Colors.red,
                      child: Text(
                        model.errorMessage,
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
