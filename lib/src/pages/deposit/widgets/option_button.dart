import 'package:carparkingapp/src/pages/deposit/deposit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionButton extends StatelessWidget {
  final String value;
  final String title;

  const OptionButton({super.key, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepositController>(
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
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Radio(
                value: value,
                activeColor: Colors.blue[900],
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
