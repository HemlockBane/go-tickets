import 'package:flutter/material.dart';

import 'package:go_tickets/src/widgets/theme.dart';

class ChatDetailsScreen extends StatefulWidget {
  final String recipientName;

  ChatDetailsScreen({this.recipientName});
  @override
  _ChatDetailsScreenState createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.recipientName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title.copyWith(
                  color: Colors.black)),
        ),
        leading: IconButton(icon: Icon(Icons.menu, color: GoTicketsTheme.darkLavender,), onPressed: () {}),
        actions: <Widget>[Container(
          width: 30,
          height: 30,
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(shape: BoxShape.circle, color: GoTicketsTheme.darkGrey),)],
      ),
    );
  }
}
