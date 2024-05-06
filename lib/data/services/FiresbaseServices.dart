import 'dart:typed_data';

import 'package:aqary/Models/UserModel.dart';
import 'package:aqary/helper/date_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../Models/ChatModel.dart';

class FirebaseServices {

  final CollectionReference chatRooms = FirebaseFirestore.instance.collection('chatRooms');
  final userCollection = FirebaseFirestore.instance.collection('users');
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

  Future<UserModel?> getUser(String userId) async {
    try {
      DocumentSnapshot userDoc = await userCollection.doc(userId).get();
      Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;


      if (userDoc.exists) {
        return UserModel.fromJson(data!);
      } else {
        print('No user found with id $userId');
        return null;
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  void addUser(String uid, String mobileNumber) {
    userCollection.doc(uid).set({
      //'userName' : userName,
      'mobileNumber': mobileNumber,
      'userId': uid,
    } ,SetOptions(merge: true)).then((_) {
      print('User added to collection');
    }).catchError((error) {
      print('Failed to add user: $error');
    });
  }

  void updateUser(String uid, String userName,) {
    userCollection.doc(uid).update({
     // 'pic':pic,
      'userName': userName,
    }).then((_) {
      print('User name updated in collection');
    }).catchError((error) {
      print('Failed to update user name: $error');
    });
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    List<Map<String, dynamic>> userList = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('users').get();

    snapshot.docs.forEach((doc) {
      userList.add(doc.data());
    });

    userList.forEach((element) {print(element['mobileNumber']);});
    return userList;
  }


    Future<List<DocumentSnapshot>> searchUsers(String searchKey) async {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .get();


      final List<DocumentSnapshot> matchingUsers = [];

      querySnapshot.docs.forEach((doc) {
        final userId = doc['userId'];
        final mobileNumber = doc['mobileNumber'] as String?;
        final userName = doc.exists ? doc['userName'] as String? : null;

        if(userId != firebaseAuth.currentUser!.uid) {
          if (mobileNumber != null || userName != null) {
            if (mobileNumber!.contains(searchKey) || (userName != null &&
                userName.toLowerCase().contains(searchKey))) {
              matchingUsers.add(doc);
            }
          }
        }
      });

      return matchingUsers;
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

      addChatRoomToUser(currentUserId,senderId,chatRoomId);

      CollectionReference messagesCollection = chatRooms.doc(chatRoomId).collection('messages');

     // await messagesCollection.add(initialMessage);

      return chatRoomId;
    } else {
      return "";
    }
  }

  void addChatRoomToUser(String currentUserId, String senderId, String chatRoomId) {

    void addToUserChats(String uid, chatRoomRef) {
      userCollection.doc(uid).update({
        'chats': FieldValue.arrayUnion([chatRoomRef]),
      }).then((_) {
        print('Chat room added to user: $uid');
      }).catchError((error) {
        print('Failed to add chat room to user: $uid, Error: $error');
      });
    }

    addToUserChats(currentUserId, chatRoomId);

    addToUserChats(senderId, chatRoomId);
  }

  Future<List<QuerySnapshot<Map<String, dynamic>>>> getUserChatsStream() async {
    var userId = firebaseAuth.currentUser!.uid;
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await userCollection.doc(userId).get();

      List<String>? chatRoomIds = userDoc.data()?['chats']?.cast<String>();

      if (chatRoomIds != null && chatRoomIds.isNotEmpty) {
        List<Future<QuerySnapshot<Map<String, dynamic>>>> futures = chatRoomIds.map((roomId) =>
            chatRooms.doc(roomId).collection('messages').orderBy("messageDate",descending: true).get()).toList();

        List<QuerySnapshot<Map<String, dynamic>>> messageSnapshots = await Future.wait(futures);
        print(messageSnapshots[0].docs[0].get("seen"));
        return messageSnapshots;
      } else {
        print('No chatrooms found for user: $userId');
        return [];
      }
    } catch (e) {
      print('Error fetching chatrooms for user: $e');
      return [];
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



