class VehicleModal {
  String? id;
  String? name;
  String? licensePlate;
  String? color;
  bool? checkin;
  List<String>? images;
  int? vehicleTypeId;
  String? vehicleTypeName;

  VehicleModal(
      {this.id,
      this.name,
      this.licensePlate,
      this.color,
      this.checkin,
      this.images,
      this.vehicleTypeId,
      this.vehicleTypeName});

  VehicleModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    licensePlate = json['licensePlate'];
    color = json['color'];
    checkin = json['checkin'];
    images = json['images'].cast<String>();
    vehicleTypeId = json['vehicleTypeId'];
    vehicleTypeName = json['vehicleTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['licensePlate'] = licensePlate;
    data['color'] = color;
    data['checkin'] = checkin;
    data['images'] = images;
    data['vehicleTypeId'] = vehicleTypeId;
    data['vehicleTypeName'] = vehicleTypeName;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
