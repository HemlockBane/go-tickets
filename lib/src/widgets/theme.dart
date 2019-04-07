import 'package:flutter/material.dart';

class GoTicketsTheme{


  static final Color darkLavender = Color(0xff8F6FA7);
  static final Color lightLavender = Color(0xffE6E0EF);
  static final Color darkGrey = Color(0xffAAAAB7);
  static final Color lightGrey = Color(0xffB4B4C2);
  static final Color darkEbonyClay = Color(0xff2F313B);
  static final Color lightEbonyClay = Color(0xff353643);




  ThemeData getAppTheme(){
    final ThemeData baseTheme = ThemeData.light();

    return baseTheme.copyWith(
      primaryColor: Colors.white,
      primaryColorLight: lightLavender,
      primaryIconTheme: IconThemeData(color: darkLavender),
      accentColor: darkGrey,
      scaffoldBackgroundColor: Colors.white,
      textTheme: baseTheme.textTheme.copyWith(
      title: baseTheme.textTheme.title.copyWith(
          fontSize: 18,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w400
      ),
        body1: baseTheme.textTheme.body1.copyWith(
          fontSize: 16,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w400
        )
      )

    );
  }
}