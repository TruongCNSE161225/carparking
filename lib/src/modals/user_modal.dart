class UserModal {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? avatar;
  bool? active;
  String? username;
  String? groupId;
  String? address;
  String? dateOfBirth;
  String? gender;
  String? idCardNo;
  String? idCardIssuedDate;
  String? idCardIssuedBy;

  UserModal(String? string, 
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.avatar,
      this.active,
      this.username,
      this.groupId,
      this.address,
      this.dateOfBirth,
      this.gender,
      this.idCardNo,
      this.idCardIssuedDate,
      this.idCardIssuedBy});

  UserModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
    active = json['active'];
    username = json['username'];
    groupId = json['groupId'];
    address = json['address'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    idCardNo = json['idCardNo'];
    idCardIssuedDate = json['idCardIssuedDate'];
    idCardIssuedBy = json['idCardIssuedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['active'] = active;
    data['username'] = username;
    data['groupId'] = groupId;
    data['address'] = address;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    data['idCardNo'] = idCardNo;
    data['idCardIssuedDate'] = idCardIssuedDate;
    data['idCardIssuedBy'] = idCardIssuedBy;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
