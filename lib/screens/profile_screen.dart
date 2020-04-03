import 'dart:io';

import 'package:flutter/material.dart';
import '../widgets/custom_text_form_field.dart';

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
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Hello Sanjay !",
                    style:
                        TextStyle(fontSize: 26.0)
                  ),
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                        "https://pbs.twimg.com/profile_images/1214214436283568128/KyumFmOO.jpg"),
                  )
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              CustomTextFormField(
                hintText: "Name",
                value: "Sanjay Shamnani",
              ),
              SizedBox(
                height: 15.0,
              ),
              CustomTextFormField(
                hintText: "Email",
                value: "sanjay@gmail.com",
                suffixIcon: Icon(
                  Icons.check_circle,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              CustomTextFormField(
                hintText: "Phone Number",
                value: "9856321470",
              ),
              ButtonTheme(
                minWidth: double.infinity,
                height: 60.0,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    'Update Details',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  textColor: Colors.white,
                  color: Colors.red,
                ),
              ),
            ]
          ),
        ),
      ));
  }
}