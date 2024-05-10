

import 'package:aqary/Models/NotificationModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/RequestHandler.dart';
import '../data/StateModel.dart';

final NotificationProvider = StateNotifierProvider<NotificationNotifier, StateModel<List<NotificationModel>>>((ref) => NotificationNotifier(ref));

final notificationsCountProvider = StateProvider<int>((ref) => 0);

final enableNotificationProvider = StateProvider<bool>((ref) => true);



class NotificationNotifier extends StateNotifier<StateModel<List<NotificationModel>>>{
  Ref ref;
  NotificationNotifier(this.ref): super(StateModel.loading());

  Future<void> getNotifications()async {
    RequestHandler requestHandler = RequestHandler();
    List<NotificationModel> notifications;

    try {
      state = StateModel.loading();

      notifications = await requestHandler.getData(
        endPoint: '/notifications',
        auth: true,
        fromJson: (json) => NotificationModel.listFromJson(json),
      );
      if(notifications.isNotEmpty && notifications !=null && notifications != []){
        state = StateModel.success(notifications);
      }else {
        state = StateModel.fail("Error in data");

      }

      print("HOHOHO${notifications}");
    } catch (e) {
      state = StateModel.fail("Error in data");
    }
  }

  Future<void> readOneNotifications(String notificationId)async {
    RequestHandler requestHandler = RequestHandler();
    List<NotificationModel> notificationsTemp = [];

    try {
       await requestHandler.getData(
        endPoint: '/notifications/read/$notificationId',
        auth: true,
        fromJson: (json){},
      );

       notificationsTemp.clear();
       notificationsTemp = state.data!;

       for(var item in notificationsTemp){
         if(item.id == notificationId){
           item.isRead = !item.isRead;
           print("WELLDONE");
         }


       }
       state = StateModel.success(notificationsTemp);

    } catch (e) {
      print("Error in data$e");
    }
  }

  int notificationCount() {
    int count = 0;
    if (state.data != null) {
    for (var item in state.data!) {
      if (item.isRead == false) {
        count++;
      }
    }
  }
    return count;
  }
}