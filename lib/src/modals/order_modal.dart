class OrderModal {
  List<Content>? content;
  int? pageNumber;
  int? pageSize;
  int? totalElements;

  OrderModal(
      {this.content, this.pageNumber, this.pageSize, this.totalElements});

  OrderModal.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(new Content.fromJson(v));
      });
    }
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    totalElements = json['totalElements'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['totalElements'] = this.totalElements;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Content {
  String? createdBy;
  String? createdDate;
  String? lastModifiedBy;
  String? lastModifiedDate;
  String? id;
  String? userEmail;
  double? balance;
  double? amount;
  String? status;
  String? transactionType;

  Content(
      {this.createdBy,
      this.createdDate,
      this.lastModifiedBy,
      this.lastModifiedDate,
      this.id,
      this.userEmail,
      this.balance,
      this.amount,
      this.status,
      this.transactionType});

  Content.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    lastModifiedBy = json['lastModifiedBy'];
    lastModifiedDate = json['lastModifiedDate'];
    id = json['id'];
    userEmail = json['userEmail'];
    balance = json['balance'];
    amount = json['amount'];
    status = json['status'];
    transactionType = json['transactionType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['lastModifiedDate'] = this.lastModifiedDate;
    data['id'] = this.id;
    data['userEmail'] = this.userEmail;
    data['balance'] = this.balance;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['transactionType'] = this.transactionType;
    return data;
  }
}
