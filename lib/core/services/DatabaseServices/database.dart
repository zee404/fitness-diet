import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_diet/core/models/cart.dart';
import 'package:fitness_diet/core/models/disease.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/exercise.dart';
import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/dbHelperFtns.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';

class DatabaseService {
  // collection reference is just reference for certain collection

  final CollectionReference chefCollection =
      FirebaseFirestore.instance.collection('chef');
  final CollectionReference dishCollection =
      FirebaseFirestore.instance.collection('dish');
  final CollectionReference dishCtgCollection =
      FirebaseFirestore.instance.collection('dishCategory');
  final CollectionReference dishAttrCollection =
      FirebaseFirestore.instance.collection('attribute');
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('cart');
  final CollectionReference custCollection =
      FirebaseFirestore.instance.collection('customer');
  final CollectionReference planCollection =
      FirebaseFirestore.instance.collection('plan');
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('order');
  final CollectionReference exerciseCollection =
      FirebaseFirestore.instance.collection('exercise');
  final CollectionReference delivCollection =
      FirebaseFirestore.instance.collection('delivery');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference messageCollection =
      FirebaseFirestore.instance.collection('messages');
  final CollectionReference diseasesCollection =
      FirebaseFirestore.instance.collection('diseases');

  final String uid;
  DatabaseService({this.uid});
// ============================================================================================================
// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   C U S T O M E R   D A T A
// ============================================================================================================
  //
  // >>>>>>>>>>>>>>>> S E T T I N G   D A T A
  //
  Future<bool> addNewCustData(Map<String, dynamic> dataMap) async {
    print("---------> DataBase services class reached. Updating user for uid" +
        uid.toString());
    // - Setting ID first in a doc

    Map<String, List<String>> address = {};
    await custCollection.doc(uid).set(
      {
        'custID': uid,
        'custAddDate': DateTime.now(),
        // 'custAddress': address,
      },
      SetOptions(merge: true),
    );

    // - Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        await custCollection.doc(uid).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );
    return true;
  }

  Future<bool> updateCustData(
      Map<String, dynamic> dataMap, String custID) async {
    print(
        "---------> DataBase services class reached. Updating user for uid : " +
            uid.toString());

    // - Setting ID first in a doc
    await custCollection.doc(custID).set(
      {
        'custUpdateDate': DateTime.now(),
      },
      SetOptions(merge: true),
    );

    // - Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        await custCollection.doc(custID).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );
    return true;
  }

  //-------------- address
  Future updateCustAddress(String custID, String title, String houseno,
      String street, String city) async {
    print('inside update address function  in  data base');
    await custCollection.doc(custID).set(
      {
        'custAddress': {
          title: [houseno, street, city]
        },
      },
      SetOptions(merge: true),
    );
  }

  // ignore: missing_return
  Future removeCustAddress(String custID, String title) {
    print('********** inside remove address in database :' + title.toString());
    custCollection.doc(custID).set(
      {
        'custAddress': {title: FieldValue.delete()}
      },
      SetOptions(merge: true),
    );
  }

  //
  // >>>>>>>>>>>>>>>> G E T T I N G   D A T A
  //
  CustData _custDataFromSnapshot(DocumentSnapshot snapshot) {
    print(
        " UiD DBfunction reached in cust data  fromsnapshot ******************** data " +
            uid);

    return CustData(
      custId: uid,
      custPhNo: snapshot.data()['custPhNo'] ?? "load",
      custName: snapshot.data()['custName'] ?? "load",
      custDateOfBirth:
          (snapshot.data()['custDateOfBirth'] as Timestamp).toDate() ?? "",
      // custfavs: snapshot.data()['custfavs'] ?? "",

      custaddress: snapshot.data()['custAddress'] ?? '',
      custContactNo: snapshot.data()['custContactNo'] ?? '',
      // custFollowing: snapshot.data()['custFollowing'] ?? "",
      planID: snapshot.data()['planID'] ?? "",
      custPic: snapshot.data()['custPic'] ?? "",
      cartID: snapshot.data()['cartID'] ?? "",
      // custOrders: snapshot.data()['custOrders'] ?? "",
    );
  }

  // Get user doc stream
  Stream<CustData> get getCustData {
    print(" UiD DB TEST function reached in getcust data******************** ");
    return custCollection.doc(uid).snapshots().map(_custDataFromSnapshot);
  }

  List<CustData> _allCustDataFromSnapshot(QuerySnapshot snapshot) {
    List<CustData> productsList = List<CustData>();
    for (int i = 0; i < snapshot.docs.length; i++) {
      productsList.add(CustData(
        custId: snapshot.docs[i].data()['custID'] ?? "",
        custPhNo: snapshot.docs[i].data()['custPhNo'] ?? "",
        custName: snapshot.docs[i].data()['custName'] ?? "",
        custDateOfBirth:
            (snapshot.docs[i].data()['custDateOfBirth'] as Timestamp)
                    .toDate() ??
                "",
        // custfavs: snapshot.docs[i].data()['custfavs'] ?? "",

        custaddress: snapshot.docs[i].data()['custAddress'] ?? '',
        custContactNo: snapshot.docs[i].data()['custContactNo'] ?? '',
        // custFollowing: snapshot.docs[i].data()['custFollowing'] ?? "",
        planID: snapshot.docs[i].data()['planID'] ?? "",
        custPic: snapshot.docs[i].data()['custPic'] ?? "",
        cartID: snapshot.docs[i].data()['cartID'] ?? "",
      ));
    }

    return productsList;
  }

// Get user doc stream
  Stream<List<CustData>> get getAllCustData =>
      custCollection.snapshots().map(_allCustDataFromSnapshot);

// ===========================================================================================================
// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   C H E F  D A T A
// ===========================================================================================================

