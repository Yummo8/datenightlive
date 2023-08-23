import 'package:firebase_auth/firebase_auth.dart';
import 'package:DNL/common/utils/logger.dart';

class AuthRepository {
  User? authedUser = FirebaseAuth.instance.currentUser;

  String _verificationId = "";
  bool codeSent = false;

  Future<void> signInWithPhone(String phoneNumber,
      {required Function codeSentCallback}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signOut();
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto sign-in on Android devices.
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            logger.e('The provided phone number is not valid.');
          } else {
            logger.e('FirebaseAuthException Phone: $e');
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Save the verification ID somewhere so that you can use it later.
          _verificationId = verificationId;
          logger.i("_verificationId $verificationId");
          codeSentCallback();
        },
        timeout: const Duration(seconds: 120),
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
          logger.e('Phone Auth codeAutoRetrievalTimeout');
        },
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> verifyOTP(String smsCode) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: smsCode);

      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
