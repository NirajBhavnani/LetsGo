import 'package:flutter/material.dart';
import 'package:letsgo/models/user.dart';
import 'package:letsgo/screens/Services/auth.dart';
import 'package:letsgo/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
          child: MaterialApp(
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}