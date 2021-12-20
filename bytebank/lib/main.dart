// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bytebank/http/webclient.dart';
import 'package:flutter/material.dart';

import 'screens/dashboard.dart';

void main() {
  runApp(const ByteBankApp());
  findAll().then((transactions) => print('new transactions: $transactions'));
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.green.shade900,
            secondary: Colors.blueAccent.shade700),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.blueAccent.shade700),
          ),
        ),
      ),
      home: Dashboard(),
    );
  }
}
