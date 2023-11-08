import 'package:carparkingapp/src/pages/history/history_controller.dart';
import 'package:get/get.dart';

class HistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryController());
  }
}
