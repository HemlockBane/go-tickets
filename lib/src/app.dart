import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../src/screens/home.dart';
import '../src/screens/login.dart';
import '../src/widgets/theme.dart';
import '../src/models/models.dart';

class App extends StatelessWidget {
  UserModel userModel;

  App({Key key, @required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: userModel.initialise(),
        child: MaterialApp(
          title: 'GoTickets',
          theme: GoTicketsTheme().getAppTheme(),
          home: ScopedModelDescendant<UserModel>(builder: (context, child, userModel){
            if (userModel.isLoggedIn){
              print('app.dart, ln 23: is logged in');
              return HomeScreen();

            }else{
              print('app.dart, ln 27: is not logged in');
              return LoginScreen();
            }
          }),
          routes: <String, WidgetBuilder>{
            LoginScreen.routeName: (BuildContext context) => LoginScreen(),
            HomeScreen.routeName: (BuildContext context) => HomeScreen()
          },
        ));
  }
}
