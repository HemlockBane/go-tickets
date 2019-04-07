import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/theme.dart';
import '../screens/chats/chat_details.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
            stream: Firestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(GoTicketsTheme.darkLavender),
                ));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, rowIterator) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data.documents[rowIterator]; //map
                      return _buildListItem(
                          context: context, documentSnapshot: documentSnapshot);
                    });
              }
            }),
      ),
    );
  }

  Widget _buildListItem({BuildContext context, DocumentSnapshot documentSnapshot}) {
    var userName = documentSnapshot['username'];
    return ListTile(
      title: Text(userName),
      onTap: (){
        _handleTileTap(context: context, chatPeer: userName);
        },
    );
  }

  void _handleTileTap({BuildContext context, String chatPeer}){
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => ChatDetailsScreen(
        recipientName: chatPeer,),
    ),
    );
  }

}
