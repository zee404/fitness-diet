import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/core/viewmodels/chefProfileViewModels/chefProfileViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/ChefSliverAppBar.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefFurtherInfo/chefAppDrawer.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefFurtherInfo/chefDish/chefDishesView.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefFurtherInfo/chefInfo/chefInfo.dart';
import 'package:fitness_diet/ui/widgets/Buttons/tabBarBtnStyle.dart';
import 'package:fitness_diet/ui/widgets/Texts/ProfileHeaderText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChefProfileView extends StatefulWidget {
  @override
  _ChefProfileViewState createState() => _ChefProfileViewState();
}

class _ChefProfileViewState extends State<ChefProfileView>
    with SingleTickerProviderStateMixin {
  int pageViewIndex = 0;
  // PageController _pgController = PageController();
  List pageContent = [
    ChefDishes(
      chefID: BaseViewModel().getUser,
      isfromchef: true,
    ),
    ChefInfo()
  ];
  ScrollController _scrollController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TabController _tabController;
  int widgetCountBeforeSliverOverlapAbsorber = 1;
  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final _dishData = Provider.of<List<Dish>>(context);
    Stream<List<ChefData>> _chefData;
    print("----> __chefData inside chefProfileView : " + _chefData.toString());
    return BaseView<ChefProfileViewModel>(
      onModelReady: (model) async {
        String currentChefID = model.getUser;

        print("currentChefID: " + currentChefID.toString());
        _chefData = model.getSingleChefData(currentChefID);
        print("inOnModelReady : " + _chefData.first.toString());
      },
      builder: (context, model, child) => model.state == ViewState.Busy
          ? Loading()
          : ResponsiveSafeArea(
              builder: (context, widgetSize) => StreamBuilder<List<ChefData>>(
                stream: _chefData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    ChefData chefData = snapshot.data[0];
                    return Scaffold(
                      key: _scaffoldKey,
                      endDrawer: ChefAppDrawer(),
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
                                    chefData: chefData, isfromchef: true,
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

                                SliverPersistentHeader(
                                  delegate: tabsDelegate(
                                    _tabController,
                                    deviceSize.height * 0.051, // MaxExtent
                                    deviceSize.height * 0.050, // MinExtent
                                  ),
                                  pinned: true,
                                  floating: false,
                                ),
                              ];
                            },
                            //
                            // >>>>>>>>>>> Tabbars display
                            //
                            body: TabBarView(
                              children: [
                                _dishData == null && chefData == null
                                    ? Loading()
                                    : ChefDishes(
                                        chefID: chefData.chefID,
                                        isfromchef: true,
                                      ),
                                ChefInfo(),
                              ],
                              controller: _tabController,
                            ),
                          ),

                          //  ----------------------------------------------------   D R A W E R

                          Container(
                            margin: EdgeInsets.only(
                                left: deviceSize.height * 0.03,
                                top: deviceSize.height * 0.018),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //
                                // >>>>>>>>> P R O F I L E   T E X T
                                //
                                ProfielHeaderText(),

                                Spacer(),

                                IconButton(
                                  icon: Icon(
                                    Icons.menu,
                                    size: widgetSize.height * 0.033,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                  onPressed: () {
                                    _scaffoldKey.currentState.openEndDrawer();
                                  },
                                ),
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

// ignore: camel_case_types
class tabsDelegate extends SliverPersistentHeaderDelegate {
  final double maxextent;
  final double minextent;
  double temp = 0;
  tabsDelegate(this._tabController, this.maxextent, this.minextent);

  TabController _tabController;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // temp = maxExtent / 1.1 - shrinkOffset;
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      // decoration: BoxDecoration(
      // color: Colors.white,
      //   borderRadius: BorderRadius.circular(deviceSize.height * 0.4),
      // ),
      child: TabBar(
        // indicatorWeight: 2,
        //   indicatorColor: Colors.brown,
        labelPadding:
            EdgeInsets.symmetric(horizontal: deviceSize.width * 0.003),

        indicator: BoxDecoration(),
        labelStyle: TextStyle(
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w700,
          fontSize: deviceSize.height * 0.02,
          // color: Color(0xff2a6427),
        ),
        labelColor: Color(0xff2a6427),
        tabs: <Tab>[
          Tab(child: TabBarBtnStyle(deviceSize: deviceSize, btnText: "Dishes")),
          Tab(child: TabBarBtnStyle(deviceSize: deviceSize, btnText: "Info")),
        ],
        controller: _tabController,
      ),
    );
  }

  @override
  bool shouldRebuild(tabsDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => maxextent;

  @override
  double get minExtent => minextent;
}
