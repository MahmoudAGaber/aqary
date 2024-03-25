import 'dart:typed_data';

import 'package:aqary/helper/date_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../Models/ChatModel.dart';

class FirebaseServices {

  final CollectionReference chatRooms = FirebaseFirestore.instance.collection('chatRooms');
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseMessaging messaging = FirebaseMessaging.instance;



  Future<String?> getFCMToken() async {
    String? fcmToken;

    try {
      fcmToken = await messaging.getToken();
    } catch (e) {
      print('Error getting FCM token: $e');
    }

    return fcmToken;
  }


  Future<String> createChatRoom(String currentUserId, String senderId, Map<String, dynamic> initialMessage) async {
    bool createNewChatRoom = true;

    QuerySnapshot existingChatRooms = await chatRooms
        .where('users', arrayContainsAny: [currentUserId, senderId])
        .get();

    for (QueryDocumentSnapshot doc in existingChatRooms.docs) {
      List<dynamic> users = doc['users'];

      if (users.contains(currentUserId) && users.contains(senderId)) {
        createNewChatRoom = false;
        return doc.id;
      }
    }

    if (createNewChatRoom)
    {
      String chatRoomId = chatRooms.doc().id;

      await chatRooms.doc(chatRoomId).set({
        'chatRoomId': chatRoomId,
        'users': [currentUserId, senderId],
      });

      CollectionReference messagesCollection = chatRooms.doc(chatRoomId).collection('messages');

     // await messagesCollection.add(initialMessage);

      return chatRoomId;
    } else {
      return "";
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchMessagesStream(String chatRoomId) {
    try {
      return FirebaseFirestore
          .instance
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy("messageDate")
          .snapshots();
    } catch (e) {
      print("Error fetching messages: $e");
      throw e; // Rethrow the exception to handle it in the calling code if needed
    }
  }


  Future<void> sendMessage(chatRoomId, dynamic message, String messageType) async {

    CollectionReference messagesCollection = chatRooms.doc(chatRoomId).collection('messages');
    DateTime dateTime = DateTime.now();

    await messagesCollection.add(
        Message(
        seen: false,
        message: message,
        messageType: messageType,
        messageId: messagesCollection.doc().id,
        messageDate: DateConverter.localDateToIsoString(dateTime),
        senderID: firebaseAuth.currentUser!.uid
    ).toJson());

  }

   Future<String> uploadFile(Uint8List fileBytes, String fileName) async {
    User? user = firebaseAuth.currentUser;
    try {
      Reference storageRef = storage.ref().child('images/${user!.uid}/$fileName');

      UploadTask uploadTask = storageRef.putData(fileBytes);

      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});

      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;

      print("Download URL: $downloadUrl");
    } catch (e) {
      print("Failed to upload file $e");
    }
    return "";
  }
}


