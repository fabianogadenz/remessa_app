class SimulatorRequestModel {
  int idOperationType;
  bool reverse;
  double quantity;
  double totalValue;
  int idCurrency;
  String abbreviation;
  int idBeneficiary;
  String voucherCode;

  SimulatorRequestModel({
    this.idOperationType,
    this.reverse,
    this.quantity,
    this.totalValue,
    this.idCurrency,
    this.abbreviation,
    this.idBeneficiary,
    this.voucherCode,
  });

  SimulatorRequestModel.fromJson(Map<String, dynamic> json) {
    idOperationType = json['idOperationType'];
    reverse = json['reverse'];
    quantity = json['quantity'];
    totalValue = json['totalValue'];
    idCurrency = json['idCurrency'];
    abbreviation = json['abbreviation'];
    idBeneficiary = json['idBeneficiary'];
    voucherCode = json['voucherCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (idOperationType != null) data['idOperationType'] = this.idOperationType;
    if (voucherCode != null) data['voucherCode'] = this.voucherCode;

    data['reverse'] = this.reverse;
    data['quantity'] = this.quantity;
    data['totalValue'] = this.totalValue;
    data['idCurrency'] = this.idCurrency;
    data['abbreviation'] = this.abbreviation;
    data['idBeneficiary'] = this.idBeneficiary;
    return data;
  }
}
