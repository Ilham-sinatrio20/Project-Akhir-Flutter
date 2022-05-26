// ignore_for_file: prefer_const_constructors

import 'package:fergie_time/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:fergie_time/pages/detail_match.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/matches': (context) => DetailMatch(),
      },
    );
  }
}
