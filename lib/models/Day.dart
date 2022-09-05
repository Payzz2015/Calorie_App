import 'package:calories_counter_project/models/Barcode.dart';
import 'package:calories_counter_project/models/Food.dart';

class Day{
  DateTime? day;
  int? calories;
  List<Food>? breakfast;
  List<Food>? lunch;
  List<Food>? dinner;
  List<Barcode>? snack;

  Day({
    this.day,
    this.calories,
    this.breakfast,
    this.lunch,
    this.dinner,
    this.snack,

  });

  factory Day.fromMap(map){
    return Day(
      day: map['day'],
      calories: map['calories'],
      breakfast: map['breakfast'],
      lunch: map['lunch'],
      dinner: map['dinner'],
      snack: map['snack'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'day': day,
      'calories': calories,
      'breakfast': breakfast,
      'lunch': lunch,
      'dinner': dinner,
      'snack': snack,
    };
  }
}