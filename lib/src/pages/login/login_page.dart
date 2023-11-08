import 'package:carparkingapp/src/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 75.h),
            child: Image.asset("assets/images/login-background.png"),
          ),
          Expanded(
              child: Container(
            color: const Color(0xFFE7EDF4),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70.w, vertical: 60.h),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(6, 71, 137, 1),
                        shape: const StadiumBorder()),
                    onPressed: () {
                      controller.signInWithGoogle(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(4.r),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/google.png',
                            height: 35.h,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 15.w),
                              child: const Text('Đăng nhập với Google')),
                        ],
                      ),
                    )),
              ),
            ]),
          ))
        ],
      ),
    ));
  }
}
