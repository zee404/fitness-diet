import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_diet/core/enums/dialogTypes.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/DatabaseServices/dbHelperFtns.dart';
import 'package:fitness_diet/core/services/dialogService.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/imagesURLs.dart';
import 'package:fitness_diet/ui/views/chatViews/chat.dart';
import 'package:fitness_diet/ui/views/chatViews/chatHomeChef.dart';
import 'package:fitness_diet/ui/views/chatViews/const.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefProfileEditView.dart';
import 'package:fitness_diet/ui/widgets/Buttons/standardBtnWhitishRound.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../locator.dart';

class ChefSliverAppBar extends SliverPersistentHeaderDelegate {
  // final CollectionReference custCollection =
  //     FirebaseFirestore.instance.collection('customer');
  final double maxExtent;
  final double minExtent;
  double animationVal = 0;
  ChefData chefData;
  bool isfromchef;
  // String chefName, chefPic;
  ChefSliverAppBar({
    @required this.maxExtent,
    @required this.minExtent,
    // @required this.chefName,
    // @required this.chefPic,
    @required this.chefData,
    @required this.isfromchef,
  });
  void _showEditBottomSheet(BuildContext _context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: _context,
      isScrollControlled: true,
      elevation: 20,
      builder: (context) {
        return ChefProfileEditView();
      },
    );
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final deviceSize = MediaQuery.of(context).size;
    final _custData = Provider.of<List<CustData>>(context);
    DialogService _dialogService = locator<DialogService>();
    // final _chefData = Provider.of<ChefData>(context);
    // print("----> _chefData inside ChefSliverAppBar : " + chefData.toString());
    print("chefPic in SliverAppBar: " +
        chefData.chefPic.toString() +
        " Name: " +
        chefData.chefName.toString() +
        " Phone: " +
        chefData.chefPhNo.toString());
    animationVal = 10.0 - max(10.0, shrinkOffset * 10) / maxExtent;
    return ResponsiveSafeArea(
      builder: (context, widgetSize) => Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
// ---------------------------------------------------- B A C K G R O U N D    B L U R Y    I M A G E    C O V E R

            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(widgetSize.height * 0.2),
                bottomRight: Radius.circular(widgetSize.height * 0.2),
              ),
              child: Container(
                height: widgetSize.height * 0.94,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    //image: AssetImage(chefBGImage_1),
                    image: chefData.chefPic != null
                        ? chefData.chefPic != ""
                            ? NetworkImage(chefData.chefPic)
                            : AssetImage(defaultUserImg)
                        : AssetImage(defaultUserImg),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ),
// ---------------------------------------------------- H E A D E R   T E X T

// ---------------------------------------------------- C H E F   I N F O

