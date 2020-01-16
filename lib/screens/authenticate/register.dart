import 'package:flutter/material.dart';
import 'package:letsgo/screens/Services/auth.dart';
import 'package:letsgo/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

final _formRegKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();
String error='';
bool loading = false;

final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(backgroundColor: Colors.red[400],
      elevation: 0.0,
      title: Text('Sign Up'),
      actions: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.person),
          label: Text('Sign In'),
          onPressed: (){
            widget.toggleView();
          },
        )
      ],
      
      ),
      body: Form(
        key: _formRegKey,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  style: textStyle,
                  controller: emailController,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Please enter your email';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Input email',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  obscureText: true,
                  style: textStyle,
                  controller: passController,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Please enter the password';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Input password',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 10.0, right: 80.0, left: 80.0),
                child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      'Register',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () async{
                     if(_formRegKey.currentState.validate()){
                       setState(() => loading = true);
                       dynamic result = await _auth.regWithEmailAndPass(emailController.text, passController.text);
                       if(result == null){
                         setState(() {
                           error = 'Please supply a valid email';
                           loading=false;
                         });
                       }
                     }
                    }),
              ),
              SizedBox(
                height: 12.0,
              ),
              Center(child: Text(
                error,
                style: TextStyle(color: Colors.blue, fontSize: 14.0),
              ),
              ),
              
          ],),
        ),
        )
    );
  }
}