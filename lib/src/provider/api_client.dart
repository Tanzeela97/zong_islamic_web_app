import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';

class ApiClient {
  dynamic get(Uri uri,
      {Map<dynamic, dynamic>? params, bool isFromStart = false}) async {
    String token;
    print(uri.toString());
    if (!isFromStart) {
      final _pref = await SharedPreferences.getInstance();
      token = _pref.getString(AppString.tokenStatus)!;
    } else {
      token = "";
    }
    print(token);
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Authorization": "$token"
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic post(Uri uri, {Map<dynamic, dynamic>? params}) async {
    final _pref = await SharedPreferences.getInstance();
    String token = _pref.getString(AppString.tokenStatus)!;
    final response = await http.post(
      uri,
      body: jsonEncode(params),
      headers: {'Content-Type': 'application/json', "Authorization": "$token"},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw Exception();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
