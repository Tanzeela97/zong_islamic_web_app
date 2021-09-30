import 'dart:convert';

import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/model/notification.dart';
import 'package:zong_islamic_web_app/src/model/profile.dart';
import 'package:zong_islamic_web_app/src/model/slider.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';
import 'package:zong_islamic_web_app/src/provider/api_client.dart';
import 'package:zong_islamic_web_app/src/resource/network/abs_remote_data_src.dart';
import 'package:zong_islamic_web_app/src/resource/utility/network_constants.dart';

class ZongIslamicRemoteDataSourceImpl extends ZongIslamicRemoteDataSource {
  final ApiClient _client = ApiClient();

  @override
  Future<List<MainMenuCategory>> getMainMenuCategory() async {
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '923128863374',
      'operator': 'Zong',
      'menu': NetworkConstant.GET_CAT,
      'city': 'Karachi',
    });
    print(uri);
    final parsed = await _client.get(
      uri,
    );
    return parsed
        .map<MainMenuCategory>((json) => MainMenuCategory.fromJson(json))
        .toList();
  }

  @override
  Future<Trending> getTrendingNews() async {
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '923128863374',
      'operator': 'Zong',
      'menu': NetworkConstant.GET_TRENDING,
      'city': 'Karachi',
    });
    final parsed = await _client.get(
      uri,
    );
    return Trending.fromJson(parsed);
  }

  @override
  Future<List<CustomSlider>> getSliderImage() async {
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '923128863374',
      'operator': 'Zong',
      'menu': NetworkConstant.GET_SLIDER,
      'city': 'Karachi',
    });
    final parsed = await _client.get(
      uri,
    );
    return parsed
        .map<CustomSlider>((json) => CustomSlider.fromJson(json))
        .toList();
  }

  @override
  Future<Profile> getProfileData() async {
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '923128863374',
      'operator': 'Zong',
      'menu': NetworkConstant.VIEW_BASE_CONTENT,
      'city': 'Karachi',
    });
    final parsed = await _client.get(
      uri,
    );
    return Profile.fromJson(parsed);
  }

  @override
  Future<Profile> getSearchData() async {
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '923128863374',
      'operator': 'Zong',
      'menu': NetworkConstant.SEARCH,
      'keyword': "",
      'city': 'Karachi',
    });
    final parsed = await _client.get(
      uri,
    );
    return Profile.fromJson(parsed);
  }

  @override
  Future<List<Notification>> getNotifications() async {
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '923128863374',
      'operator': 'Zong',
      'menu': NetworkConstant.PUSH_NOTIFICATION_LIST,
      'city': 'Karachi',
    });
    final parsed = await _client.get(
      uri,
    );
    return parsed
        .map<MainMenuCategory>((json) => Notification.fromJson(json))
        .toList();
  }
}
