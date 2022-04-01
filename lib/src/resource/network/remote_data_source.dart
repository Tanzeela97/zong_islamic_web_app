import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:zong_islamic_web_app/src/model/auth_status_model.dart';
import 'package:zong_islamic_web_app/src/model/cate_info.dart';
import 'package:zong_islamic_web_app/src/model/cate_info_list.dart';
import 'package:zong_islamic_web_app/src/model/content_by_category_id.dart';
import 'package:zong_islamic_web_app/src/model/file_upload.dart';
import 'package:zong_islamic_web_app/src/model/islamic_name.dart';
import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/model/mufti.dart';
import 'package:zong_islamic_web_app/src/model/news.dart';
import 'package:zong_islamic_web_app/src/model/notification.dart';
import 'package:zong_islamic_web_app/src/model/prayer_information.dart';
import 'package:zong_islamic_web_app/src/model/profile.dart';
import 'package:zong_islamic_web_app/src/model/quran_planner.dart';
import 'package:zong_islamic_web_app/src/model/salah_tracker.dart';
import 'package:zong_islamic_web_app/src/model/slider.dart';
import 'package:zong_islamic_web_app/src/model/surah_wise.dart';
import 'package:zong_islamic_web_app/src/model/token_status.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';
import 'package:zong_islamic_web_app/src/model/user_action.dart';
import 'package:zong_islamic_web_app/src/model/zong_app_info.dart';
import 'package:zong_islamic_web_app/src/provider/api_client.dart';
import 'package:zong_islamic_web_app/src/resource/network/abs_remote_data_src.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_utility.dart';
import 'package:zong_islamic_web_app/src/resource/utility/network_constants.dart';

class ZongIslamicRemoteDataSourceImpl extends ZongIslamicRemoteDataSource {
  final ApiClient _client = ApiClient();
  late final HashMap<String, IslamicNameModel> _cacheIslamicName;

  ZongIslamicRemoteDataSourceImpl() {
    _cacheIslamicName = HashMap<String, IslamicNameModel>();
  }

