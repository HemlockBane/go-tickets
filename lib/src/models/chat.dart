import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Chat {
  String peer;
  int peerId;
  String message;
  String messageDate;
  String unreadMessageCount;

  Chat(
      {this.peer,
      this.peerId,
      this.message,
      this.messageDate});
}
class ChatPreview{
  String peer;
  String mostRecentMessage;
  String mostRecentMessageDate;
  String unreadMessageCount;

  ChatPreview(
      {this.peer,
        this.mostRecentMessage,
        this.mostRecentMessageDate,
        this.unreadMessageCount});
}

class ChatPreviewHelper {
  static List<ChatPreview> chatPreviews() {
    List<ChatPreview> chatPreviews = List();
    chatPreviews
      ..add(
        ChatPreview(peer: 'Jasmine N', mostRecentMessage: '^_^', mostRecentMessageDate: '2 min'),
      )
      ..add(ChatPreview(
          peer: 'Natalie Musalevska', mostRecentMessage: 'YOLOYOLO!', mostRecentMessageDate: '13 min'))
      ..add(ChatPreview(
          peer: 'Yuri Zverev',
          mostRecentMessage: "No, I won't be able to join you tonight", mostRecentMessageDate: '5 h'))
      ..add(ChatPreview(
          peer: 'Habibullo Abdusamatov',
          mostRecentMessage: 'Ok, dude!',
          mostRecentMessageDate: '5 h'))
      ..add(ChatPreview(
          peer: 'Alex',
          mostRecentMessage: "I'm writing to you to voice my opinion in the ",
          mostRecentMessageDate: 'today 6 p.m.'))
      ..add(ChatPreview(
          peer: 'John Doe',
          mostRecentMessage: 'His understanding of what constitutes good',
          mostRecentMessageDate: 'today 3 p.m.'))
      ..add(ChatPreview(
          peer: 'Zephyr',
          mostRecentMessage: 'His understanding of what constitutes good',
          mostRecentMessageDate: 'today 2 p.m.'));

    return chatPreviews;
  }
}


class ChatHelper {

  static List<Chat> chats() {
    List<Chat> chats = List();
    chats
      ..add(
        Chat(peer: 'Natalie Musalevska', peerId: 1, message: "Hi! What's up?",),
      )..add(
      Chat(peer: 'Me', peerId: 0, message: "Oh, hallo!))",),
    )..add(
      Chat(peer: 'Me', peerId: 0, message: "I'm cool, everything is just fine",),
    )..add(
      Chat(peer: 'Me', peerId: 0, message: "Haven't seen you for ages!(",),
    )..add(
      Chat(peer: 'Natalie Musalevska', peerId: 1, message: "I came back from France yesterday",),
    )..add(
      Chat(peer: 'Natalie Musalevska', peerId: 1, message: "Need to get down now",),
    )..add(
      Chat(peer: 'Natalie Musalevska', peerId: 1, message: "YOLOYOLO!!",),
    );

    return chats;
  }


  static List<Chat> chatList = chats();


  static void addChatToList(Chat chat) {
    chatList.add(chat);
  }
}
