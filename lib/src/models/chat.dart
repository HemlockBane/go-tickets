import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';
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
    _loadChatPeerDetails(peerId);

    var lastMessageTimeInMillisecs = snapshotData['last_message_date'];

    lastMessageDateTime = formatTime(lastMessageTimeInMillisecs);
    peer = snapshotData['peer_name'];
    lastMessage = snapshotData['last_message'];

  }

  void _loadChatPeerDetails(String peerId) {
    var documentReference =
        Firestore.instance.collection('users').document(peerId);

    documentReference.get().then((documentSnapshot) {
      //chatPeer = User.fromDocumentSnapshot(documentSnapshot: documentSnapshot);

    });
  }

  String formatTime(String timeInMillisecs){

    String formattedTime = '';
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timeInMillisecs));

    Duration difference = DateTime.now().difference(dateTime);

    if(difference.inMilliseconds <= 999) {
      formattedTime = 'Just now';
    }else{
      if(difference.inSeconds <= 59){
        formattedTime = '${difference.inSeconds} secs';
      }else{
        if(difference.inMinutes <= 59){
          formattedTime = '${difference.inMinutes} mins';
        }else {
          if(difference.inHours <= 23){
            formattedTime = '${difference.inHours} hrs';
          }else{
            if(difference.inHours > 23){
              formattedTime = '${difference.inDays} days';
            }
          }
        }
      }
    }
    return formattedTime;
  }
}
