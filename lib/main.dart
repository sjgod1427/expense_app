import 'package:expense_app/expenses.dart';
import 'package:flutter/material.dart';

var kcolorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));
var kdarkScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 5, 99, 125),
    brightness: Brightness.dark);

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kdarkScheme,
        cardTheme: const CardTheme().copyWith(
            color: kcolorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kdarkScheme.primaryContainer)),
      ),
      theme: ThemeData().copyWith(
          useMaterial3: true,
          scaffoldBackgroundColor: Color.fromARGB(255, 183, 160, 232),
          colorScheme: kcolorScheme,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kcolorScheme.primaryContainer)),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.deepPurple,
                  fontSize: 16)),
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kcolorScheme.onPrimaryContainer,
              foregroundColor: kcolorScheme.primaryContainer),
          cardTheme: const CardTheme().copyWith(
              color: kcolorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8))),
      home: const Expenses(),
    ),
  );
}