  @override
  Future<List<MainMenuCategory>> getMainMenuCategory(String? number) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': NetworkConstant.GET_CAT,
      'city': 'Karachi',
    });

    final parsed = await _client.get(
      uri,
    );
    return parsed
        .map<MainMenuCategory>((json) => MainMenuCategory.fromJson(json))
        .toList();
  }

  @override
  Future<Trending> getTrendingNews(String? number) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
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
  Future<ContentByCateId> getCategoryById(String id, String? number) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': NetworkConstant.GET_CONTENT,
      'cat_id': id,
      'p': "1",
      'city': 'Karachi',
    });

    final parsed = await _client.get(uri);
    return ContentByCateId.fromJson(parsed);
  }

  @override
  Future<List<CustomSlider>> getSliderImage(String? number) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
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
  Future<Profile> getProfileData(String? number) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': NetworkConstant.VIEW_BASE_CONTENT,
      'city': 'Karachi',
    });
    final parsed = await _client.get(uri);
    return Profile.fromJson(parsed);
  }

  @override
  Future<Profile> getSearchData(String? number, [String? search]) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': NetworkConstant.SEARCH,
      'keyword': search == null ? "Quran" : search,
      'city': 'Karachi',
    });
    final parsed = await _client.get(uri);
    return Profile.fromJson(parsed);
  }

  @override
  Future<List<Notifications>> getNotifications(String? number) async {

    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': NetworkConstant.PUSH_NOTIFICATION_LIST,
      'city': 'Karachi',
    });
    final parsed = await _client.get(uri) as List;
    if(parsed.first['status']=='failed'){

      return <Notifications>[];
    }
    return parsed
        .map<Notifications>((json) => Notifications.fromJson(json))
        .toList();
  }

  @override
  Future<AuthStatusModel> login(String? number) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': NetworkConstant.CUREG_CKEY,
    });
    Iterable response;
    try {
      response = await _client.get(uri);
    } catch (e) {
      await AppUtility.getTokenStatus();
      response = await _client.get(uri);
    }
    return AuthStatusModel.fromJson(response.first);
  }

  @override
  Future<AuthStatusModel> verifyOtp(String? number, String code) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': NetworkConstant.CUREG_VKEY,
      'key': code,
    });
    print('otp -$uri');
    Iterable response = await _client.get(uri);
    print('otp -${response.first}');
    return AuthStatusModel.fromJson(response.first);
  }

  @override
  Future<List<String>> getAllCities() async {
    var data = await _client.get(Uri.parse(
        "https://api02.vectracom.net:8443/zg-location/location/getAllCity"));
    if (data["status"] == "SUCCESS") {
      Iterable l = data['data'];
      List<String> streetsList = [];
      l.forEach((element) {
        String city = element['name'];
        streetsList.add(city);
      });
      return streetsList;
    } else {
      throw data["status"];
    }
  }

  @override
  Future<List<String>> getHomepageDetails(String? number) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': 'home_ramadan_mzapp',
    });
    var response = await _client.get(uri);
    List<String> dateList = [];
    dateList.add(response['englishDate']);
    dateList.add(response['islamicDate']);
    return dateList;
  }

  @override
  Future<PrayerInfo> getPrayer(String lat, String lng, String? number) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri = Uri.https('vp.vxt.net:31443', '/api/pt', {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': 'home_ramadan_mzapp',
      'tz': '5',
      'a': 'HANAFI',
      'm': 'Karachi',
      'lt': lat,
      'lg': lng,
    });

    var response = await _client.get(uri);
    return PrayerInfo.fromJson(response);
  }

  @override
  Future<List<SurahWise>> getSurahWise(int surah, String lang) async {
    // var uri = Uri.https("vp.vxt.net:31786", "/api/surah", {
    //   'surah': "$surah",
    //   'ayat': '0',
    //   'limit': '0',
    //   'lang': lang,
    // });
    var uri = Uri.https("ap-1.ixon.cc", "/api/v3/quran", {
      'surah': "$surah",
      'ayat': '1',
      'limit': '300',
      'lang': lang,
    });

    final parsed = await _client.get(uri);
    final iterable = parsed['data'];
    return iterable.map<SurahWise>((json) => SurahWise.fromJson(json)).toList();
  }

  @override
  Future<IslamicNameModel> getIslamicName(String url, String? number) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': 'get_naming_list_by_alpha',
      'name_id': '$url',
      'p': "1",
    });

    //return await compute(computeFunction, uri);

    final parsed = await _client.get(uri);
    return IslamicNameModel.fromJson(parsed);
  }

  @override
  Future<List<A>> setAndGetFavorite(
      [String? nameId, int? status, String? number]) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': 'add_fav_name',
      'name_id': "${nameId}",
      'status': "$status",
    });

    final parsed = await _client.get(uri);

    return parsed.map<A>((json) => A.fromJson(json)).toList();
  }

  //**************************************//thread
  Future<IslamicNameModel> computeFunction(Uri url) async {
    print('name $url');
    final parsed = await _client.get(url);
    return IslamicNameModel.fromJson(parsed);
  }

  @override
  Future<ZongAppInformation> getZongAppInfo(String? number) async {
    if (number!.isEmpty) {
      number = null;
    }
    final uri = Uri.https(
        NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': NetworkConstant.GET_INFO
    });

    final List parsed = await _client.get(uri);

    return ZongAppInformation.fromJson(parsed.first);
  }

  @override
  Future<UserAction> setUserActicoon(
      {required String cate_id,
      required String cont_id,
      required String page,
      required String action,
      required String? number}) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': 'setaction',
      'cat_id': "${cate_id}",
      'page': "${page}",
      'content_id': "${cont_id}",
      'action': "${action}"
    });
    final map = await _client.get(uri);
    return UserAction.fromJson(map);
  }

  @override
  Future<UserAction> setUserAction(
      {required String cate_id,
      required String cont_id,
      required String page,
      required String action,
      required String? number}) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': 'setaction',
      'cat_id': "${cate_id}",
      'page': "${page}",
      'content_id': "${cont_id}",
      'action': "${action}"
    });
    final map = await _client.get(uri);
    return UserAction.fromJson(map);
  }

  @override
  Future<TokenStatus> getTokenStatus() async {
    var response = await _client.get(
        Uri.parse("https://zongislamicv1.vectracom.com/api/get_token.php"),
        isFromStart: true);
    return TokenStatus.fromJson(response);
  }

  @override
  Future<List<CateInfo>> newFetchCategoryStatus(String? number) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': NetworkConstant.NEW_FETCH_CATEGORY_STATUS,
      'city': 'Karachi',
    });
    final parsed = await _client.get(uri);
    return parsed.map<CateInfo>((json) => CateInfo.fromJson(json)).toList();
  }

  @override
  Future<List<CateInfoList>> getContentByCatIid(
      String? number, String catId) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': NetworkConstant.GET_CONTENT_BY_CAT_ID,
      'cat_id': '$catId',
      'city': 'Karachi',
    });
    final parseds = await _client.get(uri);
    return parseds
        .map<CateInfoList>((json) => CateInfoList.fromJson(json))
        .toList();
  }

  @override
  Future<QuranPlanner> insertQuranPlaner(String? number, String counterQuran,
      String daysRead, String totalPage, String pageReadMints) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'operator': 'Zong',
      'msisdn': '$number',
      'menu': NetworkConstant.QURAN_PLANER,
      'countr_quran': '$counterQuran',
      'days_read': '$daysRead',
      'total_page': '$totalPage',
      'page_read_mints': '$pageReadMints',
    });
    print("get:${uri.toString()}");
    final parsed = await _client.post(uri) as List;
    print("${parsed.first}");
    return QuranPlanner.fromJson(parsed.first);
  }

  @override
  Future<QuranPlanner> getQuranPlanner(String? number) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': NetworkConstant.GET_QURAN_PLANER,
    });
    print("inser:${uri.toString()}");
    final parsed = await _client.get(uri);
    return QuranPlanner.fromJson(parsed.first);
  }

  @override
  Future<QuranPlanner> updateQuranPlanner(
      String? number, String pagesRead) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'operator': 'Zong',
      'msisdn': '$number',
      'menu': NetworkConstant.UPDATE_QURAN_PLANER,
      'pages_read': '$pagesRead',
    });
    print("update:${uri.toString()}");
    final parsed = await _client.post(uri);
    return QuranPlanner.fromJson(parsed.first);
  }

  @override
  Future<Mufti> getAllQirat(String number) async {
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': NetworkConstant.qirat_all,
    });

    final parsed = await _client.get(uri);
    return Mufti.fromJson(parsed);
  }

  @override
  Future<FileUpload> uploadQirat(
      String number, String filePath, String name) async {
    var dio = Dio();
    File file = File(filePath);
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
      "filename": "$name",
      "msisdn": "$number"
    });
    var response = await dio.post(
        "https://zongislamicv1.vectracom.com/api/uploadQirat.php",
        data: formData);
    print(response.data);

    return FileUpload.fromJson(response.data);
  }

  @override
  Future<String> checkMuftiLive(String number) async {
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': NetworkConstant.LIVE_BROADCAST_URL,
    });

    final parsed = await _client.get(uri);
    return parsed.first['url'];
  }

  @override
  Future<List<News>> fetchFourContentCategoryStatus(String? number) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': NetworkConstant.CONTENT_FOUR_HOME_MZAPP,
      'city': 'Karachi',
    });
    final parsed = await _client.get(
      uri,
    );
    return parsed.map<News>((json) => News.fromJson(json)).toList();

  }

  @override
  Future<void> postSalahTracker(String? number,int fajar,int zohr,int asr,int magrib,int isha,String date) async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'operator': 'Zong',
      'msisdn': '$number',
      'menu': NetworkConstant.INSERT_SALAH_TRACKER,
    });
    print("get:${uri.toString()}");
  await _client.post(uri, params: {
      "fujr": fajar,
      "zuhr": zohr,
      "asr": asr,
      "maghrib": magrib,
      "isha": isha,
      "date": date
    });
  }

  @override
  Future<List<SalahTracker>> getSalahTracker(String? number)async {
    if (number!.isEmpty) {
      number = null;
    }
    var uri = Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '$number',
      'operator': 'Zong',
      'menu': NetworkConstant.GET_SALAH_TRACKER,
    });
    final parsed = await _client.get(uri);

    return parsed.map<SalahTracker>((json) => SalahTracker.fromJson(json)).toList();
  }
}
