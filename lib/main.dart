import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './src/app.dart';
import './src/models/models.dart';

void main() {
  //debugPaintSizeEnabled = true;
  runApp(App(userModel: UserModel(),));
}
