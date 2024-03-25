
import 'package:aqary/data/services/FiresbaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/RequestHandler.dart';
import '../helper/Authentication.dart';

final authenticationProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final VerficationProvider = StateProvider<String?>((ref){
  return "";
});

final authStateProvider = StreamProvider.autoDispose<User?>((ref) {
  final firebaseAuth = ref.watch(fireBaseAuthProvider);
  return firebaseAuth.authStateChanges();
});

final fireBaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final loadingState = StateProvider<bool>((ref) => false);

final otpVaild = StateProvider((ref) => false);

final loginStateProvider = StateProvider<AsyncValue<void>>((ref) {
  return AsyncValue.data(null);
});

final loginProvider = Provider<AsyncValue<void>>((ref) {
  return ref.watch(loginStateProvider);
});

class AuthViewModel {
  Future<String?> login(String phone, String firebaseId) async {
    RequestHandler requestHandler = RequestHandler();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseServices services = FirebaseServices();

    String? token;
    String? deviceToken;

    deviceToken = await services.getFCMToken();
    await prefs.setString('deviceToken', deviceToken!);


    Map<String, String> data = {
      "phone": phone,
      'firebase_id': firebaseId,
      'device_token': deviceToken,
    };
    Map? responseModel = await requestHandler.postData(
        endPoint: '/auth',
        auth: false,
        requestBody: data
    );

    token = responseModel["token"];
    await prefs.setString('token', token!);

    return token;
  }
}