//import 'dart:io';

import 'package:b3_price_stocks/mockdata/mock_data.dart';
import 'package:b3_price_stocks/pages/settings_page.dart';
import 'package:b3_price_stocks/pages/stock_detail_page.dart';
import 'package:b3_price_stocks/pages/stocks_search_page.dart';
import 'package:b3_price_stocks/pages/home_page.dart';
import 'package:b3_price_stocks/providers/media_query_provider.dart';
import 'package:b3_price_stocks/providers/menu_principal_provider.dart';
import 'package:b3_price_stocks/providers/stocks_provider.dart';
import 'package:b3_price_stocks/routes/routes_pages.dart';
import 'package:b3_price_stocks/src/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'components/item_list_stocks.dart';

// class PostHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

void main() {
//  HttpOverrides.global = new PostHttpOverrides();
  Animate.restartOnHotReload = true;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<StocksProvider>(
              create: (ctx) => StocksProvider()),
          ChangeNotifierProvider<MediaQueryProvider>(
              create: (ctx) => MediaQueryProvider()),
          ChangeNotifierProvider<MenuPrincipalProvider>(
              create: (ctx) => MenuPrincipalProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Stocks Prices',
          themeMode: ThemeMode.system,
          theme: lightTheme,
          darkTheme: dartTheme,
          initialRoute: RoutesPages.HOME,
          routes: {
            RoutesPages.HOME: (ctx) => const HomePage(),
            RoutesPages.STOCKSSEARCH: (ctx) => const StocksSearchPage(),
            RoutesPages.STOCKDETAIL: (ctx) => const StockDetail(),
            RoutesPages.SETTINGS: (ctx) => const SettingsPage(),
          },
        ));
  }
}

class PreviewWidget extends StatelessWidget {
  const PreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            ItemListStocks(
              stock: StockMglu3.stockMgl,
            ),
          ],
        ),
      ),
    );
  }
}
