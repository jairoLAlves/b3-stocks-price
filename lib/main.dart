import 'dart:io';

import 'package:b3_price_stocks/pages/settings/settings_page.dart';
import 'package:b3_price_stocks/pages/detail_stock/stock_detail_page.dart';
import 'package:b3_price_stocks/pages/search_stocks/stocks_search_page.dart';
import 'package:b3_price_stocks/pages/home/home_page.dart';
import 'package:b3_price_stocks/providers/menu_principal_provider.dart';
import 'package:b3_price_stocks/providers/stock_info_provaider.dart';
import 'package:b3_price_stocks/providers/stocks_provider.dart';
import 'package:b3_price_stocks/routes/routes_pages.dart';
import 'package:b3_price_stocks/src/shared/themes/themes.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/theme_controller.dart';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = PostHttpOverrides();

  runApp(
    DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), 
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<StocksProvider>(
              create: (ctx) => StocksProvider()),
          ChangeNotifierProvider<StockInfoProvider>(
              create: (ctx) => StockInfoProvider()),
          ChangeNotifierProvider<MenuPrincipalProvider>(
              create: (ctx) => MenuPrincipalProvider()),
        ],
        child: ValueListenableBuilder(
          valueListenable: ThemeController.instance.themeLightOrDart,
          builder: (context, value, child) {
            return MaterialApp(
              useInheritedMediaQuery: true,
              locale: DevicePreview.locale(context),
              builder: DevicePreview.appBuilder,
              debugShowCheckedModeBanner: false,
              title: 'Stocks Prices',
              themeMode: value ? ThemeMode.light : ThemeMode.dark,
              theme: lightTheme,
              darkTheme: dartTheme,
              initialRoute: RoutesPages.HOME,
              routes: {
                RoutesPages.HOME: (ctx) => const HomePage(),
                RoutesPages.STOCKSSEARCH: (ctx) => const StocksSearchPage(),
                RoutesPages.STOCKDETAIL: (ctx) => const StockDetailPage(),
                RoutesPages.SETTINGS: (ctx) => const SettingsPage(),
              },
            );
          },
        ));
  }
}
