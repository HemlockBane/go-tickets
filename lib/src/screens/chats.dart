import 'package:flutter/material.dart';

import '../models/chat.dart';
import '../screens/home.dart';
import '../widgets/theme.dart';
import './chats/chat_details.dart';

class ChatsScreen extends StatefulWidget {

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {

  @override
  Widget build(BuildContext context) {
    var chatList = ChatHelper.chats();
    return Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount: chatList.length,
            itemBuilder: (context, rowIterator) {
              var chatItem = chatList[rowIterator];

            return chatListTile(
                name: chatItem.recipientName,
                lastMessage: chatItem.mostRecentMessage,
                lastMessageDate: chatItem.mostRecentMessageDate);
            }));
  }

  Widget chatListTile({String name, String lastMessage, String lastMessageDate}){
    return Container(
      padding: EdgeInsets.all(6.0),
      margin: EdgeInsets.only(top: 5.0, bottom: 13.0),
      child: InkWell(
        onTap: (){
          _onTapListTile(context: context, recipientName: name);
        } ,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Container(padding: EdgeInsets.all(5.0),
              child: CircleAvatar()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                Text(name),
                Text(lastMessageDate)
              ],
              ),
              Text(lastMessage)
          ],),
        ],),
      ),
    );
  }

  void _onTapListTile({BuildContext context, String recipientName}){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => ChatDetailsScreen(recipientName: recipientName,)));
  }
}