            Column(
              children: <Widget>[
                //
                // >>>>>>>>> C H E F   P R O F I L E   P I C
                //
                Container(
                  margin: EdgeInsets.only(
                    top: widgetSize.height * 0.27,
                    // left: animationVal < 9.5
                    //     ? (animationVal > 6.2
                    //         ? animationVal * widgetSize.width * 0.8 / 30
                    //         : 85.8)
                    //     : 1
                  ),
                  //   alignment: animationVal > 9.5 ? Alignment.center : null,
                  alignment: Alignment.center,

                  // child: ClipOval(
                  //   child: Image.asset(
                  //     "assets/images/chef2.JPG",
                  // height: animationVal > 7.2
                  //     ? widgetSize.height * 0.08 * animationVal / 2
                  //     : widgetSize.height * 0.08 * 7.2 / 2,
                  // width: animationVal > 7.2
                  //     ? widgetSize.height * 0.08 * animationVal / 2
                  //     : widgetSize.height * 0.08 * 7.2 / 2,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  child: Container(
                    height: animationVal > 7.2
                        ? widgetSize.height * 0.08 * animationVal / 2
                        : widgetSize.height * 0.08 * 7.2 / 2,
                    width: animationVal > 7.2
                        ? widgetSize.height * 0.08 * animationVal / 2
                        : widgetSize.height * 0.08 * 7.2 / 2,
                    decoration: BoxDecoration(
                      //color: Colors.yellow,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        //    image: AssetImage(custBGImage_1),
                        image: chefData.chefPic != null
                            ? chefData.chefPic != ""
                                ? NetworkImage(chefData.chefPic)
                                : AssetImage(defaultUserImg)
                            : AssetImage(defaultUserImg),
                        // image:  AssetImage(custBGImage_1),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                //
                // >>>>>>>>> C H E F   N A M E
                //
                Container(
                  margin: EdgeInsets.only(
                    top: widgetSize.height * 0.01,
                    // left: animationVal < 9.5 && animationVal > 6.2
                    //     ? animationVal * widgetSize.width / 30
                    //     : 1
                  ),
                  child: Text(
                    chefData.chefName == null ? "" : chefData.chefName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: animationVal > 7.2
                          ? widgetSize.height * 0.025 * sqrt(animationVal)
                          : widgetSize.height * 0.025 * sqrt(13.2),
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
                //
                // >>>>>>>>> C H E F   F O L L O W E R S
                //
                isfromchef
                    ? InkWell(
                        onTap: () {
                          Dialog errorDialog = Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0)), //this right here
                            child: Container(
                              height: deviceSize.height * 0.6,
                              width: deviceSize.width * 0.8,
                              padding: EdgeInsets.only(top: 20.0),
                              child: ListView.builder(
                                  itemCount: chefData.chefFollowers.length,
                                  // ignore: missing_return
                                  itemBuilder: (context, index) {
                                    String id =
                                        chefData.chefFollowers.elementAt(index);
                                    print(
                                        '---------------------> cust id in follower ' +
                                            id);
                                    // DBHelperFtns().documentIDToName(
                                    //     custCollection,
                                    //     'custID',
                                    //     'custName',
                                    //     id);
                                    CustData _currentcust;
                                    for (int i = 0; i < _custData.length; i++) {
                                      _currentcust = _custData.elementAt(i);
                                      print(
                                          '---------------------> cust id in cust table ' +
                                              _currentcust.custId);

                                      if (_currentcust.custId == id) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 5.0),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(30.0)),
                                          child: Row(
                                            children: <Widget>[
                                              Material(
                                                child: _currentcust.custPic !=
                                                        ''
                                                    ? CachedNetworkImage(
                                                        placeholder:
                                                            (context, url) =>
                                                                Container(
                                                          child:
                                                              CircularProgressIndicator(
                                                            strokeWidth: 1.0,
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    themeColor),
                                                          ),
                                                          width: 50.0,
                                                          height: 50.0,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  15.0),
                                                        ),
                                                        imageUrl: _currentcust
                                                            .custPic,
                                                        width: 50.0,
                                                        height: 50.0,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Icon(
                                                        Icons.account_circle,
                                                        size: 50.0,
                                                        color: greyColor,
                                                      ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25.0)),
                                                clipBehavior: Clip.hardEdge,
                                              ),
                                              Flexible(
                                                child: Container(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(
                                                          '${_currentcust.custName}',
                                                          style: TextStyle(
                                                              color:
                                                                  primaryColor),
                                                        ),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                10.0,
                                                                0.0,
                                                                0.0,
                                                                5.0),
                                                      ),
                                                      // Container(
                                                      //   child: Text(
                                                      //     'About me: ${document.data()['aboutMe'] ?? 'Not available'}',
                                                      //     style: TextStyle(color: primaryColor),
                                                      //   ),
                                                      //   alignment: Alignment.centerLeft,
                                                      //   margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                                                      // )
                                                    ],
                                                  ),
                                                  margin: EdgeInsets.only(
                                                      left: 20.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {}
                                    }

                                    // return StreamBuilder(
                                    //     stream: FirebaseFirestore.instance
                                    //         .collection('customer')
                                    //         .doc(chefData.chefFollowers
                                    //             .elementAt(index))
                                    //         .snapshots(),
                                    //     builder: (context, snapshot) {
                                    //       return Text(
                                    //           snapshot.data()['custName']);
                                    //     });
                                  }),
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: <Widget>[
                              //     Padding(
                              //       padding: EdgeInsets.all(15.0),
                              //       child: Text(
                              //         'Cool',
                              //         style: TextStyle(color: Colors.red),
                              //       ),
                              //     ),
                              //     Padding(
                              //       padding: EdgeInsets.all(15.0),
                              //       child: Text(
                              //         'Awesome',
                              //         style: TextStyle(color: Colors.red),
                              //       ),
                              //     ),
                              //     Padding(padding: EdgeInsets.only(top: 50.0)),
                              //     FlatButton(
                              //         onPressed: () {
                              //           Navigator.of(context).pop();
                              //         },
                              //         child: Text(
                              //           'Got It!',
                              //           style: TextStyle(
                              //               color: Colors.purple,
                              //               fontSize: 18.0),
                              //         ))
                              //   ],
                              // ),
                            ),
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => errorDialog);
                        },
                        child: Text(
                          "" +
                              chefData.chefFollowers.length.toString() +
                              " Followers",
                          style: TextStyle(
                            color: Color(0xffAAB825),
                            fontSize: animationVal > 7.2
                                ? widgetSize.height * 0.018 * sqrt(animationVal)
                                : widgetSize.height * 0.018 * sqrt(13.2),
                            fontFamily: "Uni-Sans",
                          ),
                        ),
                      )
                    : Text(
                        "" +
                            chefData.chefFollowers.length.toString() +
                            " Followers",
                        style: TextStyle(
                          color: Color(0xffAAB825),
                          fontSize: animationVal > 7.2
                              ? widgetSize.height * 0.018 * sqrt(animationVal)
                              : widgetSize.height * 0.018 * sqrt(13.2),
                          fontFamily: "Uni-Sans",
                        ),
                      ),
              ],
            ),
