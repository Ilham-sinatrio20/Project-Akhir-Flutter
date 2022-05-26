// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unused_import, must_be_immutable, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, prefer_final_fields, unused_field, unnecessary_this, unused_local_variable

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fergie_time/classes/comp.dart';
import 'package:fergie_time/pages/competition.dart';
import 'package:fergie_time/components/bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // _HomeState({Key? key}) : super(key: key);
  int _selectNavbar = 0;

  void _onNavbarTapped(int index) {
    setState(() {
      _selectNavbar = index;
    });
  }

  List<String> clubList = [
    'pic1.jpg',
    'pic2.jpg',
    'pic3.jpg',
    'pic4.jpg',
    'pic5.jpg',
  ];

  final List<dynamic> comps = [
    Comp(logo: 'UCL.png', name: 'UCL'),
    Comp(logo: 'EPL.png', name: 'Premier League'),
    Comp(logo: 'FA Cup.png', name: 'FA Cup'),
    Comp(logo: 'Carabao.png', name: 'Carabao Cup'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: HexColor('C70101'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        // ignore: unnecessary_new
        title: Container(
          width: 45,
          height: 45,
          // ignore: unnecessary_new
          child: new Image.asset(
            'assets/images/logo/AppLogo.png',
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(children: [
            Expanded(
              child: Container(
                  child: CarouselSlider(
                // itemCount: pic.length,
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  reverse: false,
                ),
                items: clubList
                    .map((item) => Flexible(
                          //flex: 1,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Image.asset(
                              'assets/images/club/${item}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ))
                    .toList(),
              )),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 8),
              child: Text(
                'Last Home Match',
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
              indent: 8,
              endIndent: 150,
            ),
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
                      'Premier League',
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
                      'Matchday 32',
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
                            Image.asset(
                              'assets/icon/MU.png',
                              fit: BoxFit.cover,
                              width: 75,
                            ),
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
                              '3 : 2',
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
                            Image.asset(
                              'assets/icon/Norwich.png',
                              fit: BoxFit.cover,
                              width: 75,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                'Norwich\n City',
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
              margin: EdgeInsets.only(top: 20, left: 8),
              child: Text(
                'Competitions',
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
              indent: 8,
              endIndent: 150,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: comps.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      var comp = await navigateToCompetition(
                          context, this.comps[index]);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 245, 245, 245),
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 187, 186, 186)
                                      .withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.height * 0.12,
                            child: Image.asset(
                              'assets/images/logo/${comps[index].logo}',
                              fit: BoxFit.cover,
                              width: 100,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              '${comps[index].name}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ])),
      bottomNavigationBar: bottomBar(),
    );
  }

  Future<Comp> navigateToCompetition(context, Comp comps) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompetitionPage(comps),
      ),
    );
    return result;
  }
}
