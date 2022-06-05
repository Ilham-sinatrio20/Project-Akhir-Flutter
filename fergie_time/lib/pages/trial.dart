// ignore_for_file: annotate_overrides, prefer_const_constructors, unused_import

import 'package:fergie_time/services/epl_match.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class Trial extends StatefulWidget {
  @override
  State<Trial> createState() => _TrialState();
}

class _TrialState extends State<Trial> {
  String result = "";
  EplMatch services;

  @override
  void initState() {
    services = EplMatch();
    super.initState();
  }

  Widget build(BuildContext context) {
    services.getMatches().then((value) {
      setState(() {
        result = value;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Trial"),
      ),
      body: Center(
        child: Text(result ?? 'Loading...'),
      ),
    );
  }
}
