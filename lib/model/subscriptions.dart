// ignore_for_file: public_member_api_docs, sort_constructors_first
class Subscriptions {
  ///ativo emitido
  String? assetIssued;
  ///porcentagem
  num? percentage;
  ///unidade de preço
  num? priceUnit;
  ///Período de negociação
  String? tradingPeriod;
  ///data de assinatura
  String? subscriptionDate;
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

  Subscriptions(
      {this.assetIssued,
      this.percentage,
      this.priceUnit,
      this.tradingPeriod,
      this.subscriptionDate,
      this.approvedOn,
      this.isinCode,
      this.label,
      this.lastDatePrior,
      this.remarks});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    assetIssued = json['assetIssued'];
    percentage = json['percentage'];
    priceUnit = json['priceUnit'];
    tradingPeriod = json['tradingPeriod'];
    subscriptionDate = json['subscriptionDate'];
    approvedOn = json['approvedOn'];
    isinCode = json['isinCode'];
    label = json['label'];
    lastDatePrior = json['lastDatePrior'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assetIssued'] = assetIssued;
    data['percentage'] = percentage;
    data['priceUnit'] = priceUnit;
    data['tradingPeriod'] = tradingPeriod;
    data['subscriptionDate'] = subscriptionDate;
    data['approvedOn'] = approvedOn;
    data['isinCode'] = isinCode;
    data['label'] = label;
    data['lastDatePrior'] = lastDatePrior;
    data['remarks'] = remarks;
    return data;
  }


  @override
  String toString() {
    return 'assetIssued: $assetIssued, percentage: $percentage, priceUnit: $priceUnit, tradingPeriod: $tradingPeriod, subscriptionDate: $subscriptionDate, approvedOn: $approvedOn, isinCode: $isinCode, label: $label, lastDatePrior: $lastDatePrior, remarks: $remarks';
  }
}
