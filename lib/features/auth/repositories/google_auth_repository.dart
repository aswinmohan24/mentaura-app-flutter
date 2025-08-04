import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthRepository {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  GoogleAuthRepository({required this.auth, required this.googleSignIn});

  Future<UserCredential?> signInWithGoogle(
      BuildContext context, WidgetRef ref) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        log('User canceled Google sign-in');
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final userCredential = await auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      log('Google sign in failed: $e');
      throw Exception("Google sign in failed");
    }
  }

  Future<void> signOutFromGoogle() async {
    try {
      await auth.signOut();

      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();

        try {
          await googleSignIn.disconnect();
        } catch (e) {
          log("Google disconnect failed (safe to ignore): $e");
        }

        log("Google Sign out successful");
      }
    } catch (e) {
      log("Sign out error: $e");
    }
  }
}
