class Users{
  String? uid;
  String? email; //อีเมล
  String? name; //ชื่อ
  String? gender; //เพศ
  String? age; //อายุ
  String? weight; //น้ำหนัก
  String? height; //ส่วนสูง
  String? bmi;
  String? bmr;


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
    };
  }



}

