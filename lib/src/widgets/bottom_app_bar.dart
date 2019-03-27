import 'package:flutter/material.dart';

class BottomAppBarItemData {
  IconData iconData;
  String iconText;

  BottomAppBarItemData({this.iconData, this.iconText});
}

class GoTicketsBottomAppBar extends StatefulWidget {
  final List<BottomAppBarItemData> bottomAppBarItemData;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final ValueChanged<int> onItemSelected;

  GoTicketsBottomAppBar(
      {this.bottomAppBarItemData,
      this.unselectedItemColor,
      this.selectedItemColor,
      this.onItemSelected});
  @override
  _GoTicketsBottomAppBarState createState() => _GoTicketsBottomAppBarState();
}

class _GoTicketsBottomAppBarState extends State<GoTicketsBottomAppBar> {
  int _selectedItemIndex = 0;

  _updateSelectedItemIndex(int newSelectedItemIndex) {
    setState(() {
      _selectedItemIndex = newSelectedItemIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _bottomAppBarItems(),
        ),
      ),
    );
  }

  List<Widget> _bottomAppBarItems() {
    List<Widget> itemList = List.generate(widget.bottomAppBarItemData.length, (int itemDataIndex) {
      return _buildTabBarItem(
          appBarItemData: widget.bottomAppBarItemData[itemDataIndex],
          itemIndex: itemDataIndex,
          onItemPressed: _updateSelectedItemIndex);
    });

    return itemList;
  }

  Widget _buildTabBarItem(
      {BottomAppBarItemData appBarItemData,
      int itemIndex,
      ValueChanged<int> onItemPressed}) {
    Color itemColor = _selectedItemIndex == itemIndex
        ? widget.selectedItemColor
        : widget.unselectedItemColor;

    return Material(
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(appBarItemData.iconData, color: itemColor,),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Text(appBarItemData.iconText,
                style: Theme.of(context).textTheme.caption.copyWith(color: itemColor),),
            ),
          ],
        ),
        onTap: (){
          onItemPressed(itemIndex);
          },
      ),
    );
  }
}
