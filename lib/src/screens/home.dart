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

  static List<String>bottomAppBarTextList = [
    'Events',
    'Places',
    'Profile',
    'Chats',
    'Tickets'
  ];

  String _appBarTitle = bottomAppBarTextList[0];

  void _updateAppBarTitle(int selectedItemIndex ){
    setState(() {
      _appBarTitle = bottomAppBarTextList[selectedItemIndex];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(_appBarTitle,
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
        onItemSelected: _updateAppBarTitle,
        bottomAppBarItemData: [
          BottomAppBarItemData(iconData: Icons.party_mode, iconText: bottomAppBarTextList[0]),
          BottomAppBarItemData(iconData: Icons.location_on, iconText: bottomAppBarTextList[1]),
          BottomAppBarItemData(iconData: FontAwesomeIcons.user, iconText: bottomAppBarTextList[2]),
          BottomAppBarItemData(iconData: Icons.message, iconText: bottomAppBarTextList[3]),
          BottomAppBarItemData(iconData: Icons.party_mode, iconText: bottomAppBarTextList[4])
        ],),
    );
  }
}
