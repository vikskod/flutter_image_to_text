import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _image;
  String _text="";

  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  //For now just doing for android
  static const platform = const MethodChannel("myAppChannel");

  Future getDetectedText() async {
    _text = "";
    String result;
    try {
      var map1 = {"data": _image.path};
      result = await platform.invokeMethod("method", map1);
    } on PlatformException catch (e) {
      result = "Error: ${e.message}";
    }
    setState(() {
      _text = result;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image to Text"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _image == null
                  ? Image.asset(
                      "images/img_banner.png",
                      height: 300,
                    )
                  : Image.file(
                      _image,
                      height: 300,
                    ),
              RaisedButton(
                onPressed: () async {
                  if (await Permission.storage.request().isGranted) {
                  // Either the permission was already granted before or the user just granted it.
                  print("Storate permission Granted ================= TRUE");
                  getImage();
                  }
                },
                color: Colors.blue,
                child: Text(
                  "Select Image",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  getDetectedText();
                },
                color: Colors.green,
                child: Text(
                  "Extract Text",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Text("Extracted Text:",
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              SelectableText(
                _text,
                style: TextStyle(color: Colors.black54, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
