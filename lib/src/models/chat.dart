import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models.dart';
import '../widgets/datetime_formatter.dart';

class Chat {
  String chatPeer = '';
  String senderId = '';
  String message = '';
  String messageDate = '';
  String unreadMessageCount = '';

  Chat({this.chatPeer, this.senderId, this.message, this.messageDate});

  Chat.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    message = documentSnapshot['message'];
    messageDate = documentSnapshot['time_sent'];
    senderId = documentSnapshot['sender_id'];
  }
}

class ChatPreview {
  String chatPeerName = '';
  String chatPeerId = '';
  String chatPeerAvatarUrl = '';
  String lastMessage = '';
  String lastMessageTime = '';
  int isAvailable; // 0 for active, 1 for online but not active, 2 for busy, 3 for away

  ChatPreview.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    var documentSnapshotData = documentSnapshot.data;
    var lastMessageTimeInMillisecs = documentSnapshotData['last_message_date'];

    chatPeerName = documentSnapshotData['peer_name'];
    chatPeerId = documentSnapshotData['peer_id'];
    chatPeerAvatarUrl = documentSnapshotData['peer_avatar'];
    lastMessageTime = formatTime(lastMessageTimeInMillisecs);
    lastMessage = documentSnapshotData['last_message'];
  }

  @override
  String toString() {
    return 'Chat peer name: $chatPeerName'
        'Chat peer id: $chatPeerId'
        'Chat peer avatar url: $chatPeerAvatarUrl';
  }
}
