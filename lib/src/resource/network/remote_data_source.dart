import 'dart:convert';

import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/provider/api_client.dart';
import 'package:zong_islamic_web_app/src/resource/network/abs_remote_data_src.dart';


class ZongIslamicRemoteDataSourceImpl extends ZongIslamicRemoteDataSource {
  final ApiClient _client = ApiClient();
  @override
  Future<List<MainMenuCategory>> getMainMenuCategory() async {
    var uri = Uri.https('zongislamicv1.vectracom.com', '/api/index.php', {
      'msisdn': '923128863374',
      'operator': 'Zong',
      'menu': 'getcat',
      'city': 'Karachi',
    });
    final parsed = await _client.get(
      uri,
    );
    return parsed
        .map<MainMenuCategory>((json) => MainMenuCategory.fromJson(json))
        .toList();
  }
}
