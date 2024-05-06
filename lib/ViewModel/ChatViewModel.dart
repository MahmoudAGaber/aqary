
import 'package:aqary/data/services/FiresbaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/ChatModel.dart';

final isSearchTapProvider = StateProvider<bool>((ref) => false);

final messagesProvider = StateNotifierProvider<MessagesNotifier , List<Message>>((ref) => MessagesNotifier(ref));

final searchUserProvider = StateNotifierProvider<searchUserNotifier , List<DocumentSnapshot>>((ref) => searchUserNotifier(ref));

class MessagesNotifier extends StateNotifier<List<Message>> {
  Ref ref;

  MessagesNotifier(this.ref) : super([]);

  Future<void> fetchMessages(String chatRoomId) async {
    try {
      QuerySnapshot<
          Map<String, dynamic>> messagesSnapshot = await FirebaseFirestore
          .instance
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .snapshots()
          .first;

      state = messagesSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return Message(
          message: data["message"],
          messageDate: data["messageDate"],
          messageId: data["messageId"],
          messageType: data["messageType"],
          seen: data["seen"],
          senderID: data["senderID"],
        );
      }).toList();
    }catch(e){
      print("Error fetching messages: $e");
    }

    print("Length${state.length}");
  }
}



class searchUserNotifier extends StateNotifier<List<DocumentSnapshot>>{
  Ref ref;
  searchUserNotifier(this.ref):super([]);
  FirebaseServices firebaseServices = FirebaseServices();

  Future<void> filterUsers(String searchKey) async{
    List<DocumentSnapshot> users = [];
    users = await firebaseServices.searchUsers(searchKey);

    state = users;
  }
}

