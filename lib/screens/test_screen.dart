import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {


  File? _image;
  Uint8List? bytes;
  String? _image64;
  List<String> images = [];

  Future<void> getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    //source: ImageSource.gallery เป็นเมธอดนำภาพจาก gallery ใน mobile
    //source: ImageSource.camera เป็นเมธอดนำภาพจาก การถ่ายภาพ
    String url = "https://api.aiforthai.in.th/thaifood/";


    final String key = "Q1QV7QmKhx2bxfAmDrlf6k625js1DRuv";
    var postUri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", postUri);
    request.headers["Content-type"] = "application/json";
    request.headers["Apikey"] = key;
    bytes = File(image!.path).readAsBytesSync();
    _image64 = base64Encode(bytes!);
    images.add(_image64!);

    request.files.add(
      await http.MultipartFile.fromPath(
      'file',
      _image64!,
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
