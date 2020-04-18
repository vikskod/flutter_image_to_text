import 'package:flutter/material.dart';

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
              Image.asset(
                "images/img_banner.png",
                height: 250,
              ),
              RaisedButton(
                onPressed: () {},
                color: Colors.blue,
                child: Text(
                  "Select Image",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              RaisedButton(
                onPressed: () {},
                color: Colors.green,
                child: Text(
                  "Extract Text",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Text("Extracted Text:", style: TextStyle(color: Colors.black, fontSize: 20)),
              SelectableText("Test...", style: TextStyle(color: Colors.black54, fontSize: 16),)
            ],
          ),
        ),
      ),
    );
  }
}
