
import 'package:fitness_diet/core/viewmodels/custViewModels/custAppDrawerViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/imagesURLs.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/Buttons/authBtnStyle.dart';
import 'package:fitness_diet/ui/widgets/navBarContent.dart';
import 'package:fitness_diet/ui/widgets/subNavContent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GuestAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BaseView<CustAppDrawerViewModel>(
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, widgetSize) => Container(
          width: widgetSize.width * 0.65,
          // margin: EdgeInsets.only(left: widgetSize.width * 0.03),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(custDrawerCoverImage),
              colorFilter: new ColorFilter.mode(
                Colors.white.withOpacity(0.8),
                BlendMode.srcOver,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
// ---------------------------------------------------- H E A D E R
              DrawerHeader(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  color: Colors.brown.withOpacity(0.9),
                  padding: EdgeInsets.only(left: deviceSize.width * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Eat healthy, Stay healthy",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: widgetSize.height * 0.018,
                          fontFamily: "BAHN SCHRIFT",
                        ),
                      ),
                      Text(
                        "Fitness Diet",
                        style: TextStyle(
                          color: Color(0xffD6D625),
                          fontSize: widgetSize.height * 0.045,
                          fontFamily: "BAHNSCHRIFT",
                        ),
                      ),
                    ],
                  ),
                ),
                // decoration: new BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage("assets/images/navCover4.jpg"),
                //     fit: BoxFit.cover,
                //   ),
                // ),
              ),
// ---------------------------------------------------- O P T I O N S
              // SizedBox(
              //   height: deviceSize.height * 0.02,
              // ),
              // InkWell(
              //   onTap: null,
              //   child: NavBarContent(
              //     deviceSize: deviceSize,
              //     passedText: "Home",
              //     passedIcon: Icons.home,
              //   ),
              // ),
              // Divider(
              //   thickness: 2,
              //   color: Colors.black12,
              // ),
              // InkWell(
              //   onTap: () =>
              //       //  Navigator.pushReplacement(
              //       //   context,
              //       //   MaterialPageRoute(builder: (context) => CustProfileMain()),
              //       // ),
              //       model.goToProfile(),
              //   child: NavBarContent(
              //     deviceSize: deviceSize,
              //     passedText: "Profile",
              //     passedIcon: Icons.person,
              //   ),
              // ),
              // Divider(
              //   thickness: 2,
              //   color: Colors.black12,
              // ),
              // InkWell(
              //   onTap: null,
              //   child: NavBarContent(
              //     deviceSize: deviceSize,
              //     passedText: "Favourites",
              //     passedIcon: Icons.favorite,
              //   ),
              // ),

              FlatButton(
                onPressed: () => {
                  model.signOut(),
                },
                child: AuthBtnStyle(
                    deviceSize: deviceSize, passedText: "Sign In"),
              ),
              Divider(
                thickness: 2,
                color: Colors.black12,
              ),
              // ---------------------------------------------------- O T H E R S
              Center(
                child: Text(
                  "OTHERS",
                  style: TextStyle(
                      color: Colors.brown,
                      fontFamily: 'Uni-Sans',
                      fontSize: widgetSize.height * 0.023),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              //
              // >>>>>>>>> I N V I T E  F R I E N D S
              //
              SubNavBarContent(
                deviceSize: deviceSize,
                passedIcon: Icons.share,
                passedText: "Invite friends",
              ),
              //
              // >>>>>>>>> R A T E   A P P
              //
              SubNavBarContent(
                deviceSize: deviceSize,
                passedIcon: Icons.stars,
                passedText: "Rate App",
              ),
              //
              // >>>>>>>>> F E E D B A C K
              //
              SubNavBarContent(
                deviceSize: deviceSize,
                passedIcon: Icons.phone,
                passedText: "Content Us",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
