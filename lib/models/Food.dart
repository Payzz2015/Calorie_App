class Food{
  String name;
  String calories;
  String fat;
  String protein;
  String carbohydrate;
  String sodium;
  //String mealTime;
  //String createdOn;

  Food({required this.name, required this.calories, required this.carbohydrate,
    required this.fat, required this.protein, required this.sodium,
    //required this.createdOn,required this.mealTime
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
    name: json["name"],
    fat: json['fat'],
    calories: json["calories"],
    protein: json['protein'],
    carbohydrate: json['carbohydrate'],
    sodium: json['sodium'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'calories': calories,
    'fat': fat,
    'protein': protein,
    'carbohydrate': carbohydrate,
    'sodium': sodium,
  };


 /* factory Food.fromMap(map){
    return Food(
      name: map['name'],
      calories: map['calories'],
      fat: map['fat'],
      protein: map['protein'],
      carbohydrate: map['carbohydrate'],
      sodium: map['sodium'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'calories': calories,
      'fat': fat,
      'protein': protein,
      'carbohydrate': carbohydrate,
      'sodium': sodium,
    };
  }*/

}
