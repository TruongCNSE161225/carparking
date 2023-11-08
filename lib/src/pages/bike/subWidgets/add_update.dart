import 'package:carparkingapp/src/modals/vehicle_modal.dart';
import 'package:carparkingapp/src/pages/bike/bike_controller.dart';
import 'package:carparkingapp/src/widgets/inputText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddUpdateBike extends GetView<BikeController> {
  bool isAdd;
  VehicleModal? vehicleModal;

  AddUpdateBike({super.key, required this.isAdd, this.vehicleModal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120.w,
                height: 3.h,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25.r)),
              ),
              InputText(
                  text: 'Biển số xe',
                  controller: controller.licensePlateController),
              InputText(text: 'Tên xe', controller: controller.nameController),
              InputText(text: 'Màu xe', controller: controller.colorController),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Chọn loại xe:',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20.sp,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownMenu(
                  initialSelection: controller.dropdownValue,
                  onSelected: (value) {
                    controller.dropdownValue = value.toString();
                  },
                  dropdownMenuEntries: controller.list
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Hình ảnh xe:',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20.sp,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Obx(
                () => SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var i = 0; i < controller.images.length; i++)
                          Padding(
                            padding: EdgeInsets.only(right: 25.w),
                            child: InkWell(
                              onTap: () {
                                controller.removeImageByIndex(context, i);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.file(
                                  controller.images.values.toList()[i],
                                ),
                              ),
                            ),
                          ),
                        controller.images.length != 2
                            ? InkWell(
                                onTap: () {
                                  controller.pickImageFromGallery();
                                },
                                child: Container(
                                  width: 70.w,
                                  height: 70.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 40.sp,
                                    color: Colors.blue[900],
                                  ),
                                ))
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () async {
                  if (controller.formKey.currentState!.validate()) {
                    controller.addAndUpdateVehicle(isAdd,
                        vehicleModal: vehicleModal);
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(15.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF064789),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      isAdd ? "Thêm phương tiện" : "Cập nhật phương tiện",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
