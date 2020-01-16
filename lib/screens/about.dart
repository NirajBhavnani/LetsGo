import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Text(
          'AboutPage',
          style: TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}
