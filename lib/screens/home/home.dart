import 'package:flutter/material.dart';
import 'package:letsgo/screens/Services/auth.dart';
import 'package:letsgo/screens/about.dart';
import 'package:letsgo/screens/profile.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
      backgroundColor: Colors.red[400],
      title: Text("Let's Go"),
      elevation: 0.0,
      actions: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.person),
          label: Text('Logout'),
          onPressed: () async {
            await _auth.signOut();
          },
        )
      ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Sanjay Shamnani'),
              accountEmail: Text('sanjay@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("http://i.pravatar.cc/300"),
              ),
              decoration: BoxDecoration(color: Colors.black87),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new ProfilePage()));
              },
            ),
            Divider(),
            ListTile(
                title: Text('About Us'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new AboutPage()));
                }),
          ],
        ),
      ),
    );
  }
}