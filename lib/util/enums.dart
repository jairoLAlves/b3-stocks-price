

enum StatusGetStocks{
start, loading, success, error
}

enum TypesGraphic {
  hiloOpenClose,
  candle,
  line,
}



enum sectors {
  Communications, //Comunicações,
  Finance, //Finança,
  Retail_Trade, //Comercio de varejo,
  Health_Services, //Serviços de saúde,
  Energy_Minerals, //Minerais Energéticos,
  Commercial_Services, //Serviços comerciais,
  Consumer_Non_Durables, //Consumo Não Duráveis,
  Non_Energy_Minerals, //Minerais Não Energéticos,
  Consumer_Services, //Serviços do Consumidor,
  Others, //Outros,
  Process_Industries, //Indústrias de processo,
  Transportation, //Transporte,
  Utilities, //Serviços de utilidade pública,
  Electronic_Technology, //Tecnologia Eletrônica,
  Consumer_Durables, //Bens de Consumo Duráveis,
  Miscellaneous, //Diversos,
  Technology_Services, //Serviços de tecnologia,
  Distribution_Services, //Serviços de distribuição,
  Health_Technology, //Tecnologia em Saúde,
  Producer_Manufacturing, //Fabricação do Produtor,
  Industrial_Services,
  sector, //Serviços Industriais,
  All,
}

enum PriceTipes {
  open,
  high,
  low,
  close,
}

enum StocksSortBy {
  name,
  close,
  change,
  //change_abs,
  volume,
  market_cap_basic,
  sector,
  stock,
}

enum ValidRangesEnum {
  one_d,
  five_d,
  one_m,
  three_m,
  six_m,
  one_y,
  two_y,
  five_y,
  ten_y,
  ytd,
  max,
}

String? getValidRangeString(ValidRangesEnum validRangesEnum) {
  const validRangesList = <String>[
    "1d",
    "5d",
    "1mo",
    "3mo",
    "6mo",
    "1y",
    "2y",
    "5y",
    "10y",
    "ytd",
    "max"
  ];

  switch (validRangesEnum) {
    case ValidRangesEnum.one_d:
      return validRangesList[0];
    case ValidRangesEnum.five_d:
      return validRangesList[1];
    case ValidRangesEnum.one_m:
      return validRangesList[2];
    case ValidRangesEnum.three_m:
      return validRangesList[3];
    case ValidRangesEnum.six_m:
      return validRangesList[4];
    case ValidRangesEnum.one_y:
      return validRangesList[5];
    case ValidRangesEnum.two_y:
      return validRangesList[6];
    case ValidRangesEnum.five_y:
      return validRangesList[7];
    case ValidRangesEnum.ten_y:
      return validRangesList[8];
    case ValidRangesEnum.ytd:
      return validRangesList[9];
    case ValidRangesEnum.max:
      return validRangesList[10];
  }
}