// ---------------------------------------------------- E D I T   A N D   C H A T
            Container(
              margin: EdgeInsets.only(
                  top: widgetSize.height * 0.84, left: widgetSize.width * 0.06),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  isfromchef
                      ? FlatButton(
                          //   onPressed: () => _showEditBottomSheet(),
                          onPressed: () => _showEditBottomSheet(context),
                          child: StandardBtnWhitishRound(
                              passedText: "Edit Profile"))
                      : FlatButton(
                          onPressed: () {
                            List followerlist = chefData.chefFollowers;
                            if (!followerlist
                                .contains(BaseViewModel().getUser)) {
                              followerlist.add(BaseViewModel().getUser);
                            } else {
                              followerlist.remove(BaseViewModel().getUser);
                            }

                            // BaseViewModel().getUser();
                            DatabaseService().updateChefData(
                                {'followers': followerlist}, chefData.chefID);
                          },
                          child: !chefData.chefFollowers
                                  .contains(BaseViewModel().getUser)
                              ? StandardBtnWhitishRound(
                                  passedText: 'Follow',
                                )
                              : StandardBtnWhitishRound(
                                  passedText: 'un Follow',
                                ),
                        ),
                  Spacer(),
                  //
                  // >>>>>>>>> M E S S A G E   I C O N
                  //
                  FlatButton(
                    onPressed: () {
                      isfromchef
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatHomeChef(
                                  currentUserId: BaseViewModel().getUser,
                                ),
                              ),
                            )
                          : BaseViewModel().getUser != null
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Chat(
                                            peerId: chefData.chefID,
                                            peerAvatar: chefData.chefPic,
                                            peername: chefData.chefName,
                                          )))
                              : _dialogService.showDialog(
                                  title: 'Alert',
                                  description: "Please Sign in to Continue ",
                                  buttonTitle: "ok ",
                                  dialogType: Dialog_Types.PLAN_SUCCESS);
                      ;
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: widgetSize.width * 0.06),
                        height: deviceSize.height * 0.18,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0.00, 4.00),
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Icon(
                          FlevaIcons.message_circle,
                          color: Colors.tealAccent,
                          size: widgetSize.height * 0.16,
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
