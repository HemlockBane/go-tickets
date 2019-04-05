import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


import '../screens/home.dart';

class UserModel {
  static GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);
  GoogleSignInAccount _currentUser;

   static Future<void> signIn(BuildContext context) async {
    try {
      await _googleSignIn.signIn();
      _googleSignIn.signIn();
      print('Signed in ${_googleSignIn.currentUser}');
      if (_googleSignIn.currentUser != null) {
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      }
    } catch (error) {
      print('Sign in error is $error');
    }
  }

}

class Profile {
  int id = 0;
  String firstName = '';
  String lastName = '';
  String email = '';
  String profilePictureUrl = '';
}

