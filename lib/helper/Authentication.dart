import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static var shared = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? ver;

  Stream<User?> authStateChanges() => auth.authStateChanges();
  
  Future<void> verifyPhone(phone) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (AuthCredential credential) {},
      verificationFailed: (FirebaseException e) {},
      codeSent: (String verificationID, int? forceResendingToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {
        ver = verificationId;
      },
      timeout: Duration(seconds: 45),
    );
  }

  Future<User?> verifyCode(String smsCode, verificationId) async {
    try {
      if (verificationId != null) {
        AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        );
        UserCredential userCredential = await auth.signInWithCredential(
            credential);

        return userCredential.user;
      }
    }catch(e){
      print(e);
    }

  }

  Future<void> resendCode(verificationId,phone) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phone, // Replace with the user's phone number
      timeout: Duration(seconds: 45),
      verificationCompleted: (PhoneAuthCredential credential) async {

      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failure
      },
      codeSent: (String verificationId, int? resendToken) async {
        verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {

      },
    );
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}