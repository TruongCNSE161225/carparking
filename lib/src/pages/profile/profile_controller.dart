import 'dart:convert';
import 'dart:io';
import 'package:carparkingapp/src/modals/user_modal.dart';
import 'package:carparkingapp/src/widgets/inputText.dart';
import 'package:carparkingapp/utils/constants.dart';
import 'package:carparkingapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  UserModal? user;
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  late File avatar = File('');

  Future<void> init() async {
    var prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      user = UserModal.fromJson(json.decode(userJson.toString()));
    }

    String? paymentType = prefs.getString('paymentType') ?? _paymentType;
    if (paymentType != null) setPaymentType(paymentType);
  }

  Future<void> signOut() async {
    var prefs = await SharedPreferences.getInstance();
    await GoogleSignIn().signOut();
    prefs.clear();
    Get.offAllNamed('/login');
  }

  void dialogConfirm() {
    Get.dialog(AlertDialog(
      title: const Text(
        'Đăng xuất',
      ),
      content: const Text("Bạn muốn đăng xuất?"),
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Huỷ', style: TextStyle(color: Colors.white))),
        ElevatedButton(
            onPressed: () {
              signOut();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF064789)),
            child:
                const Text('Đăng xuất', style: TextStyle(color: Colors.white))),
      ],
    ));
  }

  void editProfile(context) {
    nameController.text = user!.name ?? '';
    emailController.text = user!.email ?? '';
    phoneController.text = user!.phone ?? '';
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.r))),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: 120.w,
                    height: 3.h,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25.r)),
                  ),
                  InputText(text: 'Họ và tên', controller: nameController),
                  InputText(
                      text: 'Email',
                      controller: emailController,
                      enabled: false),
                  InputText(text: 'Số điện thoại', controller: phoneController),
                  GestureDetector(
                    onTap: () {
                      updateProfile();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(15.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFF064789),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'Cập nhật',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> updateProfile() async {
    Get.back();
    user!.name = nameController.text;
    user!.email = emailController.text;
    user!.phone = phoneController.text;
    var prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.put(
        Uri.parse("${Constants.baseUrl}users/update"),
        headers: Constants.header(token!),
        body: jsonEncode(user!.toJson()));
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));
      var data = UserModal.fromJson(result['data']);
      var prefs = await SharedPreferences.getInstance();
      prefs.setString('user', json.encode(data.toJson()));
      init();
    } else {}
  }

  Future editAvatar() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      String newAvatar = await Utils.uploadImage(File(result.path));
      user!.avatar = Constants.baseUrlImage + newAvatar;
      var prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final response = await http.put(
          Uri.parse("${Constants.baseUrl}users/update"),
          headers: Constants.header(token!),
          body: jsonEncode(user!.toJson()));

      if (response.statusCode == 200) {
        Map<String, dynamic> result =
            jsonDecode(utf8.decode(response.bodyBytes));
        var data = UserModal.fromJson(result['data']);
        var prefs = await SharedPreferences.getInstance();
        prefs.setString('user', json.encode(data.toJson()));
      } else {
        Utils.handleError401();
      }
    }
  }

  String _paymentType = 'E_WALLET';
  String get paymentType => _paymentType;

  Future<void> setPaymentType(String type) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('paymentType', type);
    _paymentType = type;
    update();
  }
}
