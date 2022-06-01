// ignore_for_file: unused_import, avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

class EplMatch {
  var headers = {
    'x-rapidapi-key': 'da633d7eeefb468ba93f1d464a913b77',
    'x-rapidapi-host': 'v3.football.api-sports.io'
  };
  var request = http.Request(
      'GET',
      Uri.parse('https://v3.football.api-sports.io/fixtures?team=33&league=39&season=2021'));

  Future<dynamic> getMatches() async {
    request.headers.addAll(headers);
    http.StreamedResponse result = await request.send();

    if (result.statusCode == HttpStatus.ok) {
      String response = await result.stream.bytesToString();
      return response;
    } else {
      throw Exception('Failed to load post');
    }
  }

  // request.headers.addAll(headers);

  // http.StreamedResponse response = await request.send();

  // if(response.statusCode == 200) {
  //   print(await response.stream.bytesToString());
  // } else {
  //   print(response.reasonPhrase);
  // }
}
