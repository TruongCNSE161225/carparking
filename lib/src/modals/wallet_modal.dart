class WalletModal {
  String? id;
  double? balance;
  double? debt;
  String? userId;

  WalletModal({this.id, this.balance, this.debt, this.userId});

  WalletModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    balance = json['balance'];
    debt = json['debt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['balance'] = balance;
    data['debt'] = debt;
    data['userId'] = userId;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
