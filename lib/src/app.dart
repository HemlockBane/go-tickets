import 'package:flutter/material.dart';
import '../src/screens/home.dart';
import '../src/screens/login.dart';
import '../src/widgets/theme.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: GoTicketsTheme().getAppTheme(),
      home: LoginScreen(),
      routes: <String, WidgetBuilder>{
        LoginScreen.routeName: (BuildContext context) => LoginScreen(),
        HomeScreen.routeName: (BuildContext context) => HomeScreen()
    },
    );
  }
}
