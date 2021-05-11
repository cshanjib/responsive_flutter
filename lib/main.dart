import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Text("Responsive"),
          centerTitle: false,
        ),
        body: Row(
          children: [
            Expanded(
                child: Image.asset(
              "images/banner1.jpeg",
              height: 300,
              fit: BoxFit.cover,
            )),
            Expanded(
                child: Image.asset("images/banner2.jpeg",
                    height: 300, fit: BoxFit.cover)),
          ],
        ),
      )),
    );
  }
}
