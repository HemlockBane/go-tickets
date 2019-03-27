import 'package:flutter/material.dart';

class GoTicketsTheme{


  static final Color darkLavender = Color(0xFF8F6FA7);
  static final Color lightLavender = Color(0xFF9876B1);
  static final Color darkGrey = Color(0xFFAAAAB7);
  static final Color lightGrey = Color(0xFFB4B4C2);
  static final Color darkEbonyClay = Color(0xFF2F313B);
  static final Color lightEbonyClay = Color(0xFF353643);




  ThemeData getAppTheme(){
    final ThemeData baseTheme = ThemeData.light();

    return baseTheme.copyWith(
      primaryColor: Colors.white,
      primaryColorLight: lightLavender,
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