
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
  String? chatroomId;
  String? messageId;
  String? messageType;
  bool? seen;
  String? senderID;
  String? recipientId;
  String? senderName;
  String? recipientName;
  String? recipientPhone;
  String? recipientImg;

  Message({ this.message,  this.messageDate,  this.messageId, this.chatroomId, this.messageType,
     this.seen, this.senderID,this.recipientId,this.recipientName,this.recipientPhone,this.recipientImg});

  factory Message.fromJson(Map json){
    return Message(
        message : json['message'] ?? "",
        messageDate: json['messageDate'],
        messageId : json['messageId']??"",
        chatroomId : json['chatroomId']??"",
        messageType : json['messageType']??"",
        seen : json['seen']?? false,
        senderID : json['senderID']??"",
        recipientId:json['recipientId'] ??"",
        recipientName:json['recipientName']??"",
        recipientPhone:json['recipientPhone']??"",
        recipientImg:json['recipientImg']??""
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['messageDate'] = messageDate;
    data['messageId'] = messageId;
    data['chatroomId'] = chatroomId;
    data['messageType'] = messageType;
    data['seen'] = seen;
    data['senderID'] = senderID;
    data['recipientId'] = recipientId;
    data['recipientName'] = recipientName;
    data['recipientPhone'] = recipientPhone;
    data['recipientImg'] = recipientImg;
    return data;
  }
}