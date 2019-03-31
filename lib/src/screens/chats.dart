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
    var chatPreviewList = ChatPreviewHelper.chatPreviews();
    return Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount: chatPreviewList.length,
            itemBuilder: (context, rowIterator) {
              var chatSnippet = chatPreviewList[rowIterator];

              Color color;
              color = _setOnlineIndicatorColor(colorCode: chatSnippet.isAvailable);

              return chatPreviewListTile(
                name: chatSnippet.peer,
                lastMessage: chatSnippet.mostRecentMessage,
                lastMessageDate: chatSnippet.mostRecentMessageDate,
                color: color);
            }));
  }

  Color _setOnlineIndicatorColor({int colorCode}){
    Color color;
    switch(colorCode){
      case 0:
        color = Colors.green;
            break;
      case 1:
        color = Colors.yellow.shade600;
        break;
      case 2:
        color = Colors.grey.shade300;
        break;
      case 3:
        color = Colors.red;
        break;
    }

    return color;
  }

  Widget chatPreviewListTile({String name, String lastMessage, String lastMessageDate, Color color}){
    return Container(
      padding: EdgeInsets.all(6.0),
      margin: EdgeInsets.only(top: 11.0, bottom: 16.0, left: 4),
      child: InkWell(
        onTap: (){
          _onTapListTile(context: context, recipientName: name);
        } ,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Stack(children: <Widget>[
            Container(//padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(right: 10),
              child: CircleAvatar()),
            Positioned(right: 12.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.all(Radius.circular(6))),),
                    Positioned(top: 1.8, right: 1.8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(4))),),
                    )

                  ],
                ))
            
          ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width/1.25,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Container(padding: EdgeInsets.only(bottom: 5.0),child: Text(name)),
                  Text(lastMessageDate, style: Theme.of(context).textTheme.body1.copyWith(color: GoTicketsTheme.darkGrey, fontSize: 14),
                    overflow: TextOverflow.ellipsis,)
                ],
                ),
              ),
              Row(
                children: <Widget>[
                  Text(lastMessage),
                  Container()
                ],
              )
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

