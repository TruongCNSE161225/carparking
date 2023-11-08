class ParkingSessionModal {
  String? id;
  String? createdDate;
  String? checkInTime;
  String? checkOutTime;
  String? guestName;
  String? guestPhone;
  String? status;
  List<String>? checkInCapture;
  List<String>? checkOutCapture;
  String? vehicleId;
  String? parkingSlotId;
  VehicleSnapShot? vehicleSnapShot;
  ParkingSlotSnapShot? parkingSlotSnapShot;

  ParkingSessionModal(
      {this.id,
      this.createdDate,
      this.checkInTime,
      this.checkOutTime,
      this.guestName,
      this.guestPhone,
      this.status,
      this.checkInCapture,
      this.checkOutCapture,
      this.vehicleId,
      this.parkingSlotId,
      this.vehicleSnapShot,
      this.parkingSlotSnapShot});

  ParkingSessionModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = json['createdDate'];
    checkInTime = json['checkInTime'];
    checkOutTime = json['checkOutTime'];
    guestName = json['guestName'];
    guestPhone = json['guestPhone'];
    status = json['status'];
    checkInCapture = json['checkInCapture'].cast<String>();
    checkOutCapture = json['checkOutCapture'].cast<String>();
    vehicleId = json['vehicleId'];
    parkingSlotId = json['parkingSlotId'];
    vehicleSnapShot = json['vehicleSnapShot'] != null
        ? new VehicleSnapShot.fromJson(json['vehicleSnapShot'])
        : null;
    parkingSlotSnapShot = json['parkingSlotSnapShot'] != null
        ? new ParkingSlotSnapShot.fromJson(json['parkingSlotSnapShot'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdDate'] = this.createdDate;
    data['checkInTime'] = this.checkInTime;
    data['checkOutTime'] = this.checkOutTime;
    data['guestName'] = this.guestName;
    data['guestPhone'] = this.guestPhone;
    data['status'] = this.status;
    data['checkInCapture'] = this.checkInCapture;
    data['checkOutCapture'] = this.checkOutCapture;
    data['vehicleId'] = this.vehicleId;
    data['parkingSlotId'] = this.parkingSlotId;
    if (this.vehicleSnapShot != null) {
      data['vehicleSnapShot'] = this.vehicleSnapShot!.toJson();
    }
    if (this.parkingSlotSnapShot != null) {
      data['parkingSlotSnapShot'] = this.parkingSlotSnapShot!.toJson();
    }
    return data;
  }
}

class VehicleSnapShot {
  String? id;
  String? name;
  String? licensePlate;
  String? color;
  bool? checkin;
  List<String>? images;
  int? vehicleTypeId;
  String? vehicleTypeName;
  double? vehicleTypePrice;
  String? parkingSessionActive;

  VehicleSnapShot(
      {this.id,
      this.name,
      this.licensePlate,
      this.color,
      this.checkin,
      this.images,
      this.vehicleTypeId,
      this.vehicleTypeName,
      this.vehicleTypePrice,
      this.parkingSessionActive});

  VehicleSnapShot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    licensePlate = json['licensePlate'];
    color = json['color'];
    checkin = json['checkin'];
    images = json['images'].cast<String>();
    vehicleTypeId = json['vehicleTypeId'];
    vehicleTypeName = json['vehicleTypeName'];
    vehicleTypePrice = json['vehicleTypePrice'];
    parkingSessionActive = json['parkingSessionActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['licensePlate'] = this.licensePlate;
    data['color'] = this.color;
    data['checkin'] = this.checkin;
    data['images'] = this.images;
    data['vehicleTypeId'] = this.vehicleTypeId;
    data['vehicleTypeName'] = this.vehicleTypeName;
    data['vehicleTypePrice'] = this.vehicleTypePrice;
    data['parkingSessionActive'] = this.parkingSessionActive;
    return data;
  }
}

class ParkingSlotSnapShot {
  String? id;
  String? name;
  int? rowIndex;
  int? columnIndex;
  bool? hasParking;
  String? parkingId;

  ParkingSlotSnapShot(
      {this.id,
      this.name,
      this.rowIndex,
      this.columnIndex,
      this.hasParking,
      this.parkingId});

  ParkingSlotSnapShot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rowIndex = json['rowIndex'];
    columnIndex = json['columnIndex'];
    hasParking = json['hasParking'];
    parkingId = json['parkingId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rowIndex'] = this.rowIndex;
    data['columnIndex'] = this.columnIndex;
    data['hasParking'] = this.hasParking;
    data['parkingId'] = this.parkingId;
    return data;
  }
}