  Future addNewChefData(Map<String, dynamic> dataMap) async {
    // });
    print("UID in Database class_+_+__+_+_+_++_+: " + uid.toString());

    // - Statically adding date in the db
    await chefCollection.doc(uid).set(
      {
        'chefID': uid,
        'chefAddDate': DateTime.now(),
        'chefRatings': 0.0,
        // 'followers': 0,
        'hasDish': false,
      },
      SetOptions(merge: true),
    );

    // - Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        await chefCollection.doc(uid).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );
  }

  Future updateChefData(Map<String, dynamic> dataMap, String chefID) async {
    // });
    print("UID in Database class_+_+__+_+_+_++_+: " + uid.toString());
    // - Statically adding date in the db

    // -------------- NOT A RELAIBLE SOLUTION, PLEASE CHANGE IN FUTURE ------------------------------------
    String _chefName = dataMap["chefName"];
    String _extracteddishID;
    await dishCollection.where("chefID", isEqualTo: chefID).get().then((data) {
      for (int i = 0; i < data.docs.length; i++) {
        _extracteddishID = data.docs[i].data()["dishID"].toString();
        updateDishData({"chefName": _chefName}, _extracteddishID);
      }
      // if (data.docs.length > 0) {
      //   _extracteddishID = data.docs[0].data()["dishID"].toString();
      // }
    });

    // ----------------- WORKAROUND ENDS HERE -----------------------------

    await chefCollection.doc(chefID).set(
      {
        'chefUpdateDate': DateTime.now(),
      },
      SetOptions(merge: true),
    );

    // - Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        await chefCollection.doc(chefID).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );
  }

//   // Cust data from snapshot (For retrival)
//   ChefData _chefDataFromSnapshot(docSnapshot snapshot) {
//     print("------> _chefDataFromSnapshot(docSnapshot snapshot) INVOKED");
//     return ChefData(
//       chefID: uid,
//       chefName: snapshot.data()['chefName'] ?? "",
//       chefPhNo: snapshot.data()['chefPhNo'] ?? "",
//       chefDateOfBirth:
//           (snapshot.data()['chefDateOfBirth'] as Timestamp).toDate() ?? "",
//       // //  chefAddDate: (snapshot.data()['chefAddDate'] as Timestamp).toDate() ??,
//       chefLocation: snapshot.data()['chefLocation'] ?? "",
//       chefRatings: snapshot.data()['chefRatings'] ?? 0,
//       chefFollowers: snapshot.data()['chefFollowers'] ?? [],
//       chefDishes: snapshot.data()['chefDishes'] ?? [],
//       chefPic: snapshot.data()['chefPic'] ?? "",
//       chefBio: snapshot.data()['chefBio'] ?? "",
//       hasDish: snapshot.data()['hasDish'] ?? false,
//     );
//   }

// // Get user doc stream
//   Stream<ChefData> getChefData(String chefID) {
//     print(
//         " ---------> UID inside the getChefData in database.dart : " + chefID);
//     return chefCollection.doc().snapshots().map(_chefDataFromSnapshot);
//   }

  // Cust data from snapshot (For retrival)
  List<ChefData> _allChefDataFromSnapshot(QuerySnapshot snapshot) {
    print("------> _allChefDataFromSnapshot(docSnapshot snapshot) INVOKED");

    List<ChefData> _chefsList = List<ChefData>();
    for (int i = 0; i < snapshot.docs.length; i++) {
      _chefsList.add(ChefData(
        chefID: snapshot.docs[i].data()['chefID'],
        chefName: snapshot.docs[i].data()['chefName'] ?? "",
        chefPhNo: snapshot.docs[i].data()['chefPhNo'] ?? "",
        chefDateOfBirth: snapshot.docs[i].data()['chefDateOfBirth'] != null
            ? (snapshot.docs[i].data()['chefDateOfBirth'] as Timestamp).toDate()
            : "",
        // //  chefAddDate: (snapshot.docs[i].data()['chefAddDate'] as Timestamp).toDate() ??,
        chefLocation: snapshot.docs[i].data()['chefLocation'] ?? "",
        chefRatings: snapshot.docs[i].data()['chefRatings'].toDouble() ?? 0,
        chefFollowers: snapshot.docs[i].data()['followers'] ?? [],
        chefDishes: snapshot.docs[i].data()['chefDishes'] ?? [],
        chefPic: snapshot.docs[i].data()['chefPic'] ?? "",
        chefBio: snapshot.docs[i].data()['chefBio'] ?? "",
        hasDish: snapshot.docs[i].data()['hasDish'] ?? false,
      ));
      print("snapshot.docs[i].data()['chefName'] inside Database: " +
          snapshot.docs[i].data()['chefName'].toString());
    }
    return _chefsList;
  }

  Stream<List<ChefData>> getSingleChefData(String chefID) {
    print(" ---------> UID inside the getSingleChefData in database.dart : " +
        chefID.toString());
    return chefCollection
        .where("chefID", isEqualTo: chefID)
        .snapshots()
        .map(_allChefDataFromSnapshot);
  }
  // Get user doc stream

  Stream<List<ChefData>> get getAllChefData {
    print(" ---------> Inside the getAllChefData in database.dart ");
    return chefCollection.snapshots().map(_allChefDataFromSnapshot);
  }

// ===============================================================================================================
// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   D I S H   D A T A
// ===============================================================================================================

// >>>>>>>>>>  Upon adding new dish
  Future addNewDishData(Map<String, dynamic> dataMap) async {
    print("---------> AddDishData function reached in DatabaseServies class");

    // *  Creating ID
    int lastIndexOfDish =
        await DBHelperFtns().lastDocumentIdNumber(dishCollection, 'dishID');
    String newDishID = "dish" + (lastIndexOfDish + 1).toString();

    updateChefData({"hasDish": true}, dataMap["chefID"]);
    print("---------> chefID passed inside addNewDish in database: " +
        dataMap["chefID"]);
    await dishCollection.doc(newDishID).set(
      {
        'dishID': newDishID,
        'dishAddDate': DateTime.now(),
        'dishRatings': 0.0,
      },
      SetOptions(merge: true),
    );
    //- Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        print("Adding dynamic dish data - DatabaseService");
        print("Key: $key ,  Value: $value");
        await dishCollection.doc(newDishID).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );
  }

