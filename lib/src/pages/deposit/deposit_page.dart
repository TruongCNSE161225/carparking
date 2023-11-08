import 'package:carparkingapp/src/pages/deposit/deposit_controller.dart';
import 'package:carparkingapp/src/pages/deposit/widgets/option_button.dart';
import 'package:carparkingapp/utils/number_utils.dart';
import 'package:carparkingapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DepositPage extends GetView<DepositController> {
  const DepositPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: bottomNavigate(),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        centerTitle: true,
        title: const Text('Nạp tiền'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.init();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 20.w, top: 15.h, bottom: 5.h),
                      child: Text(
                        'Nạp tiền vào',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 20.w),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 20.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: Colors.blue[900]!,
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Số tiền hiện tại:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18.sp),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Obx(
                              () => Text(
                                NumberUtils.vnd(
                                    controller.wallet.value.balance),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 20.w),
                      child: TextFormField(
                        controller: controller.depositController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          controller.onChangeTextValue();
                        },
                        decoration: InputDecoration(
                            hintText: '0đ',
                            labelText: 'Số tiền cần nạp',
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () {
                                  controller.clearText();
                                }),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                )),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text(
                'Từ nguồn tiền',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
              padding: EdgeInsets.only(left: 20.w),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r)),
              child: const Column(
                children: [
                  OptionButton(value: 'paypal', title: 'Thanh toán Paypal'),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  BottomAppBar bottomNavigate() {
    return BottomAppBar(
      child: Container(
        height: 70.h,
        color: Colors.white,
        child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Obx(() => ElevatedButton(
                onPressed: controller.moneyValue.value.isNotEmpty
                    ? controller.onPressed
                    : null,
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]),
                child: Text(
                  'Nạp tiền',
                  style: TextStyle(fontSize: 20.sp),
                )))),
      ),
    );
  }
}
