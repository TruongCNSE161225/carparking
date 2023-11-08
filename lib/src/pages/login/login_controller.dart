// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:carparkingapp/src/modals/user_modal.dart';
import 'package:carparkingapp/utils/constants.dart';
import 'package:carparkingapp/utils/date_time_utils.dart';
import 'package:carparkingapp/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  Future<void> signInWithGoogle(BuildContext context) async {
    Utils.loading(context);
    try {
      var prefs = await SharedPreferences.getInstance();
      await GoogleSignIn().signOut();
      prefs.clear();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      final user = FirebaseAuth.instance.currentUser;
      final token = await user!.getIdToken();
      prefs.setString('token', "$token");
      loginApi(token!);
    } catch (error) {}
  }

  Future<void> loginApi(String token) async {
    final response = await http.get(
      Uri.parse("${Constants.baseUrl}users/details"),
      headers: Constants.header(token),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));
      var data = UserModal.fromJson(result['data']);
      var prefs = await SharedPreferences.getInstance();
      prefs.setString('user', json.encode(data.toJson()));
      Get.back();
      return Get.toNamed('/main');
    } else {
      registerApi(token);
    }
  }

  Future<void> registerApi(String token) async {
    final response = await http.post(
      Uri.parse("${Constants.baseUrlAuth}register"),
      headers: Constants.header(token),
      body: jsonEncode({}),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));
      var data = UserModal.fromJson(result['data']);
      var prefs = await SharedPreferences.getInstance();
      prefs.setString('user', json.encode(data.toJson()));

      final user = FirebaseAuth.instance.currentUser;
      final token = await user!.getIdToken(true);
      prefs.setString('token', "$token");
      Get.back();
      return Get.toNamed('/main');
    }
  }

  void init() {
    checkTokenValid();
  }

  Future<void> checkTokenValid() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) return;
    Map<String, dynamic> payload = Jwt.parseJwt(token.toString());
    DateTime? exp = DateTimeUtils.parseDateTime(payload['exp']);
    if (exp != null && exp.compareTo(DateTime.now()) > 0) {
      Get.toNamed('/main');
    } else {
      return;
    }
  }
}
