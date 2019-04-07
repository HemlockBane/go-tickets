import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/home.dart';

class UserModel extends Model {
  GoogleSignInAccount _currentUser;
  GoogleSignIn _googleSignIn;

  FirebaseAuth _firebaseAuth;
  FirebaseUser _firebaseUser;

  Profile profile;

  bool get isSignedIn {
    print('models.dart, ln 21: Is signed in - ${_firebaseUser != null}');
    return _firebaseUser != null;
  }

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context, rebuildOnChange: true);

  initialise() {
    _googleSignIn = GoogleSignIn();
    _firebaseAuth = FirebaseAuth.instance;

    return this;
  }

  _loadUserData({FirebaseUser firebaseUser}) {
    if (isSignedIn) {
      profile = Profile.initialise(
          displayName: firebaseUser.displayName,
          email: firebaseUser.email,
          profilePictureUrl: firebaseUser.photoUrl,
          notifyListeners: notifyListeners);

      //print('models.dart, ln 43: ${profile.toString()}');
    }
  }

  Future<FirebaseUser> signIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    _firebaseUser = await _firebaseAuth.signInWithCredential(authCredential);
    _loadUserData(firebaseUser: _firebaseUser);

    if (_firebaseUser != null) {
      // Check if user is registered
      final QuerySnapshot result = await Firestore.instance
          .collection('users')
          .where('id', isEqualTo: _firebaseUser.uid)
          .getDocuments();

      final List<DocumentSnapshot> documents = result.documents;

      // Register the user if they are not registered
      if (documents.length == 0) {
        Firestore.instance
            .collection('users')
            .document(_firebaseUser.uid)
            .setData({
          'username': _firebaseUser.displayName,
          'photoUrl': _firebaseUser.photoUrl,
          'id': _firebaseUser.uid
        });
      }
    }

    notifyListeners();
    return _firebaseUser;
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
    return 'Profile is: $displayName - $email';
  }
}
