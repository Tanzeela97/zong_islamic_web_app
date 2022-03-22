import 'package:zong_islamic_web_app/src/model/cate_info_list.dart';

class CateInfo {
  String? catId;
  String? title;
  String? isActive;
  List<CateInfoList>? cateInfoList;

  CateInfo({this.catId, this.title, this.isActive, this.cateInfoList});

  CateInfo.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    title = json['title'];
    isActive = json['is_active'];
    if (json['data'] != null) {
      cateInfoList = <CateInfoList>[];
      json['data'].forEach((v) {
        cateInfoList!.add(new CateInfoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['title'] = this.title;
    data['is_active'] = this.isActive;
    if (this.cateInfoList != null) {
      data['data'] = this.cateInfoList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
