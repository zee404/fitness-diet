import 'dart:io';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/viewmodels/chefProfileViewModels/chefDishViewModels/addDishViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefFurtherInfo/chefDish/addDish/addDishIngrView.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeaderWithWhiteBG.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingNoBgUniSan.dart';
import 'package:fitness_diet/ui/widgets/TextFeilds/textFeildBigWhiteBG.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddDishInfo extends StatefulWidget {
  @override
  _AddDishInfoState createState() => _AddDishInfoState();
}

class _AddDishInfoState extends State<AddDishInfo> {
  String dishCatg;
  int _prepTimeHrs, _prepTimeMin, totalPrepTime;
  File dishPic;
  TextEditingController dishNameContr = TextEditingController();
  TextEditingController priceContr = TextEditingController();
  TextEditingController attrContr = TextEditingController();

  String uploadedFileURL;
  String dropdownInititalValue = 'Select Category';
  Size deviceSize;
  bool isNextPressed = false;
  int pageIndex;
  List screenList;

// For extracting ctg and attrib listnames
  List<DishCategory> _dishCatgList;
  List<String> ctgNamesList = List<String>();
  List<Attribute> _dishAttrList;
  List<String> attrNamesList = List<String>();

  @override
  Widget build(BuildContext context) {
    // getCountries();

    deviceSize = MediaQuery.of(context).size;
    _dishCatgList = Provider.of<List<DishCategory>>(context);
    _dishAttrList = Provider.of<List<Attribute>>(context);
    // print("_foodNutrient : " + _foodNutrient.toString());
    print(">>>>>>>>>>> Dish Category list : " + _dishCatgList.toString());
// ====================================================================================
// --- The below workaround is to extract feild values from the provider list
// --- ('If' resist feild list to rebuild on build)
// * For DishCategoryList

    if (_dishCatgList != null && ctgNamesList.length == 0) {
      for (int i = 0; i < _dishCatgList.length; i++) {
        print("_dishCatgList[i].ctgName " + _dishCatgList[i].ctgName);
        ctgNamesList.add(_dishCatgList[i].ctgName);
      }
      ctgNamesList.insert(0, 'Select Category');
    }

//    if (ctgNamesList != null && ctgNamesList.length < _dishCatgList.length) {}

    print("``````````````````` _dishAttrList: " + _dishAttrList.toString());
// * For DishAttributeList
    if (_dishAttrList != null && attrNamesList.length == 0) {
      for (int i = 0; i < _dishAttrList.length; i++) {
        print("_dishAttrList[i].ctgName " + _dishAttrList[i].attrName);
        attrNamesList.add(_dishAttrList[i].attrName);
      }
      //  attrNamesList.insert(0, 'Select Attribute');
    }
    print("``````````````````` ctgNamesList: " + ctgNamesList.toString());

// =====================================================================================
    screenList = [
      screen1View(deviceSize),
      AddDishIngrView.withDishInfo(
        dishPic: dishPic,
        dishNameContr: dishNameContr,
        priceContr: priceContr,
        totalPrepTime: totalPrepTime,
        dishCatg: dishCatg,
        attrContr: attrContr,
      )
    ];
    return BaseView<AddDishViewModel>(
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, widgetSize) {
          return Material(
            child: Stack(
              children: <Widget>[
                //
                // >>>>>>>>>>>> Add Dish Image  <<<<<<<<<<<<<<<
                //
                Container(
                  height: widgetSize.height * 0.37,
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text("Pick from Gallery"),
                                  onTap: () async {
                                    File dishPicTemp = await ConstantFtns()
                                        .getImgFile(
                                            ImageSource.gallery, deviceSize);
                                    print(
                                        "------- dishPicTemp inside AddDishVIew:" +
                                            dishPicTemp.toString());
                                    setState(() {
                                      dishPic = dishPicTemp;
                                      print("------- dishPic AddDishVIew:" +
                                          dishPicTemp.toString());
                                    });
                                  },
                                ),
                                ListTile(
                                  title: Text("Take a Picture"),
                                  onTap: () async {
                                    File dishPicTemp = await ConstantFtns()
                                        .getImgFile(
                                            ImageSource.camera, deviceSize);

                                    setState(() {
                                      dishPic = dishPicTemp;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      // ---- Setting dish pic if not null
                      child: Stack(
                        children: <Widget>[
                          dishPic != null
                              ? Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(File(dishPic.path)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: widgetSize.width * 0.33,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white38,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(widgetSize.width * 0.2),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Add Image ",
                                    style: TextStyle(
                                        fontSize: widgetSize.height * 0.02),
                                  ),
                                  Icon(
                                    Icons.add_a_photo,
                                    size: widgetSize.height * 0.028,
                                    color: Colors.black87,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //
                // >>>>>>>>>>>> A D D   N E W   D I S H   H E A D E R <<<<<<<<<<<<<<<
                //
                StandardHeaderWithWhiteBG(passedText: "Add new dish"),
                // --------------------------------------- A D D   D I S H   I N F O   C O L U M N
                Container(
                  margin: EdgeInsets.only(top: widgetSize.height * 0.28),

                  //   height: widgetSize.height * 0.8,
                  width: widgetSize.width,
                  decoration: BoxDecoration(
                    color: Color(0xffe4d7cb),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(widgetSize.width * 0.18),
                    ),
                  ),
                  child: Swiper(
                    loop: false,
                    pagination: SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: deviceSize.height * 0.1),
                      builder: RectSwiperPaginationBuilder(
                        color: Colors.grey,
                        activeColor: Colors.black,
                        activeSize: Size(50, 10),
                        size: Size(40, 8),
                      ),
                    ),
                    itemCount: 2,
                    onIndexChanged: (int _pgInd) =>
                        setState(() => pageIndex = _pgInd),
                    itemBuilder: (context, index) {
                      return screenList[index];
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
// ==================================================================================

  Widget showDropDown() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(deviceSize.height * 0.15)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
        height: deviceSize.height * 0.04,
        width: deviceSize.width * 0.9,
        color: Colors.white.withOpacity(0.7),
        child: Center(
          child: DropdownButton<String>(
            value: dropdownInititalValue,
            // icon: Icon(Icons.arrow_downward),
            //iconSize: 24,
            elevation: 16,
            style: TextStyle(
                color: Colors.brown.withOpacity(0.8),
                fontSize: deviceSize.height * 0.02),

            underline: Container(height: 0),
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                newValue != "Select Category"
                    ? dishCatg = newValue
                    : dishCatg = null;
                dropdownInititalValue = newValue;
              });
            },

            items: ctgNamesList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

// ==================================================================================
  void hoursButtomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: deviceSize.height / 3,
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 1,
            secondInterval: 1,
            //    initialTimerDuration: initialtimer,
            onTimerDurationChanged: (Duration changedtimer) {
              setState(
                () {
                  _prepTimeHrs = changedtimer.inHours;
                  totalPrepTime = changedtimer.inMinutes;
                  _prepTimeMin = changedtimer.inMinutes - _prepTimeHrs * 60;
                },
              );
            },
          ),
        );
      },
    );
  }
// ==================================================================================

  Widget screen2View(Size deviceSize) {
    return Container(
      padding: EdgeInsets.only(
        left: deviceSize.width * 0.04,
        top: deviceSize.height * 0.04,
        right: deviceSize.height * 0.04,
        bottom: deviceSize.height * 0.07,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StandardHeadingNoBgUniSans(passedText: "Ingredients:"),
            // SearchableDropdown.multiple(items: null, onChanged: null)
            // showDropDown(),
            //     SingleChildScrollView(child: children,)
          ],
        ),
      ),
    );
  }
// ==================================================================================

  Widget screen1View(Size deviceSize) {
    return Container(
      padding: EdgeInsets.only(
        left: deviceSize.width * 0.04,
        top: deviceSize.height * 0.04,
        right: deviceSize.height * 0.04,
        bottom: deviceSize.height * 0.07,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //
            // >>>>>>>>>>>> D I S H   N A M E <<<<<<<<<<<<<<<
            //

            StandardHeadingNoBgUniSans(passedText: "Dish name: "),

            TextFeildBigWhiteBG(
                controller: dishNameContr,
                deviceSize: deviceSize,
                isTypeInt: false,
                hintText: '',
                isObscureText: false),
            SizedBox(
              height: deviceSize.height * 0.03,
            ),
            //
            // >>>>>>>>>>>> P R I C E <<<<<<<<<<<<<<<
            //
            Row(
              children: <Widget>[
                StandardHeadingNoBgUniSans(passedText: "Price: "),
                Text(
                  "(Rs)",
                  style: TextStyle(
                    fontFamily: "Uni-Sans",
                    fontSize: deviceSize.height * 0.019,
                    color: Color(0xff2a6427).withOpacity(0.7),
                  ),
                )
              ],
            ),
            TextFeildBigWhiteBG(
                controller: priceContr,
                deviceSize: deviceSize,
                isTypeInt: true,
                hintText: '',
                isObscureText: false),
            SizedBox(
              height: deviceSize.height * 0.03,
            ),
            //
            // >>>>>>>>>>>> P E R P   T I M E <<<<<<<<<<<<<<<
            //
            StandardHeadingNoBgUniSans(passedText: "Preperation time:"),

            Container(
              alignment: Alignment.center,
              child: Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // >>>>>>>>>>>> Hours
                  InkResponse(
                    onTap: () => hoursButtomSheet(context),
                    child: Container(
                      height: deviceSize.height * 0.045,
                      width: deviceSize.height * 0.063,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _prepTimeHrs == null ? "HH" : _prepTimeHrs.toString(),
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: deviceSize.height * 0.024,
                            color: Color(0xff4d3814).withOpacity(0.36),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    " : ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: deviceSize.height * 0.04),
                  ),
                  // >>>>>>>>>>>> Minutes
                  InkResponse(
                    onTap: () => hoursButtomSheet(context),
                    child: Container(
                      height: deviceSize.height * 0.045,
                      width: deviceSize.height * 0.063,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _prepTimeMin == null ? "MM" : _prepTimeMin.toString(),
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: deviceSize.height * 0.024,
                            color: Color(0xff4d3814).withOpacity(0.36),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: deviceSize.height * 0.03,
            ),
            //
            // >>>>>>>>>>>> C A T E G O R Y <<<<<<<<<<<<<<<
            //
            StandardHeadingNoBgUniSans(passedText: "Category: "),
            showDropDown(),
            SizedBox(
              height: deviceSize.height * 0.03,
            ),
            //
            // >>>>>>>>>>>> A T T R I B U T E S <<<<<<<<<<<<<<<
            //
            Row(
              children: <Widget>[
                StandardHeadingNoBgUniSans(passedText: "Attributes: "),
                Flexible(
                  child: Text(
                    " (Any special offer or discount)",
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontFamily: "Uni-Sans",
                      fontSize: deviceSize.height * 0.013,
                      color: Color(0xff2a6427).withOpacity(0.7),
                    ),
                  ),
                )
              ],
            ),

            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(deviceSize.height * 0.15),
              ),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
                height: deviceSize.height * 0.07,
                width: deviceSize.width * 0.9,
                color: Colors.white.withOpacity(0.5),
                alignment: Alignment.topCenter,
                // color: Colors.red,
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFeildBigWhiteBG(
                              controller: attrContr,
                              deviceSize: deviceSize,
                              isTypeInt: false,
                              hintText: "",
                              isObscureText: false),
                        ),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          onSelected: (String value) {
                            attrContr.text = value;
                            print("attrContr [[[[[[[[[[[[[[[[[[[[[[[[[[[[[ " +
                                attrContr.text);
                          },
                          itemBuilder: (BuildContext context) {
                            return attrNamesList
                                .map<PopupMenuItem<String>>((String value) {
                              return PopupMenuItem(
                                  child: Text(value), value: value);
                            }).toList();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: deviceSize.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
