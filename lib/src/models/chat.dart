import 'package:flutter/material.dart';

class Chat {
  String recipientName;
  String mostRecentMessage;
  String mostRecentMessageDate;
  String unreadMessageCount;

  Chat(
      {this.recipientName,
      this.mostRecentMessage,
      this.mostRecentMessageDate,
      this.unreadMessageCount});
}

class ChatHelper {
  static List<Chat> chats() {
    List<Chat> chats = List();
    chats
      ..add(
        Chat(recipientName: 'Jasmine N', mostRecentMessage: '^_^', mostRecentMessageDate: '2 min'),
      )
      ..add(Chat(
          recipientName: 'Natalie Musalevska', mostRecentMessage: 'YOLOYOLO!', mostRecentMessageDate: '13 min'))
      ..add(Chat(
          recipientName: 'Yuri Zverev',
          mostRecentMessage: "No, I won't be able to join you tonight", mostRecentMessageDate: '5 h'))
      ..add(Chat(
          recipientName: 'Habibullo Abdusamatov',
          mostRecentMessage: 'Ok, dude!',
          mostRecentMessageDate: '5 h'))
      ..add(Chat(
          recipientName: 'Alex',
          mostRecentMessage: "I'm writing to you to voice my opinion in the ",
          mostRecentMessageDate: 'today 6 p.m.'))
      ..add(Chat(
          recipientName: 'John Doe',
          mostRecentMessage: 'His understanding of what constitutes good',
          mostRecentMessageDate: 'today 3 p.m.'))
      ..add(Chat(
          recipientName: 'Zephyr',
          mostRecentMessage: 'His understanding of what constitutes good',
          mostRecentMessageDate: 'today 2 p.m.'));

    return chats;
  }

  Chat getChatItemAtIndex(int position) {
    return chats()[position];
  }
}
