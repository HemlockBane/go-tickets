import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models.dart';
import '../widgets/datetime_formatter.dart';

class Chat {
  String peer = '';
  String senderId = '';
  String message = '';
  String messageDate = '';
  String unreadMessageCount = '';

  Chat({this.peer, this.senderId, this.message, this.messageDate});

  Chat.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    message = documentSnapshot['message'];
    messageDate = documentSnapshot['time_sent'];
    senderId = documentSnapshot['sender_id'];
  }
}

class ChatPreview {
  String peerId = '';
  String peerName = '';
  String peerAvatarUrl = '';
  String lastMessage = '';
  String lastMessageDateTime = '';
  int isAvailable; // 0 for active, 1 for online but not active, 2 for busy, 3 for away

  ChatPreview.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    var snapshotData = documentSnapshot.data;
    var lastMessageTimeInMillisecs = snapshotData['last_message_date'];

    peerId = snapshotData['peer_id'];
    lastMessageDateTime = formatTime(lastMessageTimeInMillisecs);
    lastMessage = snapshotData['last_message'];
    peerName = snapshotData['peer_name'];
    peerAvatarUrl = snapshotData['peer_avatar'];



  }
}
