import 'dart:convert';

import 'package:flutter/services.dart';

class NameModel{
  final String name;
  const NameModel({required this.name});
}

Future<List<NameModel>> loadCountriesFromAsset() async {
  var value = await rootBundle.loadString('assets/boy_name.json');
  List<dynamic> _jsonData = json.decode(value);
  var result = <NameModel>[];
  for (var item in _jsonData) {
    result.add(NameModel(name: item["name"].toString()));
  }
  result.sort((a, b) => a.name.compareTo(b.name));
  return result;
}



