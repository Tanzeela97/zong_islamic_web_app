import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:zong_islamic_web_app/src/model/islamic_name.dart';

import 'islamic_name.dart';

class NameModel{
  final String name;
  final String detail;
  final String nameId;
  int isFavourite;
  NameModel({required this.nameId, required this.isFavourite, required this.name, required this.detail});

}

enum EnumFavourite{
  isFavorite,isNotFavourite
}


