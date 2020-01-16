import 'package:flutter/material.dart';
import 'package:letsgo/screens/home/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Let's Go",
      theme: ThemeData(primarySwatch: Colors.red),
      home: MyHomePage(title: 'Lets Go clone'),
    );
  }
}