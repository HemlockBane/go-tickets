import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../widgets/theme.dart';
import '../screens/chats/chat_details.dart';
import '../models/models.dart';
import '../widgets/formatter.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Users',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title.copyWith(
                color: Colors.black),
            ),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){})
        ],
      ),
      body: Container(
        child: StreamBuilder(
            stream: Firestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(GoTicketsTheme.darkLavender),
                ),
                );
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
    //var userName = documentSnapshot['username'];
    User user = User.fromDocumentSnapshot(documentSnapshot: documentSnapshot);
    if(UserModel.of(context).user.id == user.id){
      return Container();
    }else{
      return ListTile(
        leading: _getCircleAvatar(user),
        title: Text(user.displayName, style: Theme.of(context).textTheme.body1,),
        onTap: (){
          _handleTileTap(context: context, chatPeer: user);
        },
      );

    }

  }

  Widget _getCircleAvatar(User user){
    if(user.profilePictureUrl != "" && user.profilePictureUrl != " "){
      return CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(user.profilePictureUrl),
      );
    }else{
      return CircleAvatar(
        backgroundColor: GoTicketsTheme.darkGrey,
        child: Text(getPlaceholderInitials(user.displayName),
          style: Theme.of(context).textTheme.body1.copyWith(
              color: Colors.white, fontSize: 13),
        ),
      );

    }
  }

  void _handleTileTap({BuildContext context, User chatPeer}){
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => ChatDetailsScreen(chatPeer: chatPeer,),
    ),
    );
  }

}
