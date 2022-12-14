import 'package:calories_counter_project/models/Food.dart';

class Day{
  String? day;
  String? weight;
  String? carb;
  String? fat;
  String? protein;
  String? sodium;
  String? sugar;
  String? carbLeft;
  String? fatLeft;
  String? proteinLeft;
  String? caloriesLeft;
  String? caloriesEaten;
  List<Food>? breakfast;
  List<Food>? lunch;
  List<Food>? dinner;
  List<Food>? snack;

  Day({
    this.day,
    this.weight,
    this.carb,
    this.fat,
    this.protein,
    this.sodium,
    this.sugar,
    this.carbLeft,
    this.fatLeft,
    this.proteinLeft,
    this.caloriesLeft,
    this.caloriesEaten,
    this.breakfast,
    this.lunch,
    this.dinner,
    this.snack,

  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    day: json["day"],
    weight: json["weight"],
    carb: json["carb"],
    fat: json["fat"],
    protein: json["protein"],
    sodium: json["sodium"],
    sugar: json["sugar"],
    carbLeft: json["carbLeft"],
    fatLeft: json["fatLeft"],
    proteinLeft: json["proteinLeft"],
    caloriesLeft: json["caloriesLeft"],
    caloriesEaten: json["caloriesEaten"],
    breakfast: json["breakfast"] == null ? null : List<Food>.from(json["breakfast"].map((x) => Food.fromJson(x))),
    lunch: json["lunch"] == null ? null : List<Food>.from(json["lunch"].map((x) => Food.fromJson(x))),
    dinner: json["dinner"] == null ? null : List<Food>.from(json["dinner"].map((x) => Food.fromJson(x))),
    snack: json["snack"] == null ? null : List<Food>.from(json["snack"].map((x) => Food.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'day': day,
    'weight': weight,
    'carb': carb,
    'fat': fat,
    'protein': protein,
    'carbLeft': carbLeft,
    'fatLeft': fatLeft,
    'proteinLeft': proteinLeft,
    'sodium': sodium,
    'sugar': sugar,
    'caloriesLeft': caloriesLeft,
    'caloriesEaten': caloriesEaten,
    "breakfast": breakfast == null ? null : List<dynamic>.from(breakfast!.map((x) => x.toJson())),
    "lunch": breakfast == null ? null : List<dynamic>.from(lunch!.map((x) => x.toJson())),
    "dinner": breakfast == null ? null : List<dynamic>.from(dinner!.map((x) => x.toJson())),
    "snack": breakfast == null ? null : List<dynamic>.from(snack!.map((x) => x.toJson())),
  };

  factory Day.fromMap(map){
    return Day(
      day: map['day'],
      weight: map['weight'],
      carb: map['carb'],
      fat: map['fat'],
      protein: map['protein'],
      carbLeft: map['carbLeft'],
      fatLeft: map['fatLeft'],
      proteinLeft: map['proteinLeft'],
      sodium: map['sodium'],
      sugar: map['sugar'],
      caloriesLeft: map['caloriesLeft'],
      caloriesEaten: map['caloriesEaten'],
      breakfast: map['breakfast'],
      lunch: map['lunch'],
      dinner: map['dinner'],
      snack: map['snack'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'day': day,
      'weight': weight,
      'carb': carb,
      'fat': fat,
      'protein': protein,
      'carbLeft': carbLeft,
      'fatLeft': fatLeft,
      'proteinLeft': proteinLeft,
      'sodium': sodium,
      'sugar': sugar,
      'caloriesLeft': caloriesLeft,
      'caloriesEaten': caloriesEaten,
      'breakfast': breakfast,
      'lunch': lunch,
      'dinner': dinner,
      'snack': snack,
    };
  }
}