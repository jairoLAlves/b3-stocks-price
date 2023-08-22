import 'package:flutter/material.dart';
part 'color_schemes.g.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _lightColorScheme,
  appBarTheme: AppBarTheme(
    centerTitle: true,
    color: _lightColorScheme.secondary,
    iconTheme: IconThemeData(color: _lightColorScheme.surface),

    titleTextStyle: ThemeData.light().textTheme.titleLarge!.copyWith(
        color: _lightColorScheme
            .onSecondary), //TextStyle(color: _lightColorScheme.onSecondary)
  ),
);

final dartTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _darkColorScheme,
  appBarTheme: AppBarTheme(
    centerTitle: true,
    color: _darkColorScheme.secondary,
    iconTheme: IconThemeData(
      color: _darkColorScheme.surface,
    ),
    titleTextStyle: ThemeData.dark().textTheme.titleLarge!.copyWith(
          color: _darkColorScheme.onSecondary,
        ), //TextStyle(color: _darkColorScheme.onSecondary, )
  ),
);
