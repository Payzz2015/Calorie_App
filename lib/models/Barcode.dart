class Barcode{
  String name;
  String barcode;
  String calories;
  String fat;
  String protein;
  String carbohydrate;
  String sodium;
  String sugar;

  Barcode({required this.name,required this.barcode, required this.calories, required this.carbohydrate,
    required this.fat, required this.protein, required this.sodium,required this.sugar
  });

  factory Barcode.fromJson(Map<String, dynamic> json) => Barcode(
    name: json["name"],
    barcode: json["barcode"],
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
    'barcode': barcode,
    'fat': fat,
    'protein': protein,
    'carbohydrate': carbohydrate,
    'sugar': sugar,
    'sodium': sodium,
  };
}