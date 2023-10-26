import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/soleDishViewModel.dart';
import 'package:fitness_diet/ui/shared/colors.dart';
import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefFurtherInfo/chefDish/addDish/editDishInfoView.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefProfileMain.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/chefview.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadinNoBgSmall.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingNoBgUniSan.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardText1.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardText2.dart';
import 'package:fitness_diet/ui/widgets/briefChefInfo.dart';
import 'package:fitness_diet/ui/widgets/circularIcon.dart';
import 'package:fitness_diet/ui/widgets/dishNutriValues.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ChefSoleDishView extends StatelessWidget {
  Dish passedDish;
  bool isFromCustView = false;
  ChefSoleDishView({@required this.passedDish, @required this.isFromCustView});
  // ChefData _chefData;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final _allChefsData = Provider.of<List<ChefData>>(context);

    return BaseView<SoleDishViewModel>(
      onModelReady: (model) async {},
      builder: (context, model, child) => Scaffold(
        backgroundColor: colorContentBg,
        body: model.state == ViewState.Busy
            ? Loading()
            : Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        // ----------------------------------- B A C K G R O U N D    I M A G E
                        Container(
                          margin: EdgeInsets.only(bottom: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(150),
                              bottomRight: Radius.circular(150),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(2.00, 3.00),
                                color: Colors.black45,
                                blurRadius: 5,
                              ),
                            ],
                            image: DecorationImage(
                              image: NetworkImage(passedDish.dishPic),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // ----------------------------------- A P P   B A R   I C O N S
                        Container(
                          margin: EdgeInsets.only(top: 50, left: 30, right: 30),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: CircularIcon(
                                  passedIcon: FontAwesomeIcons.chevronLeft,
                                  passedColor: Colors.black87,
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                child: CircularIcon(
                                  passedIcon: FontAwesomeIcons.shareAlt,
                                  passedColor: Colors.black87,
                                ),
                              ),
                              SizedBox(width: 5),
                              InkWell(
                                child: CircularIcon(
                                  passedIcon: FontAwesomeIcons.solidHeart,
                                  passedColor: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ----------------------------------- D I S H   H E A D I N G
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 120,
                            width: deviceSize.width,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            padding:
                                EdgeInsets.only(left: 25, top: 20, right: 25),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(2.00, 3.00),
                                  color: Colors.black45,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  passedDish.dishName.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: fontMontserratBold,
                                  ),
                                ),
                                Text(
                                  "Avalaible for order now",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: fontUniSans,
                                  ),
                                ),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: passedDish.dishRatings,
                                      itemCount: 5,
                                      itemSize: deviceSize.height * 0.015,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      passedDish.dishRatings.toString(),
                                      style: TextStyle(
                                        fontSize: deviceSize.height * 0.015,
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "Rs " + passedDish.dishPrice.toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: fontLemonMilk,
                                      color: Colors.brown,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // -------------------------------------- E D I T   D E L E T E
                  Expanded(
                    flex: 5,
                    child: Stack(
                      children: [
                        ListView(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 30),
                                Icon(
                                  Icons.edit,
                                  color: Colors.brown,
                                  size: 20,
                                ),
                                InkWell(
                                    onTap: () {
                                      print("Tapped");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditDishInfo(
                                            passedDish: passedDish,
                                          ),
                                        ),
                                      );
                                    },
                                    child: StandardText1(
                                        passedDescText: "  Edit Dish ")),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    model.deleteDish(passedDish.dishID);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChefProfileMain(),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.brown,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: 30),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(
                              thickness: 2,
                              endIndent: 30,
                              indent: 30,
                            ),
                            SizedBox(height: 10),
                            // ----------------------------------- N U T R I T I O N A L   V A L U E
                            DishNutriValues(passedDish: passedDish),
                            SizedBox(height: 10),
                            Divider(
                              thickness: 2,
                              endIndent: 30,
                              indent: 30,
                            ),
                            // ----------------------------------- Ingredients
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: StandardHeadingNoBgUniSans(
                                  passedText: "Ingredients:"),
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: passedDish.dishIngrNames.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return StandardText2(
                                      passedDescText: passedDish
                                          .dishIngrNames[index]
                                          .toString(),
                                      fontWeight: FontWeight.normal,
                                    );
                                  }),
                            ),
                            // ----------------------------------- C H E F   I N F O   V A L U E
                            isFromCustView
                                ? Container(
                                    margin: EdgeInsets.only(left: 35),
                                    child: StandardHeadingNoBgSmall(
                                      passedText: "Prepeared by:",
                                    ),
                                  )
                                : Container(),
                            SizedBox(height: 15),
                            isFromCustView
                                ? FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChefView(
                                            chefID: passedDish.chefID,
                                          ),
                                        ),
                                      );
                                    },
                                    child: BriefChefInfo(
                                        passedChefData: model.extractedChefData(
                                            _allChefsData, passedDish.chefID)),
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
