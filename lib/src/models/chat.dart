import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String peer;
  String senderId;
  String message;
  String messageDate;
  String unreadMessageCount;

  Chat(
      {this.peer,
      this.senderId,
      this.message,
      this.messageDate});

  Chat.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}){
    message = documentSnapshot['message'];
    messageDate = documentSnapshot['time_sent'];
    senderId = documentSnapshot['sender_id'];

  }
}
class ChatPreview{
  String peerId;
  String peer;
  String lastMessage;
  String lastMessageDateTime;
  int isAvailable; // 0 for active, 1 for online but not active, 2 for busy, 3 for away

//  ChatPreview(
//      {this.peerId,
//        this.peer,
//        this.lastMessage,
//        this.lastMessageDateTime,
//        this.isAvailable});

  ChatPreview.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}){

    print('snapshot data : ${documentSnapshot.data}');
    var snapshotData = documentSnapshot.data;

    peerId = snapshotData['peer_id'];
    peer = snapshotData['peer_name'];
    lastMessage = snapshotData['last_message'];
    lastMessageDateTime = snapshotData['last_message_date'];



    //ChatPreview chatPreview = fromDocumentSnapshot(documentSnapshot: documentSnapshot);

    var documentReference = Firestore.instance.collection('users').document(peerId);

    documentReference.get().then((documentSnapshot){
      peer = documentSnapshot['username'];
      print(peer);
    }).whenComplete((){
    });



    print('$peerId - $lastMessage - $lastMessageDateTime');


//    var snapShotdata = documentSnapshot.reference.;
//    print(snapShotdata);


  }
}



