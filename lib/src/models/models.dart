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

  User user;
  bool _isConnecting = false;

  bool get hasFirebaseUser {
    return _firebaseUser != null;
  }

  bool get isConnecting{
    return _isConnecting;
  }

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context, rebuildOnChange: true);

  initialise() {
    _googleSignIn = GoogleSignIn();
    _firebaseAuth = FirebaseAuth.instance;

    _firebaseAuth.onAuthStateChanged.listen((firebaseUser){
      _firebaseUser = firebaseUser;
      if(_firebaseUser != null){
        loadUserData(firebaseUser: firebaseUser);
      }
    });


    return this;
  }

  loadUserData({FirebaseUser firebaseUser}) {
    if (hasFirebaseUser) {
      user = User.initialise(
          displayName: firebaseUser.displayName,
          email: firebaseUser.email,
          profilePictureUrl: firebaseUser.photoUrl,
          id: firebaseUser.uid,
          notifyListeners: notifyListeners);

    }
  }

  _connecting({bool isConnecting = true}){
    _isConnecting = isConnecting;
    notifyListeners();
  }


  Future<FirebaseUser> signIn() async {
    _connecting();

    try{
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      _firebaseUser = await _firebaseAuth.signInWithCredential(authCredential);
      loadUserData(firebaseUser: _firebaseUser);
    }catch(error){
      _connecting(isConnecting: false);
      print('models.dart: ln 73 : error signing in: $error');
    }


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

class User {
  String id = '';
  String displayName = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String profilePictureUrl = '';
  Function notifyListeners;


  User.create({this.displayName, this.id, this.profilePictureUrl});

  User.initialise(
      {this.id,
      this.displayName,
      this.firstName,
      this.lastName,
      this.email,
      this.profilePictureUrl,
      this.notifyListeners}) {
    notifyListeners();
  }

  User.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}){
    displayName = documentSnapshot['username'];
    id = documentSnapshot['id'];
    profilePictureUrl = documentSnapshot['photoUrl'];
  }

  @override
  String toString() {
    return 'User is: $displayName - $email - $id';
  }
}
