import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../screens/home.dart';

class UserModel extends Model {
  GoogleSignInAccount _currentUser;
  GoogleSignIn _googleSignIn;
  Profile profile;
  bool _isLoggedIn = false;

  bool get isLoggedIn {
    _googleSignIn.isSignedIn().then((value){
      _isLoggedIn = value;
    });
    return _isLoggedIn;
  }



  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context, rebuildOnChange: true);

  initialise() {
    _googleSignIn = GoogleSignIn(scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ]);


    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      _currentUser = account;

      if (_currentUser != null) {
        print('authenticated');
      }
      if (_currentUser == null) {
        print('unauthenticated');
      }

      _googleSignIn.signInSilently();
      notifyListeners();
    });
    return this;
  }


  _loadProfileData(){

    if(isLoggedIn){
      var userDetails = _currentUser;
      profile = Profile.initialise(
          id: userDetails.id,
          displayName: userDetails.displayName,
          email: userDetails.email,
          profilePictureUrl: userDetails.photoUrl,
          notifyListeners: notifyListeners);

      print(profile.toString());
    }
  }

  Future signIn() async {
    await _googleSignIn.signIn();
    _currentUser = _googleSignIn.currentUser;

    if(_currentUser != null){
      _currentUser.authentication.then((authentication){
        _loadProfileData();
      });

    }
    //notifyListeners();

  }
}

class Profile {
  String id = '';
  String displayName = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String profilePictureUrl = '';
  Function notifyListeners;

  Profile.initialise(
      {this.id,
      this.displayName,
      this.firstName,
      this.lastName,
      this.email,
      this.profilePictureUrl,
      this.notifyListeners}) {
    notifyListeners();
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Profile is: $displayName - $email';
  }
}
