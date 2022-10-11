class Food{
  String name;
  String calories;
  String fat;
  String protein;
  String carbohydrate;
  String sugar;
  String sodium;


  Food({required this.name, required this.calories, required this.carbohydrate,
    required this.fat, required this.protein,required this.sugar, required this.sodium,

  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
    name: json["name"],
    fat: json['fat'],
    calories: json["calories"],
    protein: json['protein'],
    carbohydrate: json['carbohydrate'],
    sugar: json['sugar'],
    sodium: json['sodium'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'calories': calories,
    'fat': fat,
    'protein': protein,
    'carbohydrate': carbohydrate,
    'sugar': sugar,
    'sodium': sodium,
  };


}
