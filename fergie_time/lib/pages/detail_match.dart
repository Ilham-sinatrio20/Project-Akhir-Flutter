// ignore_for_file: unused_import, unused_local_variable, avoid_unnecessary_containers, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fergie_time/classes/comp.dart';
import 'package:fergie_time/components/bottom_bar.dart';
import 'package:fergie_time/pages/add_match.dart';
import 'package:fergie_time/pages/edit_match.dart';
import 'dart:async';
import 'package:fergie_time/dir/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fergie_time/classes/match.dart';
import "dart:math";

class DetailMatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Starting> starting = [
      Starting(num: '1', name: 'David de Gea', pos: 'GK'),
      Starting(num: '5', name: 'Harry Maguire', pos: 'DF'),
      Starting(num: '19', name: 'Raphael Varane', pos: 'DF'),
      Starting(num: '3', name: 'Luke Shaw', pos: 'DF'),
      Starting(num: '20', name: 'Diogo Dalot', pos: 'DF'),
      Starting(num: '6', name: 'Paul Pogba', pos: 'MF'),
      Starting(num: '17', name: 'Fred', pos: 'MF'),
      Starting(num: '6', name: 'Paul Pogba', pos: 'MF'),
      Starting(num: '18', name: 'Bruno Fernandes', pos: 'MF'),
      Starting(num: '10', name: 'Marcus Rashford', pos: 'FW'),
      Starting(num: '7', name: 'Cristiano Ronaldo', pos: 'FW'),
      Starting(num: '25', name: 'Jadon Sancho', pos: 'FW'),
    ];
    Match match = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('C70101'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Container(
            child: Text('Manchester United VS ' + match.opponent,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: HexColor('090303'),
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(31, 179, 179, 179),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                      offset: Offset(
                        20.0,
                        25.0,
                      ),
                    )
                  ]),
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 7),
                    child: Text(
                      match.event,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 10),
                    child: Text(
                      match.date,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Column(children: [
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                'Manchester\n United',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ]),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              match.score_team + ' : ' + match.score_opponent,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(children: [
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                match.opponent,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                'Line Up',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  fontFamily: 'Lato',
                  color: HexColor('C70101'),
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Divider(
              color: HexColor('C70101'),
              thickness: 2,
              indent: 12,
              endIndent: 12,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: starting.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Text(
                            starting[index].num,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          child: Text(
                            starting[index].name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}

class Starting {
  String num, name, pos;

  Starting({this.num, this.name, this.pos});
}
