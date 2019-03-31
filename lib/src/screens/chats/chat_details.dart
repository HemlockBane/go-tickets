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

  bool isShowingSmileys = false;


  @override
  void initState() {
    super.initState();
    textFocusNode.addListener(_handleKeyboardActiveState);
  }

  /// Hide smileys when keyboard is active
  void _handleKeyboardActiveState(){
    if(textFocusNode.hasFocus){
      setState(() {
        isShowingSmileys = false;
      });
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
          onWillPop: () => _handleBackButtonAction(),
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

  Future<bool>_handleBackButtonAction(){
    Navigator.pop(context);
    return Future.value(false);
  }

  Widget _buildMessageList(){
    var chatList = ChatHelper.chatList;
    print('chat_details.dart, ln 83: chatlist length is ${chatList.length}');
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
    // If the chat was sent by the user, align to the right
    if(chat.peerId == 0){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 2.5, bottom: 2.5, right: 10.0),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Text(chat.message,
            style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16, color: Colors.white),),
          decoration: BoxDecoration(
              color: GoTicketsTheme.lightLavender,
            borderRadius: BorderRadius.all(Radius.circular(5.0))
          ),
        )
      ],);
    }else{
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
           margin: EdgeInsets.only(top: 2.5, bottom: 2.5, left: 10.0),
           padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
           decoration: BoxDecoration(
             color: GoTicketsTheme.darkLavender,
             borderRadius: BorderRadius.all(Radius.circular(5.0))
           ),
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
                focusNode: textFocusNode,
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                    hintText: 'Type here...',
                    hintStyle: Theme.of(context).textTheme.caption.copyWith(fontSize: 16)),
              ),
            ),
          ),
          Material(
            child: Container(
              child: IconButton(
                  onPressed: () => _handleSendButtonTap(textEditingController.text),
                  icon: Icon(Icons.send, color: GoTicketsTheme.darkGrey,) ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
    );
  }

  void _handleSendButtonTap(String text){
    if(text.trim() != ''){
      // Log chats before adding chat
      ChatHelper.chats().forEach((chat){
        print(' chat_details.dart, 171: Before adding chat - ${chat.message}');
      });

      ChatHelper.addChatToList(
          Chat(peer: 'Me', peerId: 0, message: text));

      textEditingController.clear();

      // Log chats after adding chat
      ChatHelper.chats().forEach((chat){
        print(' chat_details.dart, 180: After adding chat - ${chat.message}');
      });
      setState(() {

      });
    }else{
      print('Empty string in text field');
    }
  }

}
