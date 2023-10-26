// To parse this JSON data, do
//
//     final ingredientInfo = ingredientInfoFromJson(jsonString);

import 'dart:convert';

IngredientInfo ingredientInfoFromJson(String str) =>
    IngredientInfo.fromJson(json.decode(str));

String ingredientInfoToJson(IngredientInfo data) => json.encode(data.toJson());

class IngredientInfo {
  IngredientInfo({
    this.uri,
    this.calories,
    this.totalWeight,
    this.dietLabels,
    this.healthLabels,
    this.cautions,
    this.totalNutrients,
    this.totalDaily,
    this.ingredients,
    this.totalNutrientsKCal,
  });

  String uri;
  int calories;
  double totalWeight;
  List<dynamic> dietLabels;
  List<String> healthLabels;
  List<dynamic> cautions;
  Map<String, TotalDaily> totalNutrients;
  Map<String, TotalDaily> totalDaily;
  List<Ingredient> ingredients;
  TotalNutrientsKCal totalNutrientsKCal;

  factory IngredientInfo.fromJson(Map<String, dynamic> json) {
    print(" calories: " + json["calories"].toString());
    print(json["calories"].runtimeType);
    print(" totalWeight: " + json["totalWeight"].toString());
    print(json["totalWeight"].runtimeType);
    return IngredientInfo(
      uri: json["uri"],
      calories: json["calories"],
      totalWeight: json["totalWeight"],
      dietLabels: List<dynamic>.from(json["dietLabels"].map((x) => x)),
      healthLabels: List<String>.from(json["healthLabels"].map((x) => x)),
      cautions: List<dynamic>.from(json["cautions"].map((x) => x)),
      totalNutrients: Map.from(json["totalNutrients"]).map(
          (k, v) => MapEntry<String, TotalDaily>(k, TotalDaily.fromJson(v))),
      totalDaily: Map.from(json["totalDaily"]).map(
          (k, v) => MapEntry<String, TotalDaily>(k, TotalDaily.fromJson(v))),
      ingredients: List<Ingredient>.from(
          json["ingredients"].map((x) => Ingredient.fromJson(x))),
      totalNutrientsKCal:
          TotalNutrientsKCal.fromJson(json["totalNutrientsKCal"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "uri": uri,
        "calories": calories,
        "totalWeight": totalWeight,
        "dietLabels": List<dynamic>.from(dietLabels.map((x) => x)),
        "healthLabels": List<dynamic>.from(healthLabels.map((x) => x)),
        "cautions": List<dynamic>.from(cautions.map((x) => x)),
        "totalNutrients": Map.from(totalNutrients)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "totalDaily": Map.from(totalDaily)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
        "totalNutrientsKCal": totalNutrientsKCal.toJson(),
      };
}

class Ingredient {
  Ingredient({
    this.text,
    this.parsed,
  });

  String text;
  List<Parsed> parsed;

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        text: json["text"],
        parsed:
            List<Parsed>.from(json["parsed"].map((x) => Parsed.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "parsed": List<dynamic>.from(parsed.map((x) => x.toJson())),
      };
}

class Parsed {
  Parsed({
    this.quantity,
    this.measure,
    this.foodMatch,
    this.food,
    this.foodId,
    this.weight,
    this.retainedWeight,
    this.nutrients,
    this.measureUri,
    this.status,
  });

  double quantity;
  String measure;
  String foodMatch;
  String food;
  String foodId;
  double weight;
  double retainedWeight;
  Map<String, TotalDaily> nutrients;
  String measureUri;
  String status;

  factory Parsed.fromJson(Map<String, dynamic> json) {
    print("-------- quantity type below " +
        json['quantity'].toString() +
        "------------");
    print(json['quantity'].runtimeType);

    print("-------- weight type below " +
        json['weight'].toString() +
        "------------");
    print(json['weight'].runtimeType);

    print("-------- retainedWeight type below and value" +
        json['retainedWeight'].toString() +
        " ------------");
    print(json['retainedWeight'].runtimeType);

    return Parsed(
      quantity: json["quantity"],
      measure: json["measure"],
      foodMatch: json["foodMatch"],
      food: json["food"],
      foodId: json["foodId"],
      weight: json["weight"],
      retainedWeight: json["retainedWeight"],
      nutrients: Map.from(json["nutrients"]).map(
          (k, v) => MapEntry<String, TotalDaily>(k, TotalDaily.fromJson(v))),
      measureUri: json["measureURI"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "measure": measure,
        "foodMatch": foodMatch,
        "food": food,
        "foodId": foodId,
        "weight": weight,
        "retainedWeight": retainedWeight,
        "nutrients": Map.from(nutrients)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "measureURI": measureUri,
        "status": status,
      };
}

class TotalDaily {
  TotalDaily({
    this.label,
    this.quantity,
    this.unit,
  });

  String label;
  double quantity;
  Unit unit;

  factory TotalDaily.fromJson(Map<String, dynamic> json) {
    print(" quanity: " + json['quantity'].toString());
    print("--------------------");
    print(json['quantity'].runtimeType);
    print("--------------------");
    return TotalDaily(
      label: json["label"],
      // quantity: json['price'] == null ? 0.0 : json["quantity"].toDouble(),
      quantity: double.parse(json['quantity'].toString()),
      unit: unitValues.map[json["unit"]],
    );
  }

  Map<String, dynamic> toJson() => {
        "label": label,
        "quantity": quantity,
        "unit": unitValues.reverse[unit],
      };
}

enum Unit { MG, G, KCAL, UNIT_G, IU, EMPTY }

final unitValues = EnumValues({
  "%": Unit.EMPTY,
  "g": Unit.G,
  "IU": Unit.IU,
  "kcal": Unit.KCAL,
  "mg": Unit.MG,
  "µg": Unit.UNIT_G
});

class TotalNutrientsKCal {
  TotalNutrientsKCal({
    this.enercKcal,
    this.procntKcal,
    this.fatKcal,
    this.chocdfKcal,
  });

  TotalDaily enercKcal;
  TotalDaily procntKcal;
  TotalDaily fatKcal;
  TotalDaily chocdfKcal;

  factory TotalNutrientsKCal.fromJson(Map<String, dynamic> json) =>
      TotalNutrientsKCal(
        enercKcal: TotalDaily.fromJson(json["ENERC_KCAL"]),
        procntKcal: TotalDaily.fromJson(json["PROCNT_KCAL"]),
        fatKcal: TotalDaily.fromJson(json["FAT_KCAL"]),
        chocdfKcal: TotalDaily.fromJson(json["CHOCDF_KCAL"]),
      );

  Map<String, dynamic> toJson() => {
        "ENERC_KCAL": enercKcal.toJson(),
        "PROCNT_KCAL": procntKcal.toJson(),
        "FAT_KCAL": fatKcal.toJson(),
        "CHOCDF_KCAL": chocdfKcal.toJson(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