// >>>>>>>>>>  Upon updating existing dish
  Future updateDishData(
      Map<String, dynamic> dataMap, String passedDishID) async {
    print(
        "---------> UpdateDishData function reached in DatabaseServies class");
    await dishCollection.doc(passedDishID).set(
      {
        'dishUpdateDate': DateTime.now(),
      },
      SetOptions(merge: true),
    );
    //- Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        print("Adding dynamic dish data - DatabaseService");
        await dishCollection.doc(passedDishID).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );
  }

// >>>>>>>>>>  View DishData
  // ignore: missing_return
  List<Dish> _dishDataFromSnapshot(QuerySnapshot snapshot) {
    print(
        ">>>>>>>>>>> _dishDataFromSnapshot inside database INVOKED and snapshot legth is : " +
            snapshot.docs.length.toString());
    // Map<Dish,dynamic> chefDishes;
    List<Dish> chefDishes = List<Dish>();

    for (int i = 0; i < snapshot.docs.length; i++) {
      chefDishes.add(Dish(
        dishID: snapshot.docs[i].data()['dishID'] ?? "",
        dishName: snapshot.docs[i].data()['dishName'] ?? "",
        dishPrice: snapshot.docs[i].data()['dishPrice'] ?? 0,
        dishRatings:
            (snapshot.docs[i].data()['dishRatings'] as num).toDouble() ?? 0.0,
        dishPic: snapshot.docs[i].data()['dishPic'] ?? "",
        dishAval: snapshot.docs[i].data()['dishAval'] ?? false,
        dishPrepTime: snapshot.docs[i].data()['dishPrepTime'] ?? 0,
        dishAddDate: snapshot.docs[i].data()['dishAddDate'] ?? "",
        dishUpdateDate: snapshot.docs[i].data()['dishUpdateDate'] ?? "",
        chefID: snapshot.docs[i].data()['chefID'] ?? "",
        attrID: snapshot.docs[i].data()['attrID'] ?? "",
        chefName: snapshot.docs[i].data()['chefName'] ?? "",
        ctgID: snapshot.docs[i].data()['ctgID'] ?? "",
        dishCarb: snapshot.docs[i].data()['dishCarb'] ?? 0.0,
        dishProtein: snapshot.docs[i].data()['dishProtein'] ?? 0.0,
        dishFat: snapshot.docs[i].data()['dishFat'] ?? 0.0,
        dishKcal: snapshot.docs[i].data()['dishKcal'] ?? 0.0,
        dishIngrNames: snapshot.docs[i].data()['dishIngrNames'] ?? [],
        dishCatg: snapshot.docs[i].data()['dishCatg'] ?? 0.0,
      ));
      // print("ALL THE DISHES: " + chefDishes.elementAt(i).dishName.toString());
    }
    return chefDishes;
  }

  Dish _singledishDataFromSnapshot(QuerySnapshot snapshot) {
    // Map<Dish,dynamic> chefDishes;

    return Dish(
      dishID: snapshot.docs[0].data()['dishID'] ?? "",
      dishName: snapshot.docs[0].data()['dishName'] ?? "",
      dishPrice: snapshot.docs[0].data()['dishPrice'] ?? 0,
      dishRatings:
          (snapshot.docs[0].data()['dishRatings'] as num).toDouble() ?? 0.0,
      dishPic: snapshot.docs[0].data()['dishPic'] ?? "",
      dishAval: snapshot.docs[0].data()['dishAval'] ?? false,
      dishPrepTime: snapshot.docs[0].data()['dishPrepTime'] ?? 0,
      dishAddDate: snapshot.docs[0].data()['dishAddDate'] ?? "",
      dishUpdateDate: snapshot.docs[0].data()['dishUpdateDate'] ?? "",
      chefID: snapshot.docs[0].data()['chefID'] ?? "",
      attrID: snapshot.docs[0].data()['attrID'] ?? "",
      chefName: snapshot.docs[0].data()['chefName'] ?? "",
      ctgID: snapshot.docs[0].data()['ctgID'] ?? "",
      dishCarb: snapshot.docs[0].data()['dishCarb'] ?? 0.0,
      dishProtein: snapshot.docs[0].data()['dishProtein'] ?? 0.0,
      dishFat: snapshot.docs[0].data()['dishFat'] ?? 0.0,
      dishKcal: snapshot.docs[0].data()['dishKcal'] ?? 0.0,
      dishIngrNames: snapshot.docs[0].data()['dishIngrNames'] ?? [],
      dishCatg: snapshot.docs[0].data()['dishCatg'] ?? 0.0,
    );
    // print("ALL THE DISHES: " + chefDishes.elementAt(i).dishName.toString());
  }

// //Get user doc stream
//   Stream<List<Dish>> get getDishData {
//     return dishCollection.get().asStream().map(_dishDataFromSnapshot);
//   }

  Stream<List<Dish>> get getChefDishData {
    print("-------> getChefDishData inside DATABASE INVOKED");
    return dishCollection
        .where("chefID", isEqualTo: uid)
        .get()
        .asStream()
        .map(_dishDataFromSnapshot);
  }

  Stream<Dish> getSingleDishforordersummary(String dishID) {
    print("-------> getChefDishData inside DATABASE INVOKED");
    return dishCollection
        .where("dishID", isEqualTo: dishID)
        .get()
        .asStream()
        .map(_singledishDataFromSnapshot);
  }

  Stream<List<Dish>> getSingleDish(String dishID) {
    print("-------> getChefDishData inside DATABASE INVOKED");
    return dishCollection
        .where("dishID", isEqualTo: dishID)
        .get()
        .asStream()
        .map(_dishDataFromSnapshot);
  }

  Stream<List<Dish>> get getAllDishData {
    return dishCollection.get().asStream().map(_dishDataFromSnapshot);
  }

