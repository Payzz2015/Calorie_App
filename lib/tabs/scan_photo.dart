import 'dart:io';
import 'package:calories_counter_project/screens/details/detail_food.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';

class ScanPhoto extends StatefulWidget {
  const ScanPhoto({Key? key}) : super(key: key);

  @override
  State<ScanPhoto> createState() => _ScanPhotoState();
}

class _ScanPhotoState extends State<ScanPhoto> {
  File? pickedImage;
  bool _loading = false;
  List? _result;
  final _imagePicker = ImagePicker();

  String name = "";

  late Stream<QuerySnapshot> collectionStream = FirebaseFirestore.instance.collection('recognition').snapshots();


  @override
  void initState(){
    super.initState();
    _loading = true;


    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/models/model_unquant.tflite",
        labels: "assets/models/labels.txt");
  }

  getImageGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    //source: ImageSource.gallery เป็นเมธอดนำภาพจาก gallery ใน mobile
    //source: ImageSource.camera เป็นเมธอดนำภาพจาก การถ่ายภาพ
    if (image == null) return null;
    setState(() {
      _loading = true;
      pickedImage = File(image.path);
    });
    classifyImage(pickedImage!);
  }

  getImageCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _loading = true;
      pickedImage = File(image.path);
    });
    classifyImage(pickedImage!);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageStd: 127.5,
      imageMean: 127.5,
    );

    setState(() {
      _loading = false;
      _result = output;
      name = _result![0]["label"];
      print(_result![0]["confidence"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                _loading
                    ? Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
                    : Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      pickedImage == null
                          ? Container()
                          : Container(
                        child: Image.file(pickedImage!),
                        height: 350,
                        width: MediaQuery.of(context).size.width * 0.9,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _result != null
                          ? Column(
                        children: [
                          Text(
                            "${_result![0]["label"]}"
                                .replaceAll(RegExp(r'[0-9]'), ''),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                background: Paint()
                                  ..color = Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          StreamBuilder(
                              stream: collectionStream,
                              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                                if (!snapshot.hasData) {
                                  return Text("Loading");
                                }
                                  return Column(
                                    children: [
                                      ListView(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: snapshot.data!.docs.map((QueryDocumentSnapshot document) {
                                          final dynamic data = document.data();
                                          if(document["name"].toString().toLowerCase().startsWith(name.toLowerCase())){
                                            return GestureDetector(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                                  return DetailFood(name: data["name"].toString(), calories: data["calories"].toString(),sugar: data["sugars"].toString(), fat: data["fat"].toString(), carbohydrate: data["carbohydrate"].toString(), protein: data["protein"].toString(), sodium: data["sodium"].toString());
                                                }));
                                              },
                                              child: Card(
                                                elevation: 1,
                                                child: ListTile(
                                                  title: Padding(
                                                    padding: EdgeInsets.fromLTRB(10, 4, 0, 0),
                                                    child: Text(
                                                      document["name"],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                      textScaleFactor: 1,
                                                    ),
                                                  ),
                                                  trailing: Text(
                                                    "${document["calories"]} kcal",
                                                    style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    textScaleFactor: 1,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          return Container();
                                        }).toList(),
                                      ),
                                      SizedBox(height: 150,),
                                    ],
                                  );
                              }
                          ),
                        ],
                      )
                          : Container(
                        child: Center(
                          child: Text(
                            "เพิ่มรูปภาพ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textScaleFactor: 1.0,
                          ),
                        ),
                        height: 350,
                        width: MediaQuery.of(context).size.width * 0.9,
                        color: Colors.black,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 1,
                onPressed: getImageCamera,
                child: Icon(Icons.camera_alt_rounded),
                backgroundColor: Color(0xFF5fb27c),
              ),
              SizedBox(width: 15,),
              FloatingActionButton(
                heroTag: 2,
                onPressed: getImageGallery,
                child: Icon(Icons.photo_album_rounded),
                backgroundColor: Color(0xFF5fb27c),
              ),
            ],
          ),
        )
    );
  }
}
