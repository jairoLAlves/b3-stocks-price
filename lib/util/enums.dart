// ignore_for_file: constant_identifier_names, camel_case_types

enum StatusGetStocks { start, loading, success, error }

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
  one_mo,
  three_mo,
  six_mo,
  one_y,
  two_y,
  five_y,
  ten_y,
  ytd,
  max,
}
enum ValidIntervalEnum  {
  one_m,
  tow_m,
  five_m,
  fifteen_m,
  thirty_m,
  sixty_m,
  ninety_m,
  one_h,
  one_d,
  five_d,
  one_wk,
  one_mo,
  three_mo,

}




String getValidIntervalString(ValidIntervalEnum validIntervalEnum) =>
    switch (validIntervalEnum) {
      ValidIntervalEnum.one_m => "1m",
      ValidIntervalEnum.tow_m => "2m",
      ValidIntervalEnum.five_m => "5m",
      ValidIntervalEnum.fifteen_m => "15m",
      ValidIntervalEnum.thirty_m => "30m",
      ValidIntervalEnum.sixty_m => "60m",
      ValidIntervalEnum.ninety_m => "90m",
      ValidIntervalEnum.one_h => "1h",
      ValidIntervalEnum.one_d => "1d",
      ValidIntervalEnum.five_d => "5d",
      ValidIntervalEnum.one_wk => "1wk",
      ValidIntervalEnum.one_mo => "1mo",
      ValidIntervalEnum.three_mo => "3mo",
      
    };
String getValidRangeString(ValidRangesEnum validRangesEnum) =>
    switch (validRangesEnum) {
      ValidRangesEnum.one_d => "1d",
      ValidRangesEnum.five_d => "5d",
      ValidRangesEnum.one_mo => "1mo",
      ValidRangesEnum.three_mo => "3mo",
      ValidRangesEnum.six_mo => "6mo",
      ValidRangesEnum.one_y => "1y",
      ValidRangesEnum.two_y => "2y",
      ValidRangesEnum.five_y => "5y",
      ValidRangesEnum.ten_y => "10y",
      ValidRangesEnum.ytd => "ytd",
      ValidRangesEnum.max => "max",
    };