import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models.dart';

class Chat {
  String peer;
  String senderId;
  String message;
  String messageDate;
  String unreadMessageCount;

  Chat({this.peer, this.senderId, this.message, this.messageDate});

  Chat.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    message = documentSnapshot['message'];
    messageDate = documentSnapshot['time_sent'];
    senderId = documentSnapshot['sender_id'];
  }
}

class ChatPreview {
  String peerId;
  String peer;
  String lastMessage;
  String lastMessageDateTime;
  User chatPeer;
  int isAvailable; // 0 for active, 1 for online but not active, 2 for busy, 3 for away

  ChatPreview.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    var snapshotData = documentSnapshot.data;

    peerId = snapshotData['peer_id'];
    peer = snapshotData['peer_name'];
    lastMessage = snapshotData['last_message'];
    lastMessageDateTime = snapshotData['last_message_date'];

    _loadChatPeerDetails(peerId);

//    var snapShotdata = documentSnapshot.reference.;
//    print(snapShotdata);
  }

  void _loadChatPeerDetails(String peerId) {
    var documentReference =
        Firestore.instance.collection('users').document(peerId);

    documentReference.get().then((documentSnapshot) {
      //chatPeer = User.fromDocumentSnapshot(documentSnapshot: documentSnapshot);
    });
  }
}
