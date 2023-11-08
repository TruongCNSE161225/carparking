import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:carparkingapp/src/modals/image_modal.dart';
import 'package:carparkingapp/src/modals/parking_session_modal.dart';
import 'package:carparkingapp/src/modals/vehicle_type_modal.dart';
import 'package:carparkingapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class Utils {
  static final regexLicensePlate = RegExp(r'\d{2}-[A-Z]\d \d{5}');

  static String hiddenPrice(dynamic price, bool hidden) {
    if (hidden) {
      return "******";
    }
    return price;
  }

  static Future<VehicleTypeModal> getVehicleTypeByString(String name) async {
    var prefs = await SharedPreferences.getInstance();
    VehicleTypeModal vehicleTypeModal = VehicleTypeModal();
    String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse("${Constants.baseUrl}vehicleTypes/list"),
      headers: Constants.header(token!),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));

      result['data'].forEach((element) {
        if (name.contains(element['name'])) {
          return vehicleTypeModal = VehicleTypeModal.fromJson(element);
        }
      });
    }
    return vehicleTypeModal;
  }

  static String checkEmpty(String text, String defaultValue) {
    if (text.isEmpty) {
      return defaultValue;
    }
    return text;
  }

  static void loading(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(color: Colors.blue[900]),
            ));
  }

  static void showDialogPopup(BuildContext context, String text) {
    Get.dialog(AlertDialog(
        title: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 40.sp,
        )));
  }

  static void showDialogOption(
      BuildContext context, String text, File file, Function()? onDelete) {
    Get.dialog(AlertDialog(
      title: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.file(
          file,
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Huỷ', style: TextStyle(color: Colors.white))),
        ElevatedButton(
            onPressed: onDelete,
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF064789)),
            child: const Text('Xoá', style: TextStyle(color: Colors.white))),
      ],
    ));
  }

  static void showDialogCheckInOrCheckOut(
      BuildContext context, String text, Function()? onClick) {
    Get.dialog(AlertDialog(
      title: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Huỷ', style: TextStyle(color: Colors.white))),
        ElevatedButton(
            onPressed: onClick,
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF064789)),
            child: const Text('Hiện mã QR',
                style: TextStyle(color: Colors.white))),
      ],
    ));
  }

  static Future<String> getSessionByVehicleId(String vehicleId) async {
    var prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse(
          "${Constants.baseUrl}parkingSession/list?vehicleId=$vehicleId&active=true"),
      headers: Constants.header(token!),
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(utf8.decode(response.bodyBytes));
      List<ParkingSessionModal> list = [];
      result['data'].forEach((element) {
        list.add(ParkingSessionModal.fromJson(element));
      });
      return list.first.id!;
    } else {}
    return "";
  }

  static void toast(String title, String messageText) {
    Get.snackbar(
      '',
      '',
      backgroundColor: Colors.blue[900],
      icon: Padding(
        padding: EdgeInsets.only(left: 18.w),
        child: Icon(
          size: 25.sp,
          Icons.warning_amber_outlined,
          color: Colors.white,
        ),
      ),
      titleText: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25.sp),
        ),
      ),
      borderRadius: 9.r,
      messageText: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: Text(
          messageText,
          style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              fontSize: 20.sp),
        ),
      ),
      margin: EdgeInsets.only(left: 10.w, bottom: 10.h, right: 10.w),
      padding: EdgeInsets.only(
        left: 0.w,
        top: 17.h,
        right: 18.w,
        bottom: 17.h,
      ),
      duration: const Duration(seconds: 5),
    );
  }

  static Future<void> handleError401() async {
    var prefs = await SharedPreferences.getInstance();
    await GoogleSignIn().signOut();
    prefs.clear();
    Get.offAllNamed('/login');
  }

  static Future<String> uploadImage(File? file) async {
    var postUri = Uri.parse('${Constants.baseUrlMedia}public/upload');
    http.MultipartRequest request = http.MultipartRequest("POST", postUri);
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('file', file!.path);
    request.fields['fileType'] = 'AVATAR';
    request.files.add(multipartFile);
    final streamResponse = await request.send();
    final responseImage = await http.Response.fromStream(streamResponse);
    if (responseImage.statusCode == 200) {
      Map<String, dynamic> result =
          jsonDecode(utf8.decode(responseImage.bodyBytes));
      ImageModal image = ImageModal.fromJson(result['data']);
      return image.previewUrl!;
    } else {
      return '';
    }
  }

  static String checkTypeTransaction(
      String type, String ifTrue, String ifFalse) {
    if (type == 'PAYMENT') return ifFalse;
    return ifTrue;
  }
}
