import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Text(
          'ProfilePage',
          style: TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}
