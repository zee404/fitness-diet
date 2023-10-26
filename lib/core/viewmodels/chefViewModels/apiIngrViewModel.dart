// import 'dart:async';

// import 'package:fitness_diet/core/enums/viewstate.dart';
// import 'package:fitness_diet/core/models/FoodCentralJSONModel.dart';
// import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
// import 'package:http/http.dart' as http;

// List<FoodInfo> _currentFoodIngr = [];

// // ignore: camel_case_types
// class IngrViewModel extends BaseViewModel {
//   // ---------------------------------------- G E T   L I S T   R E L A T E D   T O   S E A R C H E D    F O O D
//   Future<List<FoodInfo>> getSearchedIngredientsList(
//       String searchedQuery) async {
//     setState(ViewState.Busy);
//     var client = http.Client();
//     List<FoodInfo> searchedFoodsList;
//     var apiKey = "vAK9vJMtSQdYxcBhYRxZl5cpEkahZEkBhl0iw0ox";
//     var dataType = "Survey (FNDDS)";
//     // var dataType = "Branded";

//     int pageSize = 30;

//     try {
//       http.Response responce = await client.get(
//           "https://api.nal.usda.gov/fdc/v1/foods/list?api_key=$apiKey&query=$searchedQuery&pageSize=$pageSize&dataType=$dataType");
//       if (responce.statusCode == 200) {
//         String jsonString = responce.body;
//         // printWrapped(jsonString);
//         searchedFoodsList = foodInfoFromJson(jsonString);
//       }
//     } catch (Exception) {
//       print("E X C E P T I O N");
//       print("Exception in APi in apimanager class: " + Exception.toString());
//     }
//     setState(ViewState.Idle);
//     return searchedFoodsList;
//   }

//   void printWrapped(String text) {
//     final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
//     pattern.allMatches(text).forEach((match) => print(match.group(0)));
//   }

// // ---------------------------------------- G E T   L I S T   O F   A L L   F O O D S   I T E M S
//   Future<List<FoodInfo>> getAllIngredientsList() async {
//     setState(ViewState.Busy);
//     print("---> Inside getAllIngredientsList in ViewModel");
//     var client = http.Client();
//     List<FoodInfo> allFoodsInfo;
//     var apiKey = "vAK9vJMtSQdYxcBhYRxZl5cpEkahZEkBhl0iw0ox";
//     var dataType = "Survey (FNDDS)";
//     // int pageSize = 100;

//     try {
//       http.Response responce = await client.get(
//           "https://api.nal.usda.gov/fdc/v1/foods/list?api_key=$apiKey&dataType=$dataType");
//       print("Inside API MANAGER");
//       if (responce.statusCode == 200) {
//         String jsonString = responce.body;

//         allFoodsInfo = foodInfoFromJson(jsonString);
//       }
//     } catch (Exception) {
//       print("E X C E P T I O N");
//       print("Exception in APi in apimanager class: " + Exception.toString());
//     }

//     setState(ViewState.Idle);
//     return allFoodsInfo;
//   }

// // ---------------------------------------- S E T   I N G R E D I E N T S

//   FutureOr setIngList(List<FoodInfo> _foodInfoList) {
//     _currentFoodIngr = _foodInfoList;

//     print(" ---> INSIDE setIngList and _currentFoodIngr = " +
//         _currentFoodIngr.toString());
//   }

//   List<FoodInfo> get getCurrentFoodIngr {
//     print(" ---> INSIDE getCurrentFoodIngr and  returning  = " +
//         _currentFoodIngr.toString());
//     return _currentFoodIngr;
//   }
// }
// // class API_MANAGER {
// //   Future<FoodNutrient> getIngredients() async {
// //     var client = http.Client();
// //     var foodNutrient;
// //     var jsonMap;
// //     try {
// //       var responce =
// //           await client.get("https://api.spoonacular.com/recipes/complexSearch");

// //       if (responce.statusCode == 200) {
// //         var jsonString = responce.body;
// //         print("Inside the if of apimanager");
// //         jsonMap = json.decode(jsonString);
// //         foodNutrient = FoodNutrient.fromJson(jsonMap[0]);
// //         print("jsonMap: " + jsonMap.toString());
// //         print("jsonMap[0]: " + jsonMap[0].toString());
// //         print("foodNutrient: " + foodNutrient.toString());
// //       }
// //     } catch (Exception) {
// //       print("foodNutrient: " + foodNutrient.toString());
// //       print("jsonMap: " + jsonMap.toString());
// //       print("Exception in APi in apimanager class: " + Exception.toString());
// //     }

// //     return foodNutrient;
// //   }
// // }
