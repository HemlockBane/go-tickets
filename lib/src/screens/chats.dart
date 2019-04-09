import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat.dart';
import '../models/models.dart';
import '../screens/home.dart';
import '../screens/users.dart';
import '../widgets/theme.dart';
import './chats/chat_details.dart';

class ChatsScreen extends StatefulWidget {

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {

  User chatPeer;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.chat_bubble),
          onPressed: (){
            _handleFloatingActionButtonTap(context: context);
          }),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder(
            stream: Firestore.instance.collection('messages').getDocuments().asStream(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Center(
                    child: CircularProgressIndicator(
                    ));
              }else{
                var chatList = snapshot.data.documents;
                return ListView.builder(
                    itemCount: chatList.length,
                    itemBuilder: (context, rowIterator) {
                      DocumentSnapshot documentSnapshot = snapshot.data.documents[rowIterator];


                      //Color bubbleIndicatorColor;
                      //bubbleIndicatorColor = _setOnlineIndicatorColor(colorCode: chatSnippet.isAvailable);

                      var chat = ChatPreview.fromDocumentSnapshot(documentSnapshot: documentSnapshot);
                      _loadUserDetails(chat.peerId);

                      return chatPreviewListTile(
                          name: chat.peer,
                          peerId: chat.peerId ,
                          lastMessage: chat.lastMessage,
                          lastMessageDate: chat.lastMessageDateTime,
                          color: Colors.white);

                    });
              }
            },
          )),
    );
  }

  Color _setOnlineIndicatorColor({int colorCode}){
    Color indicatorColor;
    switch(colorCode){
      case 0:
        indicatorColor = Colors.green;
            break;
      case 1:
        indicatorColor = Colors.yellow.shade600;
        break;
      case 2:
        indicatorColor = Colors.grey.shade500;
        break;
      case 3:
        indicatorColor = Colors.red;
        break;
    }

    return indicatorColor;
  }

  Widget chatPreviewListTile({String name, String lastMessage, String lastMessageDate, String peerId, Color color}){
    return Container(
      padding: EdgeInsets.all(6.0),
      margin: EdgeInsets.only(top: 11.0, bottom: 16.0, left: 4),
      child: InkWell(
        onTap: (){
          _handleListTileTap(context: context, chatBuddy: chatPeer );
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

  void _handleListTileTap({BuildContext context, User chatBuddy, String chatBuddyName}){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => ChatDetailsScreen(
          recipientName: chatBuddyName,
          chatBuddy: chatBuddy,),
      ),
    );
  }

  void _loadUserDetails(String peerId){
    var documentReference = Firestore.instance.collection('users').document(peerId);

    documentReference.get().then((documentSnapshot){
      chatPeer = User.fromDocumentSnapshot(documentSnapshot: documentSnapshot);
    });
  }


  void _handleFloatingActionButtonTap({BuildContext context}){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => UsersScreen(),
      ),
    );
  }

}

