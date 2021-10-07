import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/model/notification.dart';
import 'package:zong_islamic_web_app/src/model/profile.dart';
import 'package:zong_islamic_web_app/src/model/slider.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';

abstract class ZongIslamicRemoteDataSource {
  //home
  Future<List<MainMenuCategory>> getMainMenuCategory();

  Future<Trending> getTrendingNews();

  Future<List<CustomSlider>> getSliderImage();

  //profile
  Future<Profile> getProfileData();

  //notification
  Future<List<Notifications>> getNotifications();

  //search
  Future<Profile> getSearchData();

  //login
  Future<String> login();

  //verify otp
  Future<String> verifyOtp(String number, String code);
}
