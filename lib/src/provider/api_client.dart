import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_utility.dart';

class ApiClient {
  dynamic get(Uri uri,
      {Map<dynamic, dynamic>? params, bool isFromStart = false}) async {
    String token;
    if (!isFromStart) {
      final _pref = await SharedPreferences.getInstance();
      token = _pref.getString(AppString.tokenStatus)!;
    } else {
      token = "";
    }
    print(uri);


    final response = await http.get(
      uri,
      headers: {
        'Cookie': 'PHPSESSID=onrfji8h99faibb42036u241p7',
        'User-Agent': 'PostmanRuntime/7.28.4',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Authorization": '${token.toString()}'
      },
    );
    print("test token header:: ${response.headers}");
    print("test token:: ${response.body}");
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      print("code::${response.statusCode}");
      throw Exception(response.statusCode);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic post(Uri uri,
      {Map<dynamic, dynamic>? params, bool isFromStart = false}) async {

    String token;
    if (!isFromStart) {
      final _pref = await SharedPreferences.getInstance();
      token = _pref.getString(AppString.tokenStatus)!;
    } else {
      token = "";
    }
    print(uri);
    print(token);
    final response = await http.post(
      uri,
      body: jsonEncode(params),
      headers: {
        "Content-Type": "application/json",

      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      await AppUtility.getTokenStatus();
      final _pref = await SharedPreferences.getInstance();
      String token = _pref.getString(AppString.tokenStatus)!;
      final response = await http.post(
        uri,
        body: jsonEncode(params),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "$token"
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
