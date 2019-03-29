import 'package:flutter/material.dart';

import 'package:go_tickets/src/widgets/theme.dart';

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
                  _buildInput(),
              ],)
            ],
      )),
    );
  }

  Widget _buildMessageList(){
    return Container();
  }

  Widget _buildInput(){
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
