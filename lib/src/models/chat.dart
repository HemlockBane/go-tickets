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
  String peer;
  String mostRecentMessage;
  String mostRecentMessageDate;
  int isAvailable; // 0 for active, 1 for online but not active, 2 for busy, 3 for away

  ChatPreview(
      {this.peer,
        this.mostRecentMessage,
        this.mostRecentMessageDate,
        this.isAvailable});
}

class ChatPreviewHelper {
  static List<ChatPreview> chatPreviews() {
    List<ChatPreview> chatPreviews = List();
    chatPreviews
      ..add(
        ChatPreview(peer: 'Jasmine N', mostRecentMessage: '^_^', mostRecentMessageDate: '2 min', isAvailable: 0),
      )
      ..add(ChatPreview(
          peer: 'Natalie Musalevska', mostRecentMessage: 'YOLOYOLO!', mostRecentMessageDate: '13 min', isAvailable: 1))
      ..add(ChatPreview(
          peer: 'Yuri Zverev',
          mostRecentMessage: "No, I won't be able to join you tonight", mostRecentMessageDate: '5 h', isAvailable: 2))
      ..add(ChatPreview(
          peer: 'Habibullo Abdusamatov',
          mostRecentMessage: 'Ok, dude!',
          mostRecentMessageDate: '5 h', isAvailable: 2))
      ..add(ChatPreview(
          peer: 'Alex',
          mostRecentMessage: "I'm writing to you to voice my opinion in the ",
          mostRecentMessageDate: 'today 6 p.m.', isAvailable: 0))
      ..add(ChatPreview(
          peer: 'John Doe',
          mostRecentMessage: 'His understanding of what constitutes good',
          mostRecentMessageDate: 'today 3 p.m.', isAvailable: 0))
      ..add(ChatPreview(
          peer: 'Zephyr',
          mostRecentMessage: 'His understanding of what constitutes good',
          mostRecentMessageDate: 'today 2 p.m.', isAvailable: 3));

    return chatPreviews;
  }
}


class ChatHelper {

//  static List<Chat> chats() {
//    List<Chat> chats = List();
//    chats
//      ..add(
//        Chat(peer: 'Natalie Musalevska', senderId: 1, message: "Hi! What's up?",),
//      )..add(
//      Chat(peer: 'Me', senderId: 0, message: "Oh, hallo!))",),
//    )..add(
//      Chat(peer: 'Me', senderId: 0, message: "I'm cool, everything is just fine",),
//    )..add(
//      Chat(peer: 'Me', senderId: 0, message: "Haven't seen you for ages!(",),
//    )..add(
//      Chat(peer: 'Natalie Musalevska', senderId: 1, message: "I came back from France yesterday",),
//    )..add(
//      Chat(peer: 'Natalie Musalevska', senderId: 1, message: "Need to get down now",),
//    )..add(
//      Chat(peer: 'Natalie Musalevska', senderId: 1, message: "YOLOYOLO!!",),
//    );
//
//    return chats;
//  }


  //static List<Chat> chatList = chats();


//  static void addChatToList(Chat chat) {
//    chatList.add(chat);
//  }
}