// ==================================================================================================================
// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   D I S H    C A T G    D A T A
// ==================================================================================================================

  List<DishCategory> _dishCatgFromSnapshot(QuerySnapshot snapshot) {
    List<DishCategory> chefDishCategories = List<DishCategory>();

    for (int i = 0; i < snapshot.docs.length; i++) {
      chefDishCategories.add(DishCategory(
        ctgID: snapshot.docs[i].data()['ctgID'] ?? "",
        ctgName: snapshot.docs[i].data()['ctgName'] ?? "",
        ctgAddDate: snapshot.docs[i].data()['ctgAddDate'] ?? "",
      ));
    }
    return chefDishCategories;
  }

//Get user doc stream
  Stream<List<DishCategory>> get getDishCatgData {
    print("============== dishCtgCollection.get():       " +
        dishCtgCollection.get().toString());
    return dishCtgCollection.get().asStream().map(_dishCatgFromSnapshot);
  }

// ==================================================================================================================
// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   D I S H    A T T R I B    D A T A
// ==================================================================================================================

// >>>>>>>>>>  Upon adding new dish
  Future addAttrData(String attrName) async {
    print("---------> AddDishData function reached in DatabaseServies class");

    // *  Creating ID
    int lastIndexOfattr =
        await DBHelperFtns().lastDocumentIdNumber(dishAttrCollection, 'attrID');
    String newAttrID = "attr" + (lastIndexOfattr + 1).toString();

    await dishAttrCollection.doc(newAttrID).set(
      {
        'attrID': newAttrID,
        'attrName': attrName,
        'attrAddDate': DateTime.now(),
      },
      SetOptions(merge: true),
    );
    //- Dynamically adding data in the db
    // dataMap.forEach(
    //   (key, value) async {
    //     print("Adding dynamic attr data - DatabaseService");
    //     print("Key: $key ,  Value: $value");
    //     await dishAttrCollection.doc(newAttrID).set(
    //       {
    //         key: value,
    //       },
    //       SetOptions(merge: true),
    //     );
    //   },
    // );
  }

// >>>>>>>>>>  View AttrData
  List<Attribute> _dishAttrFromSnapshot(QuerySnapshot snapshot) {
    List<Attribute> chefDishCategories = List<Attribute>();

    for (int i = 0; i < snapshot.docs.length; i++) {
      chefDishCategories.add(Attribute(
        attrID: snapshot.docs[i].data()['attrID'] ?? "",
        attrName: snapshot.docs[i].data()['attrName'] ?? "",
        attrAddDate: snapshot.docs[i].data()['attrAddDate'] ?? "",
      ));
      print(
          "snapshot.docs[i].data()['attrAddDate' INSIDE _dishAttrFromSnapshot: " +
              snapshot.docs[i].data()['attrAddDate'].toString());
    }
    return chefDishCategories;
  }

//Get user doc stream
  Stream<List<Attribute>> get getDishAttrData {
    print("dishAttrCollection.get():       " +
        dishAttrCollection.get().toString());
    return dishAttrCollection.get().asStream().map(_dishAttrFromSnapshot);
  }

