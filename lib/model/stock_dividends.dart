// ignore_for_file: public_member_api_docs, sort_constructors_first
class StockDividends {

  ///ativo emitido
  String? assetIssued;
  ///fator
  num? factor;
  ///aprovado em
  String? approvedOn;
  ///código está em
  String? isinCode;
  ///rótulo
  String? label;
  ///última data anterior
  String? lastDatePrior;
  ///observações
  String? remarks;

  StockDividends(
      {this.assetIssued,
      this.factor,
      this.approvedOn,
      this.isinCode,
      this.label,
      this.lastDatePrior,
      this.remarks});

  StockDividends.fromJson(Map<String, dynamic> json) {
    assetIssued = json['assetIssued'];
    factor = json['factor'];
    approvedOn = json['approvedOn'];
    isinCode = json['isinCode'];
    label = json['label'];
    lastDatePrior = json['lastDatePrior'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assetIssued'] = assetIssued;
    data['factor'] = factor;
    data['approvedOn'] = approvedOn;
    data['isinCode'] = isinCode;
    data['label'] = label;
    data['lastDatePrior'] = lastDatePrior;
    data['remarks'] = remarks;
    return data;
  }

  @override
  String toString() {
    return 'assetIssued: $assetIssued, factor: $factor, approvedOn: $approvedOn, isinCode: $isinCode, label: $label, lastDatePrior: $lastDatePrior, remarks: $remarks)';
  }
}
