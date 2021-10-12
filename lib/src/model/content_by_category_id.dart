import 'package:zong_islamic_web_app/src/model/trending.dart';

class ContentByCateId {
  String? catId;
  String? title;
  String? parentId;
  List<SubMenu>? subMenu;
  Trending? vod;

  ContentByCateId(
      {this.catId, this.title, this.parentId, this.subMenu, this.vod});

  ContentByCateId.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    title = json['title'];
    parentId = json['parent_id'];
    vod = (json['vod'] != null ? Trending.fromJson(json['vod']) : null)!;
    if (json['subMenu'] != null) {
      subMenu = [];
      json['subMenu'].forEach((v) {
        subMenu!.add(SubMenu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['cat_id'] = catId;
    data['title'] = title;
    data['parent_id'] = parentId;
    if (vod != null) {
      data['void'] = vod!.toJson();
    }
    if (subMenu != null) {
      data['subMenu'] = subMenu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubMenu {
  String? status;
  String? msg;

  SubMenu({this.status, this.msg});

  SubMenu.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['msg'] = msg;
    return data;
  }
}