// ====================================================================================================================
// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   P L A N    D A T A
// ====================================================================================================================

  Future addPlanData(Map<String, dynamic> dataMap) async {
    print('inside function add plan data in database');

    int x = await DBHelperFtns().lastDocumentIdNumber(planCollection, 'planID');
    String planID = "plan" + (x + 1).toString();
    updateCustData({'planID': planID}, BaseViewModel().getUser);

    print("-------> add dish function reached in database calass...");
    print("DataMap : " + dataMap.toString());

    Map<String, List<String>> custExercise = {};
    Map<String, List<String>> custMeals = {};
    await planCollection.doc(planID).set(
      {
        'planID': planID,
        'custID': uid,
        'custExercise': custExercise,
        'custMeals': custMeals,
      },
      SetOptions(merge: true),
    );

    dataMap.forEach(
      (key, value) async {
        print(
            "----------------------- adding dynamic Plan data.. datbase service ");
        await planCollection.doc(planID).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );
  }

  Plan _planDataFromSnapshot(QuerySnapshot snapshot) {
    return Plan(
      planID: snapshot.docs[0].data()['planID'] ?? "",
      custId: snapshot.docs[0].data()['custID'] ?? "",
      custGender: snapshot.docs[0].data()['custGender'] ?? "",
      custHeight: snapshot.docs[0].data()['custHeight'] ?? 0.0,
      custWeight: snapshot.docs[0].data()['custWeight'] ?? 0.0,
      custGoalWeight: snapshot.docs[0].data()['custGoalWeight'] ?? 0.0,
//------------reg nutritients
      custReqKcal: snapshot.docs[0].data()['custReqKcl'] ?? 0.0,
      custReqProtein: snapshot.docs[0].data()['custReqProtein'] ?? 0.0,
      custReqFats: snapshot.docs[0].data()['custReqFats'] ?? 0.0,
      custReqCarbs: snapshot.docs[0].data()['custReqCarbs'] ?? 0.0,
      custExercise: snapshot.docs[0].data()['custExercise'] ?? "",
      custMeals: snapshot.docs[0].data()['custMeals'] ?? "",
      //------------burnt nutritients
      custburntKcal: snapshot.docs[0].data()['custburntKcal'] ?? 0.0,
      custburntProtein: snapshot.docs[0].data()['custburntProtein'] ?? 0.0,
      custBurntFats: snapshot.docs[0].data()['custBurntFats'] ?? 0.0,
      custBurntCarbs: snapshot.docs[0].data()['custBurntCarbs'] ?? 0.0,
      //------------eaten nutritients
      custEatenKcal: snapshot.docs[0].data()['custEatenKcal'] ?? 0.0,
      custEatenProtein: snapshot.docs[0].data()['custEatenProtein'] ?? 0.0,
      custEatenFats: snapshot.docs[0].data()['custEatenFats'] ?? 0.0,
      custEatenCarbs: snapshot.docs[0].data()['custEatenCarbs'] ?? 0.0,
      //  custGender: snapshot.data()['custGender'] ?? "",
      // custHeight: snapshot.data()['custID'] ?? "",
      diseases: snapshot.docs[0].data()['diseases'] ?? 0.0,
    );
  }

  // Future<docSnapshot > getresult() async {
  //   var result =
  //       await planCollection.where("custID", isEqualTo: uid).get();
  //   return result.docs[0].data();
  // }

  Stream<Plan> get getPlanData {
    return planCollection
        .where('custID', isEqualTo: uid)
        .get()
        .asStream()
        .map(_planDataFromSnapshot);
  }

//todo
  Future updatePLanData(Map<String, dynamic> dataMap, String planID) {
    print('------------------- inside update plan data in database ');
    dataMap.forEach(
      (key, value) async {
        await planCollection.doc(planID).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );
  }
  //  Future<bool> updateCustData(
  //     Map<String, dynamic> dataMap, String custID) async {
  //   print(
  //       "---------> DataBase services class reached. Updating user for uid : " +
  //           uid.toString());

  //   // - Setting ID first in a doc
  //   await custCollection.doc(custID).set(
  //     {
  //       'custUpdateDate': DateTime.now(),
  //     },
  //     SetOptions(merge: true),
  //   );

  //   // - Dynamically adding data in the db
  //   dataMap.forEach(
  //     (key, value) async {
  //       await custCollection.doc(custID).set(
  //         {
  //           key: value,
  //         },
  //         SetOptions(merge: true),
  //       );
  //     },
  //   );
  //   return true;
  // }

  Future<int> countdocs(CollectionReference collection) async {
    QuerySnapshot _myDoc = await collection.get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    return _myDocCount.length;
  }

// =================================================================================================
// -------------------------------------------------------------------- Custom queries functions
// =================================================================================================

// This function is just to check if the the passed user ID is of customer or chef
  Future<dynamic> checkUserID(String userID) async {
    var _completer = Completer<dynamic>();

    await custCollection.where("custID", isEqualTo: userID).get().then((data) {
      if (data.docs.length > 0) {
        print(
            "-----> data.docs inside custCollection completer check of 'checkUserID' : " +
                data.docs.length.toString());
        _completer.complete("cust");
      }
    });

    await chefCollection.where("chefID", isEqualTo: userID).get().then((data) {
      if (data.docs.length > 0) {
        print(
            "-----> data.docs inside chefCollection completer check of 'checkUserID' : " +
                data.docs.length.toString());
        _completer.complete("chef");
      }
    });
    await delivCollection
        .where("delivID", isEqualTo: userID)
        .get()
        .then((data) {
      if (data.docs.length > 0) {
        print(
            "-----> data.docs inside delivCollection completer check of 'checkUserID' : " +
                data.docs.length.toString());
        _completer.complete("deliv");
      }
    });

    print(
        "---------> DataBase services class reached. Completer.future inside checkUserID in DBServices: " +
            _completer.future.toString());

    String returnUser = await _completer.future;
    print("-------> User returned from COMPLETER: " + returnUser);
    return returnUser != null ? returnUser : null;

    // return null;

    // ---> https://stackoverflow.com/a/51122369
  }

  // Future<String> checkUserID(String userID) async {
  //   final custCheck =
  //       await custCollection.where("custID", isEqualTo: userID).get();
  //   final chefCheck =
  //       await chefCollection.where("chefID", isEqualTo: userID).get();
  //   print("---------> DataBase services class reached. ");
  //   print(
  //       "Checking if userID is in database or not? (Message from 'DatabaseServices' class)" +
  //           userID +
  //           " : Cust Check " +
  //           custCheck.toString() +
  //           " Chef Check : " +
  //           chefCheck.toString());

  //   if (custCheck.docs.length > 0) {
  //     return "cust";
  //   } else if (chefCheck.docs.length > 0) {
  //     return "chef";
  //   } else {
  //     print("Returning null from database.dart .................");
  //     return null;
  //   }

  //   // ---> https://stackoverflow.com/a/51122369
  // }

// - This function is to check if phone no exist in either "chef" or "customer"
  Future<String> isPhoneNoAlreadyRegistered(String _phoneNo) async {
    var chefResult =
        await chefCollection.where("chefPhNo", isEqualTo: _phoneNo).get();
    var custResult =
        await custCollection.where("custPhNo", isEqualTo: _phoneNo).get();

    var delivResult =
        await delivCollection.where("phoneNo", isEqualTo: _phoneNo).get();

    if (chefResult.docs.length > 0) {
      print("Chef Case is true___________");
      return "chef";
    } else if (custResult.docs.length > 0) {
      print("Cust Case is true___________");
      return "cust";
    } else if (delivResult.docs.length > 0) {
      print("Deliv Case is true___________");
      return "deliv";
    } else {
      return null;
    }
  }

// --------------------- Phone no check
  Future<bool> isPhoneNoInChef(String _phoneNo) async {
    var chefResult =
        await chefCollection.where("chefPhNo", isEqualTo: _phoneNo).get();

    return chefResult.docs.length > 0 ? true : false;
  }

  Future<bool> isPhoneNoInCust(String _phoneNo) async {
    var custResult =
        await custCollection.where("custPhNo", isEqualTo: _phoneNo).get();

    return custResult.docs.length > 0 ? true : false;
  }

  // Future<bool> isPhoneNoInCust(String _phoneNo) async {
  //   var custResult = await custCollection
  //       .where("custPhNo", isEqualTo: _phoneNo)
  //       .get();

  //   return custResult.docs.length > 0 ? true : false;
  // }

  // Future getTotal(postID) async {
  //   int counter;
  //   await Firestore.instance // <<<== changed
  //       .collection('post')
  //       .doc(postID)
  //       .collection('count_shrads')
  //       .snapshots()
  //       .listen((data) =>
  //           data.docs.forEach((doc) => counter += (doc["count"])));
  //   print("The total is $counter");
  //   return counter;
  // }

  //
  // >>>>>>>> Sign-in Customer
  //

//******************************************************************************************** */
// *************************************** C  A  R  T ******************************************
//********************************************************************************************** */

  Future<String> addNewCartData(String custID) async {
    print(
        "---------> Addnewcart on user registration  function reached in DatabaseServies class");

    // *  Creating ID
    int lastIndexOfcart =
        await DBHelperFtns().lastDocumentIdNumber(cartCollection, 'cartID');

    String newcartID = "cart" + (lastIndexOfcart + 1).toString();
    print(
        '******* after last document function in add new cart function in  database new cart id is ' +
            newcartID.toString());
    Map<String, dynamic> items = {};
    await cartCollection.doc(newcartID).set(
      {
        'custID': custID,
        'cartID': newcartID,
        'cartAddDate': DateTime.now(),
        'items': items,
      },
      SetOptions(merge: true),
    );

    return newcartID;
  }

  Future updateCartData(String cartID, String productID, int quantity) async {
    print(
        "---------> update cart  function reached in DatabaseServies class. Product id: " +
            productID.toString() +
            " cartID: " +
            cartID.toString());
    await cartCollection.doc(cartID).set(
      {
        'items': {productID: quantity},
      },
      SetOptions(merge: true),
    );

    print('data updated ');
  }

  Future deleteCartItem(String cartID, String productID) {
    print('**** inside delete cart item in database');

    cartCollection.doc(cartID).set(
      {
        'items': {productID: FieldValue.delete()}
      },
      SetOptions(merge: true),
    );
  }

  bool deleteDocument(
      CollectionReference passedCollection, String passedDishID) {
    bool deleteResult = false;
    passedCollection.doc(passedDishID).delete().then(
          (value) => deleteResult = true,
        );
    return deleteResult;
  }

  Future deleteallCartItems(String cartID, Map<String, dynamic> items) {
    print('**** inside delete all cart item in database');

    for (int index = 0; index < items.length; index++) {
      cartCollection.doc(cartID).set(
        {
          'items': {items.keys.elementAt(index): FieldValue.delete()}
        },
        SetOptions(merge: true),
      );
    }
  }

  Future updateInventory(String dishID, int quantity) {
    print('------->>>>> inside update inventory  in database' +
        quantity.toString());
    dishCollection.doc(dishID).set(
      {
        'quantity': quantity,
      },
      SetOptions(merge: true),
    );
  }

  Cart _userCartDataFromsnapshot(QuerySnapshot snapshot) {
    int i = 0;
    print('****** snapshot length inside user cart data from snapshot ' +
        snapshot.docs[i].data()['items'].toString());
    try {
      String cartID = snapshot.docs[i].data()['cartID'] ?? '';
      String custID = snapshot.docs[i].data()['custID'] ?? '';
      return Cart(
        cartid: cartID,
        custID: custID,
        items: snapshot.docs[i].data()['items'] ?? null,
      );
    } catch (error) {
      print('error in map function of ucer cart ' + error.toString());
    }
  }

  Stream<Cart> getCartData(String custID) {
    return cartCollection
        .where('custID', isEqualTo: custID)
        .snapshots()
        .map(_userCartDataFromsnapshot);
  }

  //--------------------------------- O R D E R ------------------------------

  Future<String> createOrder(Map<String, dynamic> dataMap) async {
    print('inside create mew order function ***********');

    int lastindexofOrder =
        await DBHelperFtns().lastDocumentIdNumber(orderCollection, 'orderID');

    String newOrderID = 'order' + (lastindexofOrder + 1).toString();
    await orderCollection.doc(newOrderID).set(
      {
        'orderID': newOrderID,
        'orderDate': DateTime.now(),
      },
      SetOptions(merge: true),
    );
    dataMap.forEach(
      (key, value) async {
        print("Adding dynamic data - DatabaseService");
        print("Key: $key ,  Value: $value");
        await orderCollection.doc(newOrderID).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );

    return newOrderID;
  }

  // >>>>>>>>>>  Upon updating old order
  Future updateOrderData(Map<String, dynamic> dataMap, String orderID) async {
    print(
        "---------> updateProductData function reached in DatabaseServies class");

    await orderCollection.doc(orderID).set(
      {
        'updateDate': DateTime.now(),
      },
      SetOptions(merge: true),
    );
    //- Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        print("Adding dynamic data - DatabaseService");
        print("Key: $key ,  Value: $value");
        await orderCollection.doc(orderID).update(
          {
            key: value,
          },
        );
      },
    );
  }

  List<Order> _orderDataFromSnapshot(QuerySnapshot snapshot) {
    print(
        ">>>>>>>>>>> _orderDataFromSnapshot inside orderdatafrom snapshot database INVOKED and snapshot legth is : " +
            snapshot.docs.length.toString());
    // Map<Dish,dynamic> chefDishes;
    List<Order> ordersList = List<Order>();

    for (int i = 0; i < snapshot.docs.length; i++) {
      ordersList.add(Order(
          orderID: snapshot.docs[i].data()['orderID'] ?? "",
          custID: snapshot.docs[i].data()['custID'] ?? "",
          orderStatus: snapshot.docs[i].data()['orderStatus'] ?? "",
          phoneNo: snapshot.docs[i].data()['contactNo'] ?? "",
          chefID: snapshot.docs[i].data()['chefID'] ?? "",
          orderDate:
              (snapshot.docs[i].data()['orderDate'] as Timestamp).toDate() ??
                  "",
          items: snapshot.docs[i].data()['items'] ?? "",
          total: snapshot.docs[i].data()['total'] ?? "",
          custName: snapshot.docs[i].data()['custName'] ?? "",
          location: snapshot.docs[i].data()['location'] ?? []));
    }
    return ordersList;
  }

  Stream<List<Order>> getSingleOrderData(String _passedOrderID) {
    print("---> _passedOrderID inside getSingleOrderData in database class: " +
        _passedOrderID.toString());
    return orderCollection
        .where("orderID", isEqualTo: _passedOrderID)
        .snapshots()
        .map(_orderDataFromSnapshot);
  }

  Stream<List<Order>> getCustOrderData() {
    print(
        "----------------------------> _custID inside getSingleOrderData in database class: " +
            uid.toString());
    return orderCollection
        .where("custID", isEqualTo: uid)
        .snapshots()
        .map(_orderDataFromSnapshot);
  }

  Stream<List<Order>> getAllOrdersData() {
    return orderCollection.snapshots().map(_orderDataFromSnapshot);
  }
  //
  // ------------------------------ E  X  E  R  C  I  S  E
  //

  List<Exercise> _exerciseDataFromSnapShop(QuerySnapshot snapshot) {
    print('-------------------------- inside map function of exercise ' +
        snapshot.docs.length.toString());

    List<Exercise> exerciseList = List<Exercise>();
    for (int i = 0; i < snapshot.docs.length; i++) {
      exerciseList.add(Exercise(
        exerciseName: snapshot.docs[i].data()['ExerciseName'] ?? "",
        weight_48_59: snapshot.docs[i].data()['48kg to 59kg'] ?? "",
        weight_59_70: snapshot.docs[i].data()['59kg to 70kg'] ?? "",
        weight_70_82: snapshot.docs[i].data()['70kg to 82kg'] ?? "",
        weight_82_93: snapshot.docs[i].data()['82kg to 93kg'] ?? "",
        weight_93_104: snapshot.docs[i].data()['93kg to 104'] ?? "",
        weight_104_116: snapshot.docs[i].data()['104kg to 116kg'] ?? "",
        weight_116_127: snapshot.docs[i].data()['116kg to 127kg'] ?? "",
      ));
    }
    return exerciseList;
  }

  Stream<List<Exercise>> getAllExercises() {
    print('--------------- inside get all exercises function ');
    return exerciseCollection.snapshots().map(_exerciseDataFromSnapShop);
  }

  Future updateCustExercise(String planID, String exerciseName, String calories,
      String duration) async {
    print(
        '---------------------inside updaet cust exercise funtion indatabase');
    String now = DateTime.now().toString();
    await planCollection.doc(planID).set(
      {
        'custExercise': {
          now: [exerciseName, calories, duration]
        },
      },
      SetOptions(merge: true),
    );
  }

  Future updateCustMeals(
      String planID, String mealName, String calories) async {
    String now = DateTime.now().toString();
    await planCollection.doc(planID).set(
      {
        'custMeals': {
          now: [mealName, calories]
        },
      },
      SetOptions(merge: true),
    );
    print('---------------------inside updaet cust Meals  funtion indatabase');
  }

  // Future updateCustAddress(String custID, String title, String houseno,
  //     String street, String city) async {
  //   print('inside update address function  in  data base');
  //   await custCollection.doc(custID).set(
  //     {
  //       'custAddress': {
  //         title: [houseno, street, city]
  //       },
  //     },
  //     SetOptions(merge: true),
  //   );
  // }

// ============================================================================================================
// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   D E L I V E R Y    D A T A
// ============================================================================================================
  //
  // >>>>>>>>>>>>>>>> S E T T I N G   D A T A
  //
  Future<bool> addNewDelivData(Map<String, dynamic> dataMap) async {
    print("---------> DataBase services class reached. Updating user for uid" +
        uid.toString());
    // - Setting ID first in a doc

    await delivCollection.doc(uid).set(
      {
        'delivID': uid,
        'delivAddDate': DateTime.now(),
      },
      SetOptions(merge: true),
    );

    // - Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        await delivCollection.doc(uid).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );
    return true;
  }

  Future<bool> updateDelivData(
      Map<String, dynamic> dataMap, String delivID) async {
    print(
        "---------> DataBase services class reached. Updating user for uid : " +
            uid.toString());

    // - Setting ID first in a doc
    await delivCollection.doc(delivID).set(
      {
        'delivUpdateDate': DateTime.now(),
      },
      SetOptions(merge: true),
    );

    // - Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        await delivCollection.doc(delivID).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );
    return true;
  }

  // -------------- Address
  Future updateDelivAddress(String delivID, String title, String houseno,
      String street, String city) async {
    print('inside update address function  in  data base');
    await delivCollection.doc(delivID).set(
      {
        'delivAddress': {
          title: [houseno, street, city]
        },
      },
      SetOptions(merge: true),
    );
  }

  // ignore: missing_return
  Future removeDelivAddress(String delivID, String title) {
    delivCollection.doc(delivID).set(
      {
        'delivAddress': {title: FieldValue.delete()}
      },
      SetOptions(merge: true),
    );
  }

  //
  // >>>>>>>>>>>>>>>> G E T T I N G   D A T A
  //
  DelivData _delivDataFromSnapshot(DocumentSnapshot snapshot) {
    return DelivData(
      delivID: uid,
      delivPhNo: snapshot.data()['delivPhNo'] ?? "",
      delivName: snapshot.data()['delivName'] ?? "",
      delivaddress: snapshot.data()['delivAddress'] ?? '',
    );
  }

  // Get user doc stream
  Stream<DelivData> get getDelivData {
    print(
        " UiD DB TEST function reached in getdeliv data******************** ");
    return delivCollection.doc(uid).snapshots().map(_delivDataFromSnapshot);
  }

// ============================================================================================================
// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   D E L I V E R Y    D A T A
// ============================================================================================================

  List<Disease> _diseaseDataFromSnapshot(QuerySnapshot snapshot) {
    print(
        ">>>>>>>>>>> _diseaseDataFromSnapshot inside database INVOKED and snapshot legth is : " +
            snapshot.docs.length.toString());
    // Map<Dish,dynamic> chefDishes;
    List<Disease> diseasesList = List<Disease>();

    for (int i = 0; i < snapshot.docs.length; i++) {
      diseasesList.add(
        Disease(
          diseaseID: snapshot.docs[i].data()['diseaseID'] ?? "",
          name: snapshot.docs[i].data()['name'] ?? "",
          notRecommended: snapshot.docs[i].data()['notRecommended'] ?? [],
          recommended: snapshot.docs[i].data()['recommended'] ?? [],
        ),
      );
      print("snapshot.docs[i].data()['name']: " +
          snapshot.docs[i].data()['name'].toString());
      print("snapshot.docs[i].data()['diseaseID']: " +
          snapshot.docs[i].data()['diseaseID'].toString());
      print("snapshot.docs[i].data()['notRecommended']: " +
          snapshot.docs[i].data()['notRecommended'].toString());
      print("snapshot.docs[i].data()['recommended']: " +
          snapshot.docs[i].data()['recommended'].toString());
      print("++++++++++");
    }
    return diseasesList;
  }

  Stream<List<Disease>> getSinglediseaseData(String _passeddiseaseID) {
    return diseasesCollection
        .where("diseaseID", isEqualTo: _passeddiseaseID)
        .snapshots()
        .map(_diseaseDataFromSnapshot);
  }

  Stream<List<Disease>> getAllDiseasesData() {
    return diseasesCollection.snapshots().map(_diseaseDataFromSnapshot);
  }

// ============================================================================================================
// ------------------------------- C H A T    F U N C T I O N S
// ============================================================================================================
  Future<bool> addnewuser(String name) async {
    await userCollection.doc(uid).set(
      {
        'idUser': uid,
        'LastMessagetime': DateTime.now(),
        'name': name,
        'urlAvatar': ''
      },
      SetOptions(merge: true),
    );
  }

  Future<bool> updateUserData(
      Map<String, dynamic> dataMap, String custID) async {
    print(
        "---------> DataBase services class reached. Updating user for uid : " +
            uid.toString());

    // - Setting ID first in a doc
    await userCollection.doc(custID).set(
      {
        'custUpdateDate': DateTime.now(),
      },
      SetOptions(merge: true),
    );

    // Future<dynamic> checkUserID(String userID) async {
    //   var _completer = Completer<dynamic>();

    //   await custCollection.where("custID", isEqualTo: userID).get().then((data) {
    //     if (data.docs.length > 0) {
    //       print(
    //           "-----> data.docs inside custCollection completer check of 'checkUserID' : " +
    //               data.docs.length.toString());
    //       _completer.complete("cust");
    //     }
    //   });

    //   await chefCollection.where("chefID", isEqualTo: userID).get().then((data) {
    //     if (data.docs.length > 0) {
    //       print(
    //           "-----> data.docs inside chefCollection completer check of 'checkUserID' : " +
    //               data.docs.length.toString());
    //       _completer.complete("chef");
    //     }
    //   });

    //   print(
    //       "---------> DataBase services class reached. Completer.future inside checkUserID in DBServices: " +
    //           _completer.future.toString());

    //   String returnUser = await _completer.future;
    //   print("-------> User returned from COMPLETER: " + returnUser);
    //   return returnUser != null ? returnUser : null;

    //   // return null;

    //   // ---> https://stackoverflow.com/a/51122369
    // }

    Future<String> checkusertype(String uid) async {
      String usertype = 'cust';
      print('-----------------------------inside check user type in database ');
      final snapShot = await FirebaseFirestore.instance
          .collection('customer')
          .doc(uid)
          .get();

      if (snapShot == null || !snapShot.exists) {
        print('-------------------------> user id ' +
            uid +
            " if froom chef collection  ");
        usertype = 'chef';
      }

      // chefCollection.where("chefID", isEqualTo: uid).get().then((data) {
      //   if (data.docs.length > 0) {
      //     print(
      //         "-----> data.docs inside chefCollection completer check of 'checkUserID' : " +
      //             data.docs.length.toString());
      //     usertype = "chef";
      //   }
      // });
      return usertype;
    }
  }

  Stream<List<String>> get getallmessagedocument {
    print(" ---------> Inside the getAllmessagedocument in database ");
    return messageCollection.snapshots().map(_messagedatafromsnapshot);
  }

  List<String> _messagedatafromsnapshot(QuerySnapshot snapshot) {
    // print(
    //     '-------------------> inside map function of message data in database :' +
    //         snapshot.docs.length.toString());
    List<String> _documentlist = List<String>();
    for (int i = 0; i < snapshot.docs.length; i++) {
      _documentlist.add(
        snapshot.docs[i].id,
      );
    }
    return _documentlist;
  }

  Stream<List<ChatUser>> get getAllUserData {
    // return userCollection.orderBy("LastMessagetime", "desc").snapshots().map(_usersdatafromsnapshop);

    print(" ---------> Inside the getAllUsersData in database ");
    return userCollection
        .orderBy('LastMessagetime', descending: false)
        .snapshots()
        .map(_usersdatafromsnapshop);
  }

  List<ChatUser> _usersdatafromsnapshop(QuerySnapshot snapshot) {
    List<ChatUser> _usersList = List<ChatUser>();
    for (int i = 0; i < snapshot.docs.length; i++) {
      _usersList.add(ChatUser(
        idUser: snapshot.docs[i].data()['idUser'] ?? "",
        name: snapshot.docs[i].data()['name'] ?? "",
        pushToken: snapshot.docs[i].data()['pushToken'] ?? "",
        urlAvatar: snapshot.docs[i].data()['urlAvatar'] ?? "",
        chattingWith: snapshot.docs[i].data()['chattingWith'] ?? "",
        lastMessageTime: snapshot.docs[i].data()['LastMessagetime'] != null
            ? (snapshot.docs[i].data()['LastMessagetime'] as Timestamp).toDate()
            : "",
      ));
      print("snapshot.docs[i].data()['chefName'] inside Database: " +
          snapshot.docs[i].data()['chefName'].toString());
    }
    return _usersList;
  }
}
