import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';


import '../widgets/bottom_app_bar.dart';
import '../widgets/theme.dart';
import '../screens/events.dart';
import '../screens/places.dart';
import '../screens/profile.dart';
import '../screens/chats.dart';
import '../screens/tickets.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static List<String>bottomAppBarTextList = [
    'Events',
    'Places',
    'Profile',
    'Chats',
    'Tickets'
  ];
  static String appBarTitle = bottomAppBarTextList[0];

  static List<Widget>pageList = [
    EventsScreen(),
    PlacesScreen(),
    ProfileScreen(),
    ChatsScreen(),
    TicketsScreen()
  ];
  Widget _currentPage = pageList[0];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(appBarTitle,
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
        onItemSelected: _updateScreenDetails,
        bottomAppBarItemData: [
          BottomAppBarItemData(iconData: FontAwesomeIcons.glassCheers, iconText: bottomAppBarTextList[0]),
          BottomAppBarItemData(iconData: Icons.location_on, iconText: bottomAppBarTextList[1]),
          BottomAppBarItemData(iconData: FontAwesomeIcons.user, iconText: bottomAppBarTextList[2]),
          BottomAppBarItemData(iconData: CupertinoIcons.conversation_bubble, iconText: bottomAppBarTextList[3]),
          BottomAppBarItemData(iconData: Icons.description, iconText: bottomAppBarTextList[4])
        ],),
      body: _currentPage,
    );
  }

  void _updateScreenDetails(int selectedItemIndex){
    setState(() {
      appBarTitle = bottomAppBarTextList[selectedItemIndex];
      _currentPage = pageList[selectedItemIndex];

    });
  }

  void updateChatAppBarTitle(String newAppBarTitle){
    setState(() {
      appBarTitle = newAppBarTitle;
    });

  }

}