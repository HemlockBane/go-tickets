import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/bottom_app_bar.dart';
import '../widgets/theme.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List titleList = ['ALL', 'FAVORITE', 'MAP'];

  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Places',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.title.copyWith(
              color: Colors.black),
        )),
        leading: IconButton(icon: Icon(Icons.menu, color: GoTicketsTheme.darkLavender,), onPressed: () {}),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search, color: GoTicketsTheme.darkLavender,), onPressed: () {})
        ],
      ),
      bottomNavigationBar: GoTicketsBottomAppBar(
        selectedItemColor: GoTicketsTheme.darkLavender,
        unselectedItemColor: GoTicketsTheme.darkGrey,
        bottomAppBarItemData: [
          BottomAppBarItemData(iconData: Icons.party_mode, iconText: 'Events'),
          BottomAppBarItemData(iconData: Icons.party_mode, iconText: 'Events')
        ],),
    );
  }
}
