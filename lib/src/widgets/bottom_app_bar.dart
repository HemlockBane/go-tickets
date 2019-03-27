import 'package:flutter/material.dart';

class BottomAppBarData {
  IconData iconData;
  String iconText;

  BottomAppBarData({this.iconData, this.iconText});
}

class GoTicketsBottomAppBar extends StatefulWidget {
  final List<BottomAppBarData> bottomAppBarItemData;
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

  _updateSelectedItemIndex(int newSelectedItemIndex){
    setState(() {
      _selectedItemIndex = newSelectedItemIndex;
    });
  }


  @override
  Widget build(BuildContext context) {

//    List<Widget> bottomAppBarItems = List.generate(widget.bottomAppBarItemData.length, );
    return Container();
  }
}
