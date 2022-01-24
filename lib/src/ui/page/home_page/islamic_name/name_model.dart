import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:zong_islamic_web_app/src/model/islamic_name.dart';

import 'islamic_name.dart';

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

Future<IslamicNameModel> loadIslamicNameFromAsset()async{
  try{
    var value = await rootBundle.loadString('assets/boy_name.json');
    var result = IslamicNameModel.fromJson(json.decode(value));
    print(result.data[0].z.first.name);
  }catch(e){
    print(e);
  }

  return IslamicNameModel.fromJson({});
}


