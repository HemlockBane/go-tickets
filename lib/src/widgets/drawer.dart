import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';

import 'theme.dart';
import '../screens/home.dart';
import '../screens/events.dart';
import '../screens/places.dart';
import '../screens/profile.dart';
import '../screens/chats.dart';
import '../screens/tickets.dart';

class DrawerItemData{
  IconData listTileIcon;
  String listTileString;
  bool isDrawerHeader;

  DrawerItemData({this.listTileIcon, this.listTileString, this.isDrawerHeader = false});
}


class GoTicketsAppDrawer extends StatefulWidget {
final Color selectedItemColor;
final Color unselectedItemColor;


GoTicketsAppDrawer({
  this.selectedItemColor,
  this.unselectedItemColor});

List<DrawerItemData> drawerItemDataList = [
  DrawerItemData(isDrawerHeader: true,),
  DrawerItemData(listTileIcon: FontAwesomeIcons.glassCheers, listTileString: 'Events'),
  DrawerItemData(listTileIcon: Icons.location_on, listTileString: 'Places'),
  DrawerItemData(listTileIcon: FontAwesomeIcons.user, listTileString: 'Profile'),
  DrawerItemData(listTileIcon: CupertinoIcons.conversation_bubble, listTileString: 'Chats'),
  DrawerItemData(listTileIcon: Icons.description, listTileString: 'Tickets'),
];

  @override
  _GoTicketsAppDrawerState createState() => _GoTicketsAppDrawerState();
}

class _GoTicketsAppDrawerState extends State<GoTicketsAppDrawer> {
  int _selectedDrawerItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: _drawerItems(),),
    ),);
  }

  List<Widget> _drawerItems() {
    List<Widget> itemList = List.generate(widget.drawerItemDataList.length, (int itemDataIndex) {
      return _buildTabBarItem(
          drawerItemData: widget.drawerItemDataList[itemDataIndex],
          itemIndex: itemDataIndex,
          onItemPressed: _updateSelectedItemIndex);
    });

    return itemList;
  }

  Widget _buildTabBarItem(
      {DrawerItemData drawerItemData,
        int itemIndex,
        ValueChanged<int> onItemPressed}) {
    Color itemColor = _selectedDrawerItemIndex == itemIndex
        ? widget.selectedItemColor
        : widget.unselectedItemColor;

    if(drawerItemData.isDrawerHeader){
      return UserAccountsDrawerHeader(
        accountName: Text('Obinna Igwe', style: Theme.of(context).textTheme.body1.copyWith(color: GoTicketsTheme.darkLavender),),
        accountEmail: Text('igwenus619@gmail.com', style: Theme.of(context).textTheme.body1.copyWith(color: GoTicketsTheme.lightLavender)),
        currentAccountPicture: CircleAvatar(
          backgroundColor: GoTicketsTheme.darkLavender,
          child: Text('OB'),),
      );
    }else{
      return InkWell(
        child: ListTile(
          leading: Icon(drawerItemData.listTileIcon, color: itemColor,),
          title: Text(drawerItemData.listTileString, style: Theme.of(context).textTheme.body1.copyWith(color: itemColor),),),
        onTap: (){
          onItemPressed(itemIndex);
        },
      );

    }

  }

  _updateSelectedItemIndex(int newSelectedItemIndex) {
    setState(() {
      _selectedDrawerItemIndex = newSelectedItemIndex;

    });
  }








}
