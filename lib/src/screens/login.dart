import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/theme.dart';
import '../models/models.dart';

class LoginScreen extends StatefulWidget {
  static final routeName = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(height: MediaQuery.of(context).size.width * 0.7,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(),
                    child: Text('Go Tickets',
                      style: Theme.of(context).textTheme.body1.copyWith(
                        color: GoTicketsTheme.darkLavender, fontSize: 50),)),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _loginButton(),
              ],
            )


          ],
        ),
      ),
    );
  }

  Widget _loginButton(){
    return Container(
      child: MaterialButton(
        color: GoTicketsTheme.darkLavender,
        padding: EdgeInsets.all(0.0),
        child: ScopedModelDescendant<UserModel>(
            builder: (context, widget, userModel){
              if(userModel.isConnecting){
                return CircularProgressIndicator();
              }else{
                return Container(
                  height: 55.0,
                  child: Center(
                    child: Text(
                      'SIGN UP',
                      style: Theme.of(context).textTheme.body1.copyWith(
                        color: Colors.white,
                      ),),
                  ),
                );
              }
            }),
        onPressed: () => login(context),
      ),
    );
  }


  void login(BuildContext context){
    UserModel.of(context).signIn().then((FirebaseUser firebaseUser){
    }).catchError((error){
      print('login.dart, ln 79: Login error - $error');
    });
  }
}
