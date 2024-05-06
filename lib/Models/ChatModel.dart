
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String chatRoomId;
  final List<String> users;

  ChatRoom({
    required this.chatRoomId,
    required this.users,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      chatRoomId: json['chatRoomId'],
      users: List<String>.from(json['users'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatRoomId': chatRoomId,
      'users': users,
    };
  }
}

class Message{
  String? message;
  String? messageDate;
  String? messageId;
  String? messageType;
  bool? seen;
  String? senderID;
  String? senderName;
  String? pic;

  Message({ this.message,  this.messageDate,  this.messageId,  this.messageType,
     this.seen, this.senderID});

  factory Message.fromJson(Map json){
    return Message(
        message : json['message'] ?? "",
        messageDate: json['messageDate'],
        messageId : json['messageId']??"",
        messageType : json['messageType']??"",
        seen : json['seen']?? false,
        senderID : json['senderID']??""
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['messageDate'] = messageDate;
    data['messageId'] = messageId;
    data['messageType'] = messageType;
    data['seen'] = seen;
    data['senderID'] = senderID;
    return data;
  }
}