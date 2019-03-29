import 'package:flutter/material.dart';

import 'package:go_tickets/src/widgets/theme.dart';
import 'package:go_tickets/src/models/chat.dart';

class ChatDetailsScreen extends StatefulWidget {
  final String recipientName;

  ChatDetailsScreen({this.recipientName});
  @override
  _ChatDetailsScreenState createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {

  final TextEditingController textEditingController = TextEditingController();
  final FocusNode textFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    textFocusNode.addListener(onFocusChange);
  }

  void onFocusChange(){
    if(textFocusNode.hasFocus){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.recipientName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title.copyWith(color: Colors.black)),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: GoTicketsTheme.darkLavender,
            ),
            onPressed: () {}),
        actions: <Widget>[
          Container(
            width: 30,
            height: 30,
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: GoTicketsTheme.darkGrey),
          )
        ],
      ),
      body: WillPopScope(
          onWillPop: (){},
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _buildMessageList(),
                  _buildTextInputBar(),
              ],)
            ],
      )),
    );
  }

  Widget _buildMessageList(){
    var chatList = ChatHelper.chats();
    return Flexible(
      child: ListView.builder(
          itemCount: chatList.length,
          itemBuilder: (context, rowIterator){
            var chat = chatList[rowIterator];

            return _buildChatItem(chat: chat);
      }),
    );
  }

  Widget _buildChatItem({Chat chat}){
    var chatBubbleSize = MediaQuery.of(context).size.width/4;
    // If the chat was sent by the user, align to the right
    if(chat.peerId == 0){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          width: 200.0,
          child: Text(chat.message,
            style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16, color: Colors.white),),
          decoration: BoxDecoration(
              color: GoTicketsTheme.lightLavender,
          ),
        )
      ],);
    }else{
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
           color: GoTicketsTheme.darkLavender,
           margin: EdgeInsets.only(right: chatBubbleSize, ),
           padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
           width: 200.0,
           child: Text(chat.message,
            style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16, color: Colors.white),),

        )],
      );
    }

  }

  Widget _buildTextInputBar(){
    return Container(
      child: Row(
        children: <Widget>[
          Material(
            child: Container(
              child: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.tag_faces, color: GoTicketsTheme.darkGrey,) ),
            ),
            color: Colors.white,
          ),
          Flexible(
            child: Container(
              child: TextField(
                decoration: InputDecoration.collapsed(
                    hintText: 'Type here...',
                    hintStyle: Theme.of(context).textTheme.caption.copyWith(fontSize: 16)),
              ),

            ),
          ),
          Material(
            child: Container(
              child: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.send, color: GoTicketsTheme.darkGrey,) ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
    );
  }

}
