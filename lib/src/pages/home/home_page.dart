import 'package:carparkingapp/src/pages/home/home_controller.dart';
import 'package:carparkingapp/src/widgets/dash_line.dart';
import 'package:carparkingapp/utils/number_utils.dart';
import 'package:carparkingapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.init();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarHome(),
        body: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5.r,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 15.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          iconText(Icons.monetization_on_rounded, "Nạp tiền",
                              () {
                            controller.deposit();
                          }),
                          iconText(Icons.wallet, "Rút tiền", () {}),
                          iconText(Icons.qr_code, "Nhận tiền", () {}),
                          iconText(
                              Icons.attach_money_rounded, "Chuyển tiền", () {}),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: const DashLine(
                        color: Colors.grey,
                      ),
                    ),
                    Obx(() => Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    controller.visionPrice.value =
                                        !controller.visionPrice.value;
                                  },
                                  icon: Icon(controller.visionPrice.value
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_outlined)),
                              Obx(
                                () => SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    Utils.hiddenPrice(
                                        NumberUtils.vnd(
                                            controller.wallet.value.balance),
                                        controller.visionPrice.value),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget iconText(IconData icon, String text, Function()? onPressed) {
    return Column(
      children: [
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: Colors.blue[900],
            )),
        Text(
          text,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 13.sp),
        )
      ],
    );
  }

  AppBar appBarHome() {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0575E6),
              Color(0xFF021B79),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: TextField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          hintText: 'Tìm kiếm...',
          hintStyle: TextStyle(color: Colors.white54),
          border: InputBorder.none,
        ),
        onChanged: (value) {},
      ),
      leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
          )),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
            ))
      ],
    );
  }
}
