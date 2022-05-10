import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_utility.dart';

class ApiClient {
  dynamic get(Uri uri,
      {Map<dynamic, dynamic>? params}) async {
    print(uri);
    final response = await http.get(uri);
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
      {Map<dynamic, dynamic>? params}) async {

    print(uri);
    final response = await http.post(
      uri,
      body: jsonEncode(params),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
