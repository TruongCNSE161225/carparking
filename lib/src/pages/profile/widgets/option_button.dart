import 'package:carparkingapp/src/pages/deposit/deposit_controller.dart';
import 'package:carparkingapp/src/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionButton extends StatelessWidget {
  final String value;
  final String title;

  const OptionButton({super.key, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return InkWell(
          onTap: () {
            controller.setPaymentType(value);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.white),
              ),
              Radio(
                value: value,
                fillColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                activeColor: Colors.white,
                groupValue: controller.paymentType,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (value) {
                  controller.setPaymentType(value!);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
