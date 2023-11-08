import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:carparkingapp/src/modals/parking_session_modal.dart';
import 'package:carparkingapp/src/modals/vehicle_modal.dart';
import 'package:carparkingapp/src/modals/vehicle_type_modal.dart';
import 'package:carparkingapp/src/pages/bike/subWidgets/add_update.dart';
import 'package:carparkingapp/src/pages/bike/subWidgets/qr_bike.dart';
import 'package:carparkingapp/utils/constants.dart';
import 'package:carparkingapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BikeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late Rx<List<VehicleModal>> vehicles = Rx([]);
  late List<File?> imageList = [];
  final _selectedImage = {}.obs;
  List<String> list = <String>['Xe Máy', 'Xe Đạp', 'Xe Ô tô'];
  String dropdownValue = 'Xe Máy';
  Timer? timerCheck;
  TextEditingController licensePlateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  void init() {
    fetchApiBike();
  }

  get images => _selectedImage;

  Future<String> checkInVehicle(VehicleModal vehicleModal) async {
    var prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response =
        await http.post(Uri.parse("${Constants.baseUrl}parkingSession/checkIn"),
            headers: Constants.header(token!),
            body: jsonEncode({
              "vehicleId": vehicleModal.id,
            }));
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));
      ParkingSessionModal data = ParkingSessionModal.fromJson(result['data']);
      return data.id.toString();
    } else if (response.statusCode == 401) {
      Utils.handleError401();
    }
    return "";
  }

  Future<void> onClick(VehicleModal vehicleModal, BuildContext context) async {
    Utils.showDialogCheckInOrCheckOut(context, 'Xác nhận hiện mã QR', () {
      Get.back();
      getSessionShowQR(vehicleModal, context);
    });
  }

  Future<void> getSessionShowQR(
      VehicleModal vehicleModal, BuildContext context) async {
    String resultSessionId;
    Utils.loading(context);
    if (vehicleModal.checkin!) {
      resultSessionId = await Utils.getSessionByVehicleId(vehicleModal.id!);
      await initCheckOut(resultSessionId);
    } else {
      resultSessionId = await checkInVehicle(vehicleModal);
    }
    Get.back();
    Get.dialog(AlertDialog(
      title: Text(
        'Mã QR cho xe: ${vehicleModal.licensePlate}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: QRBike(sessionId: resultSessionId),
      actions: <Widget>[
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              timerCheck?.cancel();
              Get.back();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(fontWeight: FontWeight.w600),
            ))
      ],
    )).then((value) => {
          timerCheck?.cancel(),
        });
    timerCheck =
        Timer.periodic(const Duration(seconds: 5), (Timer timer) async {
      bool? resultNew = vehicles.value
          .where((element) => element.id == vehicleModal.id)
          .first
          .checkin;
      if (vehicleModal.checkin != resultNew) {
        timerCheck?.cancel();
        Get.back();
        Utils.showDialogPopup(
          context,
          'Đã xác nhận',
        );
      }
      fetchApiBike();
    });
  }

  @override
  void dispose() {
    timerCheck?.cancel();
    super.dispose();
  }

  void clearTextField() {
    licensePlateController.text = "";
    nameController.text = "";
    colorController.text = "";
  }

  void addUpdateBike(context, bool isAdd, {VehicleModal? vehicleModal}) {
    _selectedImage.clear();
    if (!isAdd) {
      licensePlateController.text = vehicleModal!.licensePlate!;
      nameController.text = vehicleModal.name!;
      colorController.text = vehicleModal.color!;
    }
    if (isAdd) {
      clearTextField();
    }
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.r))),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddUpdateBike(isAdd: isAdd, vehicleModal: vehicleModal);
      },
    );
  }

  Future<void> addAndUpdateVehicle(bool isAdd,
      {VehicleModal? vehicleModal}) async {
    var response;
    var prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    VehicleTypeModal vehicleTypeId =
        await Utils.getVehicleTypeByString(dropdownValue);
    List<String> imageApi = [];

    if (imageList.isNotEmpty) {
      for (var i = 0; i < imageList.length; i++) {
        String result = await Utils.uploadImage(imageList[i]);
        imageApi.add(result);
      }
    }
    if (isAdd) {
      VehicleModal dataVehicle = VehicleModal(
        name: nameController.text,
        licensePlate: licensePlateController.text,
        color: colorController.text,
        images: imageApi,
        vehicleTypeId: vehicleTypeId.id,
        vehicleTypeName: vehicleTypeId.name,
      );
      response = await http.post(
        Uri.parse("${Constants.baseUrl}vehicle/create"),
        headers: Constants.header(token!),
        body: jsonEncode(dataVehicle),
      );
    } else if (!isAdd) {
      VehicleModal dataVehicle = VehicleModal(
        id: vehicleModal!.id,
        name: Utils.checkEmpty(nameController.text, vehicleModal.name!),
        licensePlate: Utils.checkEmpty(
            licensePlateController.text, vehicleModal.licensePlate!),
        color: Utils.checkEmpty(colorController.text, vehicleModal.color!),
        images: imageApi.isEmpty ? vehicleModal.images : imageApi,
      );
      response = await http.put(
        Uri.parse("${Constants.baseUrl}vehicle/update"),
        headers: Constants.header(token!),
        body: jsonEncode(dataVehicle),
      );
    }

    if (response.statusCode == 200) {
      imageList.clear();
      fetchApiBike();
      clearTextField();
      Get.back();
    } else {
      if ("VEHICLE_LICENSE_PLATE_ALREADY_EXISTS"
          .contains(jsonDecode(response.body)['message'])) {
        Utils.toast('Thông báo', 'Biển số này đã được đăng ký');
        licensePlateController.text = "";
      }
    }
  }

  Future<void> deleteVehicle(String id) async {
    var prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.delete(
      Uri.parse("${Constants.baseUrl}vehicle/$id/delete"),
      headers: Constants.header(token!),
    );
    if (response.statusCode == 200) {
      fetchApiBike();
    } else if (response.statusCode == 401) {
      Utils.handleError401();
    }
  }

  Future<void> fetchApiBike() async {
    var prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse("${Constants.baseUrl}vehicle/list"),
      headers: Constants.header(token!),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));
      List<dynamic> data = result['data'];
      List<VehicleModal> resultList = [];
      for (var p in data) {
        VehicleModal vehicle = VehicleModal.fromJson(p);
        resultList.add(vehicle);
      }
      vehicles(resultList);
      update();
    } else if (response.statusCode == 401) {
      Utils.handleError401();
    }
  }

  Future pickImageFromGallery() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      imageList.add(File(result.path));
      _selectedImage[_selectedImage.length + 1] = File(result.path);
    }
  }

  void removeImageByIndex(BuildContext context, int index) {
    Utils.showDialogOption(
        context, 'Xoá hình ảnh', images.values.toList()[index], () {
      Get.back();
      _selectedImage.remove(_selectedImage.keys.elementAt(index));
    });
  }

  Future<void> initCheckOut(String session) async {
    var prefs = await SharedPreferences.getInstance();
    String? paymentType = prefs.getString('paymentType');
    String? token = prefs.getString('token');
    final response = await http.post(
      Uri.parse("${Constants.baseUrl}parkingSession/initCheckOut"),
      headers: Constants.header(token!),
      body: jsonEncode({"sessionId": session, "paymentType": paymentType}),
    );
    if (response.statusCode == 200) {
    } else {}
  }
}
