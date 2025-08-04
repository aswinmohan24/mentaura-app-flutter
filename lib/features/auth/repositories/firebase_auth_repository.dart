import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mentaura_app/features/auth/presentation/screens/otp.screen.dart';

class FirebaseAuthRepository {
  final FirebaseAuth auth;

  FirebaseAuthRepository({required this.auth});

  Stream<User?> get authStateChanges => auth.authStateChanges();

  void signInwithPhoneNumber(
      {required String phoneNumber,
      required BuildContext context,
      bool? isResend = false}) async {
    try {
      auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (credentail) {},
          verificationFailed: (exception) {
            Fluttertoast.showToast(msg: "Something went wrong plese try again");
          },
          codeSent: (verificationID, token) {
            if (isResend != true) {
              Navigator.pop(context);
              Navigator.pushNamed(context, OtpScreen.routeName, arguments: {
                "verificationId": verificationID,
                "phoneNumber": phoneNumber
              });
            }
          },
          codeAutoRetrievalTimeout: (toke) {});
    } catch (e) {
      log("Error occured in firebase login $e");
    }
  }

  Future<UserCredential> verifyOtp({
    required String verficationId,
    required String userOtp,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verficationId, smsCode: userOtp);
      final userCredential = await auth.signInWithCredential(credential);
      return userCredential;
    } on FirebaseAuthException catch (err) {
      debugPrint(err.code);
      debugPrint("${err.message}");
      if (err.code == "invalid-verification-code") {
        Fluttertoast.showToast(msg: 'Invalid OTP. Please try again !');
        rethrow;
      } else {
        Fluttertoast.showToast(msg: '${err.message} !');
        rethrow;
      }
    } catch (e) {
      log("Unable to verify user $e");
      throw Exception("Error occured when sign in");
    }
  }

  Future<void> signOutFromFirebase() async {
    await auth.signOut();
  }
}
