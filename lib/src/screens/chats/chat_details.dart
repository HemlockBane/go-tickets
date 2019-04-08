import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:go_tickets/src/widgets/theme.dart';
import 'package:go_tickets/src/models/chat.dart';
import 'package:go_tickets/src/models/models.dart';

class ChatDetailsScreen extends StatefulWidget {
  final String recipientName;
  final User chatBuddy;

  ChatDetailsScreen({this.chatBuddy, this.recipientName});
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

    Widget _profilePicture(User userInfo){
      if(userInfo.profilePictureUrl != "" || userInfo.profilePictureUrl != " "){
        return Container(
          width: 30,
          height: 30,
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(userInfo.profilePictureUrl)
            ),
            shape: BoxShape.circle, color: GoTicketsTheme.darkGrey,
          ),
        );

      }else{
        return Container(
          width: 30,
          height: 30,
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            shape: BoxShape.circle, color: GoTicketsTheme.darkGrey,
          ),
          child: Center(
            child: Text('OB'),),
        );

      }

    }
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.recipientName == null
              ? widget.chatBuddy.displayName
              : widget.recipientName ,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title.copyWith(color: Colors.black)),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: GoTicketsTheme.darkLavender,
            ),
            onPressed: () {}),
        actions: <Widget>[_profilePicture(widget.chatBuddy)
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
    var userProfileId = UserModel.of(context).user.id;
    var recipientId = widget.chatBuddy.id;

    return Flexible(
      child: StreamBuilder(
          stream: Firestore.instance.collection('messages')
              .document(_createChatId(userProfileId: userProfileId, recipientId: recipientId))
              .collection('chats').orderBy('time_sent', descending: true)
              .snapshots(),
          builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(
              child: CircularProgressIndicator(
                valueColor:
                AlwaysStoppedAnimation<Color>(GoTicketsTheme.darkLavender),
              ));
        }else{
          var chatList = snapshot.data.documents;
          return ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context, rowIterator){
                DocumentSnapshot documentSnapshot = chatList[rowIterator];

                Chat chat = Chat.fromDocumentSnapshot(documentSnapshot: documentSnapshot);
                return _buildChatItem(chat: chat, chatList: chatList, chatIndex: rowIterator);
              }, );
        }
          }),
    );
  }

  Widget _buildChatItem({Chat chat, List chatList, int chatIndex}){

    var userId = UserModel.of(context).user.id;
    print(userId);
    // If the chat was sent by the user, align to the right
    if(chat.senderId == userId){
      return Column(
        children: <Widget>[
          isAfterLastLeftMessage(chatIndex: chatIndex, chatList: chatList) ? Text('Date sent') : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 2.5,
                    bottom: isAfterLastRightMessage(chatIndex: chatIndex, chatList: chatList) ? 10 : 2.5,
                    right: 10.0),
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                constraints: BoxConstraints(maxWidth: 300),
                child: Text(chat.message,
                  style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16, color: Colors.white),),
                decoration: BoxDecoration(
                  color: GoTicketsTheme.lightLavender,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
          )
        ],),


      ],);
    }else{
      return Column(
        children: <Widget>[
          isAfterLastRightMessage(chatIndex: chatIndex, chatList: chatList) ? Text('Date sent') : Container(),
          Row(
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
          ),
          //isLastReceivedMessage(chatIndex: chatIndex, chatList: chatList) ? Text('Date Received') : Container()

      ],);
    }

  }

  bool isAfterLastRightMessage({int chatIndex, List chatList}){

    var userProfileId = UserModel.of(context).user.id;
    Chat chat = Chat.fromDocumentSnapshot(documentSnapshot: chatList[chatIndex]);
    if((chatIndex > 0 && chatList != null && chat.senderId == userProfileId || chatIndex == 0)){
      return true;
    }
    else
      return false;
  }

  bool isAfterLastLeftMessage({int chatIndex, List chatList}){
    var recipientId = widget.chatBuddy.id;
    Chat chat = Chat.fromDocumentSnapshot(documentSnapshot: chatList[chatIndex]);
    if((chatIndex > 0 && chatList != null && chat.senderId ==  recipientId|| chatIndex == 0))
      return true;
    else
      return false;
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
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                maxLines: null,
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

    var userProfileId = UserModel.of(context).user.id;
    var recipientId = widget.chatBuddy.id;

    if(text.trim() != ''){
      String dateString = DateTime.now().millisecondsSinceEpoch.toString();

      DocumentReference documentReference = Firestore.instance
      .collection('messages')
      .document(_createChatId(recipientId:recipientId, userProfileId: userProfileId ))
      .collection('chats')
      .document(dateString);

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'time_sent': dateString,
            'message': text,
            'recipient_id': recipientId,
            'sender_id': userProfileId
          },
        );
      });
      textEditingController.clear();

      setState(() {

      });
    }else{
      print('chat_details.dart, ln 227: Empty string in text field');
    }
  }


  String _createChatId({String userProfileId, String recipientId}){
      String chatId = '';

      if(userProfileId.hashCode <= recipientId.hashCode ){
        chatId = '$userProfileId-$recipientId';
      }else{
        chatId = '$recipientId-$userProfileId';
      }

      return chatId;
  }
}
