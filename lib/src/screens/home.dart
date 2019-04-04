import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';


import '../widgets/bottom_app_bar.dart';
import '../widgets/theme.dart';
import '../widgets/drawer.dart';
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

  static int _selectedDrawerItemIndex = 1; // ListTile items index begin from 1
  static int _selectedBottomBarItemIndex = _selectedDrawerItemIndex - 1;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GoTicketsAppDrawer(
        selectedItemColor: GoTicketsTheme.darkLavender,
        unselectedItemColor: GoTicketsTheme.darkGrey,
        selectedDrawerItemIndex: _selectedDrawerItemIndex,
      onDrawerItemPressed: _handleDrawerItemPressed,),
      appBar: AppBar(
        title: Center(
            child: Text(appBarTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.title.copyWith(
              color: Colors.black),
        )),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search,), onPressed: () {})
        ],
      ),
      bottomNavigationBar: GoTicketsBottomAppBar(
        selectedItemColor: GoTicketsTheme.darkLavender,
        selectedItemIndex: _selectedBottomBarItemIndex,
        unselectedItemColor: GoTicketsTheme.darkGrey,
        onItemSelected: _handleBottomBarItemPressed,
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

  void _handleBottomBarItemPressed(int newSelectedItemIndex){
    setState(() {
      _selectedBottomBarItemIndex = newSelectedItemIndex;
      _selectedDrawerItemIndex = _selectedBottomBarItemIndex + 1;

      appBarTitle = bottomAppBarTextList[newSelectedItemIndex];
      _currentPage = pageList[newSelectedItemIndex];



    });
  }

  void updateChatAppBarTitle(String newAppBarTitle){
    setState(() {
      appBarTitle = newAppBarTitle;
    });

  }

  _handleDrawerItemPressed(int newSelectedItemIndex) {
    setState(() {
      // Update selected drawer item index
      _selectedDrawerItemIndex = newSelectedItemIndex;
      // Update selected bottom bar item index
      _selectedBottomBarItemIndex = _selectedDrawerItemIndex - 1; // bottom bar item indices and pageList item indices are behind drawer item indices by 1

      // Update selected page in home screen
      _currentPage = pageList[_selectedBottomBarItemIndex];

    });
  }


}