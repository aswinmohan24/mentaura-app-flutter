import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentaura_app/core/constants/constants.dart';
import 'package:mentaura_app/features/auth/models/user.details.model.dart';
import 'package:http/http.dart' as http;

class UserAuthRepository {
  Future<void> createUser(UserDetails userDetails) async {
    try {
      final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
      Map<String, String>? headers = {
        'Authorization': "Bearer ${userToken!}",
        'Content-Type': 'application/json',
      };

      final response = await http.post(Uri.parse("$baseUrl/createuser"),
          headers: headers, body: jsonEncode(userDetails.toMap()));
      if (response.statusCode == 201) {
        log("User Created successfully");
      } else {
        log("Failed to create user ${response.body}");
      }
    } catch (e) {
      log("Error creating user $e");
    }
  }

  Future<UserDetails?> getUser() async {
    try {
      final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
      Map<String, String>? headers = {
        'Authorization': "Bearer ${userToken!}",
        'Content-Type': 'application/json',
      };

      final response =
          await http.get(Uri.parse("$baseUrl/getuser"), headers: headers);
      if (response.statusCode == 200) {
        final userReponse = jsonDecode(response.body);

        return UserDetails.fromMap(userReponse["user"]);
      } else {
        return null;
      }
    } catch (e) {
      log("Error occured when getting user details $e");
      rethrow;
    }
  }

  Future<void> detelteUser() async {
    try {
      final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
      Map<String, String>? headers = {
        'Authorization': "Bearer ${userToken!}",
        'Content-Type': 'application/json',
      };
      final response =
          await http.delete(Uri.parse("$baseUrl/deleteuser"), headers: headers);
      if (response.statusCode == 200) {
        log("User deleted successfully");
      } else {
        log("Failed to delete user ${response.body}");
      }
    } catch (e) {
      log("Error occured when deleting user");
    }
  }
}
