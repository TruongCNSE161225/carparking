import 'package:carparkingapp/src/pages/bike/bike_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRBike extends GetView<BikeController> {
  String? sessionId;

  QRBike({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Đưa mã này cho bản vệ quét',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            width: MediaQuery.of(Get.context!).size.width,
            height: MediaQuery.of(Get.context!).size.height / 3,
            child: QrImageView(
              data: sessionId!,
              version: QrVersions.auto,
            ),
          )
        ],
      ),
    );
  }
}
