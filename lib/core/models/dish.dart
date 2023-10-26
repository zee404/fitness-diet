import 'package:cloud_firestore/cloud_firestore.dart';

class Dish {
  String dishID;
  String dishName;
  double dishRatings;
  String dishPic;
  bool dishAval;
  int dishPrepTime;
  int dishPrice;
  double dishCarb;
  double dishProtein;
  double dishKcal;
  double dishFat;
  var dishAddDate;
  var dishUpdateDate;
  String dishCatg;
  List<dynamic> dishIngrNames;
  String chefName; // Jugar
  String chefID; // - Foreign Key
  String attrID; // - Foreign Key
  String ctgID; // - Foreign Key

  Dish({
    this.dishID,
    this.dishName,
    this.dishPrice,
    this.dishRatings,
    this.dishPic,
    this.dishAval,
    this.dishPrepTime,
    this.dishKcal,
    this.dishFat,
    this.dishCarb,
    this.dishProtein,
    this.dishAddDate,
    this.dishUpdateDate,
    this.chefName,
    this.chefID,
    this.attrID,
    this.ctgID,
    this.dishIngrNames,
    this.dishCatg,
  });
}

class Attribute {
  String attrID;
  String attrName;
  Timestamp attrAddDate;

  Attribute({
    this.attrID,
    this.attrName,
    this.attrAddDate,
  });
}

class DishCategory {
  String ctgID;
  String ctgName;
  Timestamp ctgAddDate;

  DishCategory({
    this.ctgID,
    this.ctgName,
    this.ctgAddDate,
  });
}
