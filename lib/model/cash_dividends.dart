// ignore_for_file: public_member_api_docs, sort_constructors_first
class CashDividends {

  ///ativo emitido
  String? assetIssued;
  ///data de pagamento
  String? paymentDate;
  ///taxa
  num? rate;
  ///relativo a
  String? relatedTo;
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
 

  CashDividends(
      {this.assetIssued,
      this.paymentDate,
      this.rate,
      this.relatedTo,
      this.approvedOn,
      this.isinCode,
      this.label,
      this.lastDatePrior,
      this.remarks});

  CashDividends.fromJson(Map<String, dynamic> json) {
    assetIssued = json['assetIssued'];
    paymentDate = json['paymentDate'];
    rate = json['rate'];
    relatedTo = json['relatedTo'];
    approvedOn = json['approvedOn'];
    isinCode = json['isinCode'];
    label = json['label'];
    lastDatePrior = json['lastDatePrior'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assetIssued'] = assetIssued;
    data['paymentDate'] = paymentDate;
    data['rate'] = rate;
    data['relatedTo'] = relatedTo;
    data['approvedOn'] = approvedOn;
    data['isinCode'] = isinCode;
    data['label'] = label;
    data['lastDatePrior'] = lastDatePrior;
    data['remarks'] = remarks;
    return data;
  }

  @override
  String toString() {
    return """{
     assetIssued: $assetIssued,\n
     paymentDate: $paymentDate,\n
     rate: $rate,\n
     relatedTo: $relatedTo,\n
     approvedOn: $approvedOn,\n
     isinCode: $isinCode,\n
     label: $label,\n
     lastDatePrior: $lastDatePrior,\n
     remarks: $remarks}""";
  }
}
