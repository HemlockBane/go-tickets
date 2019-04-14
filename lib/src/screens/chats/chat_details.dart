import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:go_tickets/src/widgets/theme.dart';
import 'package:go_tickets/src/widgets/formatter.dart';
import 'package:go_tickets/src/models/chat.dart';
import 'package:go_tickets/src/models/models.dart';


class ChatDetailsScreen extends StatefulWidget {
  final User chatPeer;

  ChatDetailsScreen({@required this.chatPeer})
      : assert(chatPeer != null);
  @override
  _ChatDetailsScreenState createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {

  TextEditingController textEditingController = TextEditingController();
  FocusNode textFocusNode;
  ScrollController listScrollController;
  DocumentReference documentReference;
  DocumentReference chatIdDocumentReference;

  bool isShowingSmileys = false;
  int chatLimit = 10;
  var chatList;




  @override
  void initState() {
    super.initState();
    textFocusNode = FocusNode();
    textFocusNode.addListener(_handleKeyboardActiveState);
    listScrollController = ScrollController();
    listScrollController.addListener(_scrollListener);
  }

  /// Hide smileys when keyboard is active
   _handleKeyboardActiveState(){
    if(textFocusNode.hasFocus){
      setState(() {
        isShowingSmileys = false;
      });
    }
  }

  _scrollListener() {
    if (listScrollController.offset >=
        listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        chatLimit += 10;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.chatPeer.displayName,
              style: Theme.of(context).textTheme.title.copyWith(color: Colors.black)),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: GoTicketsTheme.darkLavender,
            ),
            onPressed: () {}),
        actions: <Widget>[
          _getProfilePicture(),
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

  Widget _getProfilePicture(){
    if(widget.chatPeer.profilePictureUrl != "" && widget.chatPeer.profilePictureUrl != " "){
      return Container(
        width: 30,
        height: 30,
        margin: EdgeInsets.only(right: 20, top: 12, bottom: 12),
        child: CircleAvatar(
          radius: 15,
          backgroundImage: CachedNetworkImageProvider(widget.chatPeer.profilePictureUrl,),
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
          child: Text(getPlaceholderInitials(widget.chatPeer.displayName)),
        ),
      );

    }
  }


  Future<bool>_handleBackButtonAction(){
    Navigator.pop(context);
    return Future.value(false);
  }

  Widget _buildMessageList(){
    String userProfileId = UserModel.of(context).user.id;
    String recipientId = widget.chatPeer.id;
    String chatId = _createChatId(recipientId: recipientId, userProfileId: userProfileId);

    return Flexible(
      child: StreamBuilder(
          stream: Firestore.instance
              .collection('messages')
              .document(chatId)
              .collection('chats')
              .orderBy('time_sent', descending: true)
              .limit(chatLimit)
              .snapshots(),
          builder: (context, snapshot){
            List documentList = snapshot.data.documents as List;

        if(snapshot.hasError){
          return Center(
              child: Text('Error: ${snapshot.error}',
                style: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: 14
                ),
              ),
          );
        }else if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(GoTicketsTheme.darkLavender),),
          );
        }else{
          switch(documentList.isEmpty){
            case true:
              return Center(
                child: Text('No chats'),
              );
            case false:
              chatList = snapshot.data.documents;
              return ListView.builder(
                controller: listScrollController,
                itemCount: chatList.length,
                itemBuilder: (context, rowIndex){

                  return _buildChatItem(document: chatList[rowIndex], index: rowIndex);
                },
                reverse: true,);
          }
        }
          }),
    );
  }

  Widget _buildChatItem({int index, DocumentSnapshot document}){

    var userId = UserModel.of(context).user.id;
    Chat chat = Chat.fromDocumentSnapshot(documentSnapshot: document);

    // If the chat was sent by the user, align to the right
    if(chat.senderId == userId){
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 2.5,
                    right: 10.0),
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                constraints: BoxConstraints(maxWidth: 300),
                child: Text(chat.message,
                  style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16, color: GoTicketsTheme.midLavender),),
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
          isLastLeftMessage(index: index, userId: userId) ?
          Text(formatTime(chat.messageDate),
            style: Theme.of(context).textTheme.body1.copyWith(
                color: GoTicketsTheme.lightGrey, fontSize: 15),) :
          Container()
      ],);
    }

  }

  bool isLastLeftMessage({int index, String userId }){
    if((index > 0 && chatList != null && chatList[index - 1]['sender_id'] == userId) || index == 0){
      return true;
    }else{
      return false;
    }
  }

  bool isLastRightMessage({int index, String userId }){
    if((index > 0 && chatList != null && chatList[index - 1]['sender_id'] != userId) || index == 0){
      return true;
    }else{
      return false;
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

  void _handleSendButtonTap(String message){

    textEditingController.clear();

    var userProfileId = UserModel.of(context).user.id;
    var peerId = widget.chatPeer.id;
    var peerName = widget.chatPeer.displayName;
    var peerAvatar = widget.chatPeer.profilePictureUrl;

    if(message.trim() != ''){
      String chatId = _createChatId(recipientId:peerId, userProfileId: userProfileId);
      String timeSent = DateTime.now().millisecondsSinceEpoch.toString();

      documentReference = Firestore.instance
      .collection('messages')
      .document(chatId)
      .collection('chats')
      .document(timeSent);

      chatIdDocumentReference = Firestore.instance
          .collection('messages')
          .document(chatId);


      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'time_sent': timeSent,
            'message': message,
            'recipient_id': peerId,
            'sender_id': userProfileId,
          },
        );
      });

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          chatIdDocumentReference,
          {
            'chat_id': chatId,
            'peer_id': peerId,
            'peer_name': peerName,
            'peer_avatar': peerAvatar,
            'last_message': message,
            'last_message_date': timeSent,


          },
        );
      });

      listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
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
