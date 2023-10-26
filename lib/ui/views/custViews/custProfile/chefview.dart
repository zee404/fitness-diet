import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/chefProfileViewModels/chefProfileViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/ChefSliverAppBar.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefFurtherInfo/chefDish/chefDishesView.dart';
import 'package:fitness_diet/ui/views/custViews/custHome/Header/custAppDrawer.dart';
import 'package:fitness_diet/ui/widgets/Texts/ProfileHeaderText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../baseView.dart';

// ignore: must_be_immutable
class ChefView extends StatefulWidget {
  String chefID;
  ChefView({
    @required this.chefID,
  });
  @override
  _ChefViewState createState() => _ChefViewState();
}

class _ChefViewState extends State<ChefView> {
  int pageViewIndex = 0;
  // PageController _pgController = PageController();
  // List pageContent = [ChefDishes(), ChefInfo()];
  ScrollController _scrollController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TabController _tabController;
  int widgetCountBeforeSliverOverlapAbsorber = 1;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final _dishData = Provider.of<List<Dish>>(context);
    Stream<List<ChefData>> _chefData;
    return BaseView<ChefProfileViewModel>(
      onModelReady: (model) async {
        String currentChefID = widget.chefID;
        print("currentChefID: " + currentChefID.toString());
        _chefData = model.getSingleChefData(currentChefID);
        print("inOnModelReady : " + _chefData.toString());
      },
      builder: (context, model, child) => model.state == ViewState.Busy
          ? Loading()
          : ResponsiveSafeArea(
              builder: (context, widgetSize) => StreamBuilder<List<ChefData>>(
                stream: _chefData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    ChefData chefData = snapshot.data[0];
                    return WillPopScope(
                      // ignore: missing_return
                      onWillPop: () {
                        Navigator.pop(context, 'Yep!');
                      },
                      child: Scaffold(
                        key: _scaffoldKey,
                        endDrawer: CustAppDrawer(),
                        body: Stack(
                          fit: StackFit.loose,
                          children: [
                            NestedScrollView(
                              controller: _scrollController,
                              headerSliverBuilder: (BuildContext context,
                                  bool innerBoxIsScrolled) {
                                return [
                                  //
                                  // >>>>>>>>>>> Header content
                                  //

                                  SliverPersistentHeader(
                                    delegate: ChefSliverAppBar(
                                      maxExtent: deviceSize.height * 0.3,
                                      minExtent: deviceSize.height * 0.26,
                                      // chefName: chefData.chefName,
                                      // chefPic: chefData.chefPic,
                                      chefData: chefData, isfromchef: false,
                                    ),
                                    pinned: true,
                                    floating: false,
                                  ),
                                  //
                                  // >>>>>>>>>>> Space between tabbar and header
                                  //
                                  SliverToBoxAdapter(
                                    child: SizedBox(
                                      height: deviceSize.height * 0.02,
                                    ),
                                  ),
                                  //
                                  // >>>>>>>>>>> Tabbars
                                  //

                                  // SliverPersistentHeader(
                                  //   delegate: tabsDelegate(
                                  //     _tabController,
                                  //     deviceSize.height * 0.051, // MaxExtent
                                  //     deviceSize.height * 0.050, // MinExtent
                                  //   ),
                                  //   pinned: true,
                                  //   floating: false,
                                  // ),
                                ];
                              },
                              //
                              // >>>>>>>>>>> Tabbars display
                              //
                              body: ChefDishes(
                                chefID: widget.chefID,
                                isfromchef: false,
                              ),
                              //  TabBarView(
                              //   children: [
                              //     _dishData == null && chefData == null
                              //         ? Loading()
                              //         : ChefDishes(),
                              //     ChefInfo(),
                              //   ],
                              //   controller: _tabController,
                              // ),
                            ),

                            //  ----------------------------------------------------   D R A W E R

                            Container(
                              margin: EdgeInsets.only(
                                  left: deviceSize.height * 0.03,
                                  top: deviceSize.height * 0.018),
                              //   color: Colors.red,
                              child: Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //
                                  // >>>>>>>>> P R O F I L E   T E X T
                                  //
                                  ProfielHeaderText(),

                                  Spacer(),

                                  IconButton(
                                    // color: Colors.white,
                                    icon: Icon(
                                      Icons.menu,
                                      size: widgetSize.height * 0.033,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                    onPressed: () {
                                      _scaffoldKey.currentState.openEndDrawer();
                                    },
                                  ),
                                  // Container(
                                  //   //color: Colors.amber,
                                  //   alignment: Alignment.topRight,
                                  //   margin: EdgeInsets.only(
                                  //     top: widgetSize.height * 0.0001,
                                  //     left: widgetSize.width * 0.09,
                                  //     bottom: widgetSize.height * 0.93,
                                  //   ),
                                  //   child:
                                  // ),
                                ],
                              ),
                            ),
                            model.hasErrorMessage
                                ? Container(
                                    child: Text(model.errorMessage),
                                  )
                                : Container(),
                            model.state == ViewState.Busy
                                ? Loading()
                                : Container(),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Scaffold(
                      body: Center(child: Text("No data for selected user")),
                    );
                  }
                },
              ),
            ),
    );
  }
}
