import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'theme.dart';
import '../models/models.dart';
import '../widgets/formatter.dart';

class DrawerItemData {
  IconData listTileIcon;
  String listTileString;
  bool isDrawerHeader;

  DrawerItemData(
      {this.listTileIcon, this.listTileString, this.isDrawerHeader = false});
}

class GoTicketsAppDrawer extends StatefulWidget {
  final Color selectedItemColor;
  final Color unselectedItemColor;
  int selectedDrawerItemIndex;
  ValueChanged<int> onDrawerItemPressed;

  GoTicketsAppDrawer(
      {this.selectedItemColor,
      this.unselectedItemColor,
      this.selectedDrawerItemIndex,
      this.onDrawerItemPressed});

  List<DrawerItemData> drawerItemDataList = [
    DrawerItemData(
      isDrawerHeader: true,
    ),
    DrawerItemData(
        listTileIcon: FontAwesomeIcons.glassCheers, listTileString: 'Events'),
    DrawerItemData(listTileIcon: Icons.location_on, listTileString: 'Places'),
    DrawerItemData(
        listTileIcon: FontAwesomeIcons.user, listTileString: 'Profile'),
    DrawerItemData(
        listTileIcon: CupertinoIcons.conversation_bubble,
        listTileString: 'Chats'),
    DrawerItemData(listTileIcon: Icons.description, listTileString: 'Tickets'),
  ];

  @override
  _GoTicketsAppDrawerState createState() => _GoTicketsAppDrawerState();
}

class _GoTicketsAppDrawerState extends State<GoTicketsAppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: _drawerItems(),
        ),
      ),
    );
  }

  List<Widget> _drawerItems() {
    List<Widget> itemList =
        List.generate(widget.drawerItemDataList.length, (int itemDataIndex) {
      return _buildTabBarItem(
          drawerItemData: widget.drawerItemDataList[itemDataIndex],
          itemIndex: itemDataIndex,
          onDrawerItemPressed: widget.onDrawerItemPressed);
    });

    return itemList;
  }

  Widget _buildTabBarItem(
      {DrawerItemData drawerItemData,
      int itemIndex,
      ValueChanged<int> onDrawerItemPressed}) {
    Color itemColor = widget.selectedDrawerItemIndex == itemIndex
        ? widget.selectedItemColor
        : widget.unselectedItemColor;
    if (drawerItemData.isDrawerHeader) {
      return Container(
        child: ScopedModelDescendant<UserModel>(
            builder: (context, widget, userModel) {
          return UserAccountsDrawerHeader(
            accountName: Text(
              userModel.user.displayName,
              style: Theme.of(context).textTheme.body1.copyWith(color: GoTicketsTheme.darkLavender),
            ),
            accountEmail: Text(
              userModel.user.email,
              style: Theme.of(context).textTheme.body1.copyWith(color: GoTicketsTheme.darkGrey),
            ),
            currentAccountPicture: _getCircleAvatar(userModel.user),
          );
        }),
      );
    } else {
      return InkWell(
        child: ListTile(
          leading: Icon(
            drawerItemData.listTileIcon,
            color: itemColor,
          ),
          title: Text(
            drawerItemData.listTileString,
            style: Theme.of(context).textTheme.body1.copyWith(color: itemColor),
          ),
        ),
        onTap: () {
          onDrawerItemPressed(itemIndex);
        },
      );
    }
  }


  Widget _getCircleAvatar(User userAccount) {
    if(userAccount.profilePictureUrl != '' && userAccount.profilePictureUrl != ' '){
      return CircleAvatar(
        backgroundImage:
        CachedNetworkImageProvider(userAccount.profilePictureUrl),
      );
    }else{
      return Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle, color: GoTicketsTheme.darkGrey,
        ),
        child: Center(
          child: Text(getPlaceholderInitials(userAccount.displayName), style: TextStyle(color: Colors.white),),
        ),
      );
    }

  }


//  String _getImagePlaceholderInitials(String userName){
//
//    String chatPeerName = userName;
//    List nameList = chatPeerName.split(' ');
//
//    String name = nameList[0];
//    String surname = nameList[1];
//
//    return name.substring(0, 1) + surname.substring(0, 1);
//  }
}
