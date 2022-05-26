// ignore_for_file: unused_import, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, no_logic_in_create_state, unnecessary_this, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unused_local_variable, prefer_collection_literals, deprecated_member_use, can_be_null_after_null_aware, missing_return

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

class CompetitionPage extends StatefulWidget {
  final Comp comps;
  CompetitionPage(this.comps);

  @override
  State<CompetitionPage> createState() => _CompetitionPageState(this.comps);
}

class _CompetitionPageState extends State<CompetitionPage> {
  DBHelper dbHelper = DBHelper();
  Comp comps;
  List<Match> listMatch;
  int count = 0;
  _CompetitionPageState(this.comps);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_conditional_assignment
    if (listMatch == null) {
      listMatch = List<Match>();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('C70101'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          child: Text(comps.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: createListView()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var match = await navigateToAddMatch(context, this.comps);
          if (match != null) {
            int result = await dbHelper.insert(match);
            if (result > 0) {
              updateListView();
            }
          }
        },
        child: Icon(Icons.add),
        backgroundColor: HexColor('C70101'),
      ),
    );
  }

  Future<Match> navigateToAddMatch(context, Comp comps) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddMatch(comps)),
    );
    return result;
  }

  Future<Match> navigateToEditMatch(context, Match matches) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditMatch(matches)),
    );
    return result;
  }

  void updateListView() async {
    setState(() {
      final Future<Database> dbFuture = dbHelper.initDb();
      dbFuture.then((database) {
        // Future<List<Map<String, dynamic>>> matchListFuture =
        //     dbHelper.selectEvent(name);
        Future matchListFuture = dbHelper.getMatchList(comps.name);
        matchListFuture.then((matchList) {
          setState(() {
            this.listMatch = matchList;
            this.count = matchList.length;
          });
        });
      });
    });
  }

  FutureBuilder createListView() {
    TextStyle textStyle = Theme.of(context)?.textTheme.headline5;
    return FutureBuilder(
        future: dbHelper.getMatchList(comps.name),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/matches',
                        arguments: snapshot.data[index]);
                  },
                  child: Card(
                    margin: EdgeInsets.all(8),
                    elevation: 2.0,
                    child: Container(
                      child: Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 7),
                                  child: Text(
                                    snapshot.data[index].event,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex: 4,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        child: Text(
                                          'Manchester United',
                                          style: TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Text(
                                                snapshot.data[index].score_team,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                            SafeArea(child: Text('  -  ')),
                                            Flexible(
                                              flex: 1,
                                              child: Text(
                                                snapshot
                                                    .data[index].score_opponent,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        flex: 3,
                                        child: Text(
                                          snapshot.data[index].opponent,
                                          style: TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Row(children: [
                                    Flexible(
                                      child: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          dbHelper
                                              .delete(snapshot.data[index].id);
                                          //updateListView(this.comps.name);
                                          updateListView();
                                        },
                                      ),
                                    ),
                                    Flexible(
                                        child: IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () async {
                                        var result = await navigateToEditMatch(
                                            context, snapshot.data[index]);
                                        setState(() {
                                          dbHelper.update(snapshot.data[index]);
                                          updateListView();
                                        });
                                      },
                                    )),
                                  ]),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  /* 
    onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MatchDetail(
                                                        snapshot.data[index])));
                                      },
  */

  // ListView createListView() {
  //   TextStyle textStyle = Theme.of(context).textTheme.headline5;
  //   return ListView.builder(
  //     itemCount: count,
  //     itemBuilder: (BuildContext context, int index) {
  //       return Container(
  //         // color: Colors.white,
  //         child: Row(
  //           children: [
  //             Container(
  //               margin: EdgeInsets.only(top: 5),
  //               child: Text(
  //                 'Manchester\n United',
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 15,
  //                   fontWeight: FontWeight.bold,
  //                   letterSpacing: 1,
  //                 ),
  //                 softWrap: true,
  //                 textAlign: TextAlign.center,
  //               ),
  //             ),
  //             Expanded(
  //               child: Container(
  //                 margin: EdgeInsets.only(top: 5),
  //                 child: Text(
  //                   this.listMatch[index].opponent,
  //                   style: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.bold,
  //                     letterSpacing: 1,
  //                   ),
  //                   softWrap: true,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}


/* // ignore_for_file: unused_import, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, no_logic_in_create_state, unnecessary_this, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unused_local_variable, prefer_collection_literals, deprecated_member_use, can_be_null_after_null_aware, missing_return

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fergie_time/classes/comp.dart';
import 'package:fergie_time/components/bottom_bar.dart';
import 'package:fergie_time/pages/add_match.dart';
import 'dart:async';
import 'package:fergie_time/dir/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fergie_time/classes/match.dart';

class CompetitionPage extends StatefulWidget {
  final Comp comps;
  CompetitionPage(this.comps);

  @override
  State<CompetitionPage> createState() => _CompetitionPageState(this.comps);
}

class _CompetitionPageState extends State<CompetitionPage> {
  DBHelper dbHelper = DBHelper();
  Comp comps;
  List<Match> listMatch;
  int count = 0;
  _CompetitionPageState(this.comps);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_conditional_assignment
    if (listMatch == null) {
      listMatch = List<Match>();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('C70101'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          child: Text(comps.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
      body: showData(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var match = await navigateToAddMatch(context, this.comps);
          if (match != null) {
            int result = await dbHelper.insert(match);
            if (result > 0) {
              updateListView();
            }
          }
        },
        child: Icon(Icons.add),
        backgroundColor: HexColor('C70101'),
      ),
    );
  }

  Future<Match> navigateToAddMatch(context, Comp comps) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddMatch(comps)),
    );
    return result;
  }

  void updateListView() async {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Match>> matchListFuture = dbHelper.getMatchList();
      matchListFuture.then((matchList) {
        setState(() {
          this.listMatch = matchList;
          this.count = matchList.length;
        });
      });
    });
  }

  ListView showData() {
    // ignore: void_checks
    setState(() {
      Column(
        children: [Expanded(child: createListView())],
      );
    });
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context)?.textTheme.headline5;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            // color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: HexColor('C70101'),
                child: Icon(Icons.ad_units),
              ),
              title: Text(this.listMatch[index].opponent, style: textStyle),
              subtitle: Text(this.listMatch[index].score_opponent.toString()),
            ),
          );
        });
  }

  // ListView createListView() {
  //   TextStyle textStyle = Theme.of(context).textTheme.headline5;
  //   return ListView.builder(
  //     itemCount: count,
  //     itemBuilder: (BuildContext context, int index) {
  //       return Container(
  //         // color: Colors.white,
  //         child: Row(
  //           children: [
  //             Container(
  //               margin: EdgeInsets.only(top: 5),
  //               child: Text(
  //                 'Manchester\n United',
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 15,
  //                   fontWeight: FontWeight.bold,
  //                   letterSpacing: 1,
  //                 ),
  //                 softWrap: true,
  //                 textAlign: TextAlign.center,
  //               ),
  //             ),
  //             Expanded(
  //               child: Container(
  //                 margin: EdgeInsets.only(top: 5),
  //                 child: Text(
  //                   this.listMatch[index].opponent,
  //                   style: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.bold,
  //                     letterSpacing: 1,
  //                   ),
  //                   softWrap: true,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}


/* 
  createListView()
*/
  createListView()
*/