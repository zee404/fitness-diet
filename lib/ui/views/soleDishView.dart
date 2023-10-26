import 'package:fitness_diet/core/enums/dialogTypes.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/cart.dart';
import 'package:fitness_diet/core/models/disease.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/dialogService.dart';
import 'package:fitness_diet/core/viewmodels/soleDishViewModel.dart';
import 'package:fitness_diet/locator.dart';
import 'package:fitness_diet/ui/shared/colors.dart';
import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:fitness_diet/ui/shared/imagesURLs.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefFurtherInfo/chefDish/addDish/editDishInfoView.dart';
import 'package:fitness_diet/ui/views/custViews/cartView.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/chefview.dart';
import 'package:fitness_diet/ui/widgets/Buttons/bigLightGreenBtn.dart';
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
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SoleDishView extends StatelessWidget {
  Dish passedDish;
  bool isFromCustView = false;
  SoleDishView({@required this.passedDish, @required this.isFromCustView});
  // ChefData _chefData;

  @override
  Widget build(BuildContext context) {
    print(" Inside soleDishView B U I L D");
    final deviceSize = MediaQuery.of(context).size;
    final _allChefsData = Provider.of<List<ChefData>>(context);
    final _dishData = Provider.of<List<Dish>>(context);
    final _plansData = Provider.of<Plan>(context);
    final _diseasesData = Provider.of<List<Disease>>(context);
    final _cart = Provider.of<Cart>(context);
    final _custData = Provider.of<CustData>(context);
    print(" Inside soleDishView  B U I L D  after");
    DialogService _dialogService = locator<DialogService>();

    List<dynamic> _diseaseInfoNestedList = [];
    return BaseView<SoleDishViewModel>(
      onModelReady: (model) {
        print(" Inside soleDishView onModelReady");
        // Checking if the customer have disease and if disease's notrecommended ingredients are in a dish
        if (_custData != null) {
          if (_plansData != null) {
            _diseaseInfoNestedList.add(model.getDiseaseInfoNestedList(
              _plansData,
              _diseasesData,
              passedDish,
            ));
          }
        }
      },
      builder: (context, model, child) => WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          Navigator.pop(context);
        },
        child: Scaffold(
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
                            margin:
                                EdgeInsets.only(top: 50, left: 30, right: 30),
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
                                      Text(
                                        "(" +
                                            passedDish.dishRatings.toString() +
                                            ")",
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
                    Expanded(
                      flex: 5,
                      child: Stack(
                        children: [
                          ListView(
                            children: [
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

                              _diseaseInfoNestedList.length != 0 &&
                                      !_diseaseInfoNestedList[0][0]
                                  ? Container(
                                      height: deviceSize.height * 0.1,
                                      width: double.infinity,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Lottie.asset(
                                              animWarning3,
                                              repeat: true,
                                              reverse: false,
                                              animate: true,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              "It is NOT healthy for you because it contains " +
                                                  _diseaseInfoNestedList[0][1]
                                                      .toString() +
                                                  " which is unsafe for your health considering your issues with " +
                                                  _diseaseInfoNestedList[0][2]
                                                      .toString(),
                                              // overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: fontUniSans,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),

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
                                          passedChefData:
                                              model.extractedChefData(
                                                  _allChefsData,
                                                  passedDish.chefID)),
                                    )
                                  : Container(),
                              SizedBox(height: 20),
                              // ----------------------------------- Ingredients
                              Container(
                                margin: EdgeInsets.only(left: 35),
                                child: StandardHeadingNoBgSmall(
                                  passedText: "Ingredients:",
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                margin: EdgeInsets.only(left: 35),
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
                              SizedBox(height: 50),
                            ],
                          ),
                          // ----------------------------------- A D D   T O   C A R T   B U T T O N

                          isFromCustView
                              ? Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: deviceSize.height * 0.05,
                                    // margin: EdgeInsets.all(15),
                                    color: Colors.white,
                                    child: FlatButton(
                                      onPressed: () async {
                                        if (model.getUser == null) {
                                          _dialogService.showDialog(
                                              title: 'Alert',
                                              description:
                                                  "Please Sign in to Continue ",
                                              buttonTitle: "ok ",
                                              dialogType:
                                                  Dialog_Types.PLAN_SUCCESS);
                                        } else {
                                          print(
                                              '--------------------inside add to cart function in soleDish view ');

                                          if (model.getServings(_cart.items,
                                                  passedDish.dishID) ==
                                              0) {
                                            bool added = model.additem(
                                              passedDish,
                                              _custData,
                                              _cart,
                                              _dishData,
                                            );

                                            if (!added) {
                                              var dialogResult =
                                                  await _dialogService.showDialog(
                                                      title: 'Alert',
                                                      description:
                                                          "your Previous Cart Will be Cleared If you procced With this cheff ",
                                                      buttonTitle: "ok ",
                                                      dialogType: Dialog_Types
                                                          .New_Order);
                                              if (dialogResult.confirmed) {
                                                model.removeCartItems(
                                                    _cart.cartid, _cart.items);

                                                print(
                                                    '--------------------------------added ' +
                                                        added.toString());
                                              }
                                            }
                                          } else {
                                            print('nevigate to View Cart ');
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CartView(),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: BigLightGreenBtn(
                                        passedText: model.getServings(
                                                    _cart.items,
                                                    passedDish.dishID) ==
                                                0
                                            ? "Add to cart"
                                            : 'View Your Cart' +
                                                ' (' +
                                                _cart.items.length.toString() +
                                                ') ',
                                        isDisabled: false,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
