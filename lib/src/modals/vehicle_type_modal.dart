class VehicleTypeModal {
  int? id;
  String? name;

  VehicleTypeModal({
    this.id,
    this.name,
  });

  VehicleTypeModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
