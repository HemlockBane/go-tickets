import 'package:flutter/material.dart';

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
            Container(
                margin: EdgeInsets.only(),
                child: Text('Go Tickets',
                  style: Theme.of(context).textTheme.body1.copyWith(
                    color: GoTicketsTheme.darkLavender, fontSize: 50),)),
            Row(
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
    return FlatButton(
      color: GoTicketsTheme.darkLavender,
      padding: EdgeInsets.all(0.0),
      child: Container(
        child: Text(
          'SIGN UP',
          style: Theme.of(context).textTheme.body1.copyWith(
              color: Colors.white,
        ),),
      ),
      onPressed: () => login(context),
    );
  }


  void login(BuildContext context){
    UserModel.signIn(context);
  }
}
