import 'package:carparkingapp/src/pages/history/history_controller.dart';
import 'package:carparkingapp/utils/date_time_utils.dart';
import 'package:carparkingapp/utils/number_utils.dart';
import 'package:carparkingapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HistoryPage extends GetView<HistoryController> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[900],
        elevation: 0,
        title: const Text(
          'Lịch sử gửi xe',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        controller: controller.scrollController,
        itemCount: controller.orders.value.content?.length ?? 0,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
            color: index % 2 == 0 ? Colors.white : Colors.grey[200],
            child: Row(
              children: [
                Icon(
                  Icons.receipt_rounded,
                  // Icons.monetization_on_rounded,
                  color: Colors.blue[900],
                  size: 60.sp,
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Utils.checkTypeTransaction(
                            controller
                                .orders.value.content![index].transactionType
                                .toString(),
                            'Nạp tiền vào tài khoản',
                            'Thanh toán phí gửi xe'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateTimeUtils.formatDate(controller
                                    .orders.value.content![index].createdDate!),
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 18.sp),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                'Số dư: ${NumberUtils.vnd(controller.orders.value.content?[index].balance)}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18.sp),
                              ),
                            ],
                          ),
                          Text(
                            Utils.checkTypeTransaction(
                                controller.orders.value.content![index]
                                    .transactionType
                                    .toString(),
                                '+${NumberUtils.vnd(controller.orders.value.content?[index].amount)}',
                                '-${NumberUtils.vnd(controller.orders.value.content?[index].amount)}'),
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20.sp),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
