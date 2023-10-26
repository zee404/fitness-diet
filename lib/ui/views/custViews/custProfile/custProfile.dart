import 'dart:ui';
import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custProfileViewmodel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/chatViews/chathomecust.dart';
import 'package:fitness_diet/ui/views/custViews/custHome/Header/custAppDrawer.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custFurther/custinfo/custInfo.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custFurther/custplan/custNoplan.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custFurther/custplan/custPlan.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custProfileEdit.dart';
import 'package:fitness_diet/ui/widgets/Buttons/tabBarBtnStyle.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:fitness_diet/ui/shared/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../shared/imagesURLs.dart';

class CustProfile extends StatefulWidget {
  @override
  _CustProfileState createState() => _CustProfileState();
}

class _CustProfileState extends State<CustProfile>
    with SingleTickerProviderStateMixin {
  // ignore: unused_field
  ScrollController _scrollController;
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showEditBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      elevation: 20,
      builder: (context) {
        return CustProfileEdit();
      },
    );
  }

  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 2);
  }
// static BuildContext _context;
//   User user = Provider.of<User>(_context,listen: false);
//   Stream<CustData> stream;
//   @override
//   void initState() {
//     super.initState();
//     print("User: + ${user.uid}");
//     stream = DatabaseService(uid: user.uid).getCustData;

  // Future<void> someApi() {
  //   return Future(() {
  //     throw "FirstError()";
  //   }).catchError((error, stackTrace) {
  //     print("inner: $error");
  //     // although `throw SecondError()` has the same effect.
  //     return Future.error("SecondError()");
  //   });
  // }
  DateTime maxdate;
  @override
  Widget build(BuildContext context) {
    final _custData = Provider.of<CustData>(context);
    final _planData = Provider.of<Plan>(context);

    final deviceSize = MediaQuery.of(context).size;

    // return StreamBuilder<CustData>(
    //   stream: DatabaseService(uid: user.uid).getCustData,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasError) {
    //       print("Snapshot error ;;;;;;;;;;;;2: " + snapshot.error.toString());
    //     }

    //     if (snapshot.hasData && !snapshot.hasError) {
    //       print("It have data YES");
    // CustData _custData = snapshot.data;

    return BaseView<CustProfileViewModel>(
      // onModelReady: (model) {
      //   maxdate = model.calcMaxDate(_planData);
      // },
      builder: (context, model, child) => Material(
        child: ResponsiveSafeArea(
          builder: (context, deviceSize) => _custData == null
              ? Loading()
              : Scaffold(
                  key: _scaffoldKey,
                  endDrawer: CustAppDrawer(),
                  body: DefaultTabController(
                    length: 2,
                    child: Column(
                      //  crossAxisAlignment: CrossAxisAlignment.centerRight,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            // ---------------------------------------------------- B A C K G R O U N D    B L U R Y    I M A G E    C O V E R

                            Container(
                              //  alignment: alignment.centerleft;
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                ),
                                child: Container(
                                  //  alignment: alignment.center,
                                  height: deviceSize.height * 0.26,

                                  decoration: BoxDecoration(
                                    //color: Colors.yellow,
                                    image: DecorationImage(
                                      image: _custData.custPic != ""
                                          ? NetworkImage(_custData.custPic)
                                          : AssetImage(custBGImage_1),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 9.0, sigmaY: 9.0),
                                    child: Container(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // ---------------------------------------------------- H E A D E R   T E X T
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                //
                                // >>>>>>>>> B A C K   I C O N
                                //
                                Image.asset(
                                  backIcon,
                                  height: 25,
                                  width: 25,
                                ),

                                // >>>>>>>>> P R O F I L E   T E X T
                                //
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Profile",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily: "Montserrat",
                                    ),
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                  // color: Colors.white,
                                  icon: Icon(
                                    Icons.menu,
                                    size: deviceSize.height * 0.033,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                  onPressed: () {
                                    _scaffoldKey.currentState.openEndDrawer();
                                  },
                                ),

                                //
                                // >>>>>>>>> S I G N   O U T   B U T T O N
                              ],
                            ),
                            // ---------------------------------------------------- U S E R   I N F O
                            Container(
                              margin: EdgeInsets.only(
                                top: deviceSize.height * 0.1,
                                left: deviceSize.width * 0.07,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  //
                                  // >>>>>>>>> U S E R   I M A G E
                                  //
                                  Container(
                                    //     alignment: alignment.center,
                                    height: deviceSize.height * 0.1,
                                    width: deviceSize.height * 0.1,

                                    decoration: BoxDecoration(
                                      //color: Colors.yellow,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: _custData.custPic != ""
                                            ? NetworkImage(_custData.custPic)
                                            : AssetImage(custBGImage_1),
                                        // image:  AssetImage(custBGImage_1),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  // ClipOval(
                                  //   child: Image.asset(
                                  //     "assets/images/chef2.JPG",
                                  //     height: deviceSize.height * 0.1,
                                  //     width: deviceSize.height * 0.1,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  // ),
                                  // >>>>>>>>> U S E R   N A M E --A N D -- L O C A T I O N
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _custData.custName,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: deviceSize.height * 0.029,
                                            color: standardprofileNameColor,
                                            shadows: [
                                              Shadow(
                                                offset: Offset(0.00, 6.00),
                                                color: Color(0xff000000)
                                                    .withOpacity(0.16),
                                                blurRadius: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          _custData.custaddress.length == 0
                                              ? ' '
                                              : _custData.custaddress.values
                                                      .elementAt(0)[1]
                                                      .toString() +
                                                  ", " +
                                                  _custData.custaddress.values
                                                      .elementAt(0)[2]
                                                      .toString(),
                                          style: TextStyle(
                                            fontFamily: "UniSansRegular",
                                            fontSize: deviceSize.height * 0.02,
                                            color: standardprofileLocationColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(
                                  top: deviceSize.height * 0.22,
                                  right: deviceSize.width * 0.03),
                              child: Row(
                                children: <Widget>[
                                  //
                                  // >>>>>>>>> "E D I T"   B U T T O N
                                  //onPressed: () => _showEditBottomSheet(),
                                  SizedBox(
                                    width: deviceSize.width * 0.1,
                                  ),
                                  FlatButton(
                                    // onPressed: () => Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => CustProfileEdit()),
                                    // ),
                                    onPressed: _showEditBottomSheet,
                                    child: Container(
                                      height: deviceSize.height * 0.04,
                                      width: deviceSize.width * 0.35,
                                      decoration: BoxDecoration(
                                        color: Color(0xffe4d7cb),
                                        borderRadius:
                                            BorderRadius.circular(50.00),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Edit Profile",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "UniSansRegular",
                                            fontSize: deviceSize.height * 0.02,
                                            color: standarDishDisplayBGColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  //
                                  // >>>>>>>>> M E S S A G E   B U T T O N
                                  //
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatHomeCust(
                                                  currentUserId:
                                                      BaseViewModel().getUser,
                                                )),
                                      );
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            right: deviceSize.width * 0.006),
                                        height: deviceSize.height * 0.08,
                                        decoration: BoxDecoration(
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     offset: Offset(0.00, 4.00),
                                            //     color:
                                            //         Colors.black.withOpacity(0.3),
                                            //     blurRadius: 8,
                                            //   ),
                                            // ],
                                            ),
                                        child: Icon(
                                          FlevaIcons.message_circle,
                                          color: Colors.tealAccent,
                                          size: deviceSize.height * 0.06,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        //
                        // >>>>>>>>> I N F O   B A R
                        //
                        SizedBox(
                          height: deviceSize.height * 0.02,
                        ),
                        TabBar(
                          labelPadding: EdgeInsets.symmetric(
                              horizontal: deviceSize.width * 0.003),
                          indicator: BoxDecoration(),
                          labelStyle: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w700,
                            fontSize: deviceSize.height * 0.02,
                          ),
                          labelColor: Color(0xff2a6427),
                          controller: _tabController,
                          tabs: <Tab>[
                            Tab(
                              child: TabBarBtnStyle(
                                deviceSize: deviceSize,
                                btnText: "Info",
                              ),
                            ),
                            Tab(
                              child: TabBarBtnStyle(
                                deviceSize: deviceSize,
                                btnText: "Plan",
                              ),
                            ),
                          ],
                        ),

                        //
                        // >>>>>>>>> D Y N A M I C   S C R E E N
                        Expanded(
                          flex: 1,
                          child: Container(
                            //height: deviceSize.height * 0.625,
                            width: deviceSize.width,
                            margin:
                                EdgeInsets.only(top: deviceSize.height * 0.02),
                            child: TabBarView(
                              children: [
                                CustInfo(),
                                _custData != null
                                    ? _custData.planID != ''
                                        ? CustPlan()
                                        : CustNoPlan()
                                    : Loading(),
                              ],
                              controller: _tabController,
                            ),
                          ),
                        ),
                        //
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
    // } else {
    //   return Container(
    //     child: Center(
    //         child: Text("No data in snapshot" + user.uid.toString())),
    //   );
    // }
  }
  //);
}
//}
