import 'package:flutter/material.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.deepPurple.shade100
    ),
    useMaterial3: true,
  );
}