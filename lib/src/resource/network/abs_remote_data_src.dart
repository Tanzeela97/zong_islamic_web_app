import 'dart:collection';
import 'dart:io';

import 'package:zong_islamic_web_app/src/model/content_by_category_id.dart';
import 'package:zong_islamic_web_app/src/model/islamic_name.dart';
import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/model/notification.dart';
import 'package:zong_islamic_web_app/src/model/prayer_information.dart';
import 'package:zong_islamic_web_app/src/model/profile.dart';
import 'package:zong_islamic_web_app/src/model/slider.dart';
import 'package:zong_islamic_web_app/src/model/surah_wise.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';
import 'package:zong_islamic_web_app/src/model/user_action.dart';
import 'package:zong_islamic_web_app/src/model/zong_app_info.dart';

abstract class ZongIslamicRemoteDataSource {
  //home
  Future<List<MainMenuCategory>> getMainMenuCategory(String number);

  Future<Trending> getTrendingNews(String number);

  Future<List<CustomSlider>> getSliderImage(String number);

  //profile
  Future<Profile> getProfileData(String number);

  //notification
  Future<List<Notifications>> getNotifications(String number);

  //search
  Future<Profile> getSearchData(String number);

  //login
  Future<String> login(String number);

  //verify otp
  Future<String> verifyOtp(String number, String code);

  // get category By Id
  Future<ContentByCateId> getCategoryById(String id, String number);

  Future<List<String>> getAllCities();

  Future<List<String>> getHomepageDetails(String number);

  Future<PrayerInfo> getPrayer(String lat, String lng, String number);

  Future<List<SurahWise>> getSurahWise(int surah, String lang);

  Future<IslamicNameModel> getIslamicName(String url);

  Future<List<A>> setAndGetFavorite([String nameId, int status]);

  Future<String> getAllRecording(String number);

  Future<String> postQirat(String filePath);

  Future<ZongAppInformation> getZongAppInfo();

  Future<UserAction> setUserAction(
      {required String cate_id,
      required String cont_id,
      required String page,
      required String action});
}
