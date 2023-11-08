import 'package:carparkingapp/src/pages/deposit/deposit_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';

class DepositBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DepositController());
  }
}
