

import 'package:aqary/Models/NotificationModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/RequestHandler.dart';
import '../data/StateModel.dart';

final NotificationProvider = StateNotifierProvider<NotificationNotifier, StateModel<List<NotificationModel>>>((ref) => NotificationNotifier(ref));



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
}