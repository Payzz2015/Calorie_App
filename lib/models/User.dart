class Users{
  String? uid;
  String? email;
  String? name;
  String? gender;
  String? age;
  String? weight;
  String? height;
  String? bmi;
  String? bmr;
  String? tdee;
  String? active;

  Users({
    this.uid,
    this.email,
    this.name,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.bmi,
    this.bmr,
    this.tdee,
    this.active
  });

  factory Users.fromMap(map){
    return Users(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      gender: map['gender'],
      age: map['age'],
      weight: map['weight'],
      height: map['height'],
      bmi: map['bmi'],
      bmr: map['bmr'],
      tdee: map['tdee'],
      active: map['active']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'gender': gender,
      'age': age,
      'weight': weight,
      'height': height,
      'bmi': bmi,
      'bmr': bmr,
      'tdee': tdee,
      'active': active,
    };
  }



}

