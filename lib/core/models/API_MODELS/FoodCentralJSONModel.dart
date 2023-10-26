// To parse this JSON data, do
//
//     final foodInfo = foodInfoFromJson(jsonString);

import 'dart:convert';

List<FoodInfo> foodInfoFromJson(String str) =>
    List<FoodInfo>.from(json.decode(str).map((x) => FoodInfo.fromJson(x)));

String foodInfoToJson(List<FoodInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodInfo {
  FoodInfo({
    this.fdcId,
    this.description,
    this.additionalDescriptions,
    this.dataType,
    this.publicationDate,
    this.foodCode,
    this.foodNutrients,
    this.ndbNumber,
  });

  int fdcId;
  String description;
  DataType dataType;
  DateTime publicationDate;
  String foodCode;
  List<FoodNutrient> foodNutrients;
  String ndbNumber;
  String additionalDescriptions;

  factory FoodInfo.fromJson(Map<String, dynamic> json) => FoodInfo(
        fdcId: json["fdcId"],
        description: json["description"],
        additionalDescriptions: json["additionalDescriptions"],
        dataType: dataTypeValues.map[json["dataType"]],
        publicationDate: DateTime.parse(json["publicationDate"]),
        foodCode: json["foodCode"] == null ? null : json["foodCode"],
        foodNutrients: List<FoodNutrient>.from(
            json["foodNutrients"].map((x) => FoodNutrient.fromJson(x))),
        ndbNumber: json["ndbNumber"] == null ? null : json["ndbNumber"],
      );

  Map<String, dynamic> toJson() => {
        "fdcId": fdcId,
        "description": description,
        "additionalDescriptions": additionalDescriptions,
        "dataType": dataTypeValues.reverse[dataType],
        "publicationDate":
            "${publicationDate.year.toString().padLeft(4, '0')}-${publicationDate.month.toString().padLeft(2, '0')}-${publicationDate.day.toString().padLeft(2, '0')}",
        "foodCode": foodCode == null ? null : foodCode,
        "foodNutrients":
            List<dynamic>.from(foodNutrients.map((x) => x.toJson())),
        "ndbNumber": ndbNumber == null ? null : ndbNumber,
      };
}

enum DataType { SURVEY_FNDDS, SR_LEGACY }

final dataTypeValues = EnumValues(
    {"SR Legacy": DataType.SR_LEGACY, "Survey (FNDDS)": DataType.SURVEY_FNDDS});

class FoodNutrient {
  FoodNutrient({
    this.number,
    this.name,
    this.amount,
    this.unitName,
    this.derivationCode,
    this.derivationDescription,
  });

  String number;
  String name;
  double amount;
  UnitName unitName;
  DerivationCode derivationCode;
  String derivationDescription;

  factory FoodNutrient.fromJson(Map<String, dynamic> json) => FoodNutrient(
        number: json["number"],
        name: json["name"],
        amount: json["amount"].toDouble(),
        unitName: unitNameValues.map[json["unitName"]],
        derivationCode: json["derivationCode"] == null
            ? null
            : derivationCodeValues.map[json["derivationCode"]],
        derivationDescription: json["derivationDescription"] == null
            ? null
            : json["derivationDescription"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "amount": amount,
        "unitName": unitNameValues.reverse[unitName],
        "derivationCode": derivationCode == null
            ? null
            : derivationCodeValues.reverse[derivationCode],
        "derivationDescription":
            derivationDescription == null ? null : derivationDescription,
      };
}

enum DerivationCode {
  A,
  NC,
  Z,
  BNA,
  BFSN,
  T,
  CAZN,
  NR,
  AI,
  NP,
  O,
  BFZN,
  MC,
  LC,
  RA,
  BFPN,
  JA,
  FLC,
  FLA,
  RC,
  RP,
  RPA,
  RPI
}

final derivationCodeValues = EnumValues({
  "A": DerivationCode.A,
  "AI": DerivationCode.AI,
  "BFPN": DerivationCode.BFPN,
  "BFSN": DerivationCode.BFSN,
  "BFZN": DerivationCode.BFZN,
  "BNA": DerivationCode.BNA,
  "CAZN": DerivationCode.CAZN,
  "FLA": DerivationCode.FLA,
  "FLC": DerivationCode.FLC,
  "JA": DerivationCode.JA,
  "LC": DerivationCode.LC,
  "MC": DerivationCode.MC,
  "NC": DerivationCode.NC,
  "NP": DerivationCode.NP,
  "NR": DerivationCode.NR,
  "O": DerivationCode.O,
  "RA": DerivationCode.RA,
  "RC": DerivationCode.RC,
  "RP": DerivationCode.RP,
  "RPA": DerivationCode.RPA,
  "RPI": DerivationCode.RPI,
  "T": DerivationCode.T,
  "Z": DerivationCode.Z
});

enum UnitName { G, KCAL, MG, UG, IU, K_J }

final unitNameValues = EnumValues({
  "G": UnitName.G,
  "IU": UnitName.IU,
  "KCAL": UnitName.KCAL,
  "kJ": UnitName.K_J,
  "MG": UnitName.MG,
  "UG": UnitName.UG
});

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
