import 'package:flutter/material.dart';
import 'package:letsgo/models/user.dart';
import 'package:letsgo/screens/authenticate/authenticate.dart';
import 'package:letsgo/screens/home/homepage.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    //return either Home or Authenticate widget
    if(user == null){
      return Authenticate();
    }
    else{
      return MyHomePage();
    }
  }
}