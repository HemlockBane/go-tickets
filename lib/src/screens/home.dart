import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/theme.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  //HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Icon(Icons.local_airport, color: Colors.grey,),
              Text('Events', style: Theme.of(context).textTheme.caption.copyWith(color: Colors.grey),),

            ],),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              IconButton(icon: Icon(Icons.local_airport), color: Colors.grey, onPressed: (){},),
              Text('Places', style: Theme.of(context).textTheme.caption.copyWith(color: Colors.grey),),

            ],),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Icon(Icons.local_airport, color: Colors.grey,),
              Text('Profile', style: Theme.of(context).textTheme.caption.copyWith(color: Colors.grey),),

            ],),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Icon(Icons.local_airport, color: Colors.grey,),
              Text('Chat', style: Theme.of(context).textTheme.caption.copyWith(color: Colors.grey),),

            ],),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Icon(Icons.local_airport, color: isTapped ? GoTicketsTheme.darkLavender : Colors.grey,),
              Text('Tickets', style: Theme.of(context).textTheme.caption.copyWith(color: Colors.grey),),

            ],)




            ],),
        ),
      ),
    );
  }
}
