import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';

abstract class ZongIslamicRemoteDataSource {
  Future<List<MainMenuCategory>> getMainMenuCategory();

}
