import 'package:zong_islamic_web_app/src/model/news.dart';

class Trending {
  dynamic totalPage;
  String? previousPage;
  dynamic nextPage;
  dynamic page;
  dynamic data;

  Trending(
      {required this.totalPage,
      required this.previousPage,
      required this.nextPage,
      required this.page,
      required this.data});

  Trending.fromJson(Map<String, dynamic> json) {
    totalPage = json['total_page'];
    previousPage = json['previous_page'];
    nextPage = json['next_page'];
    page = json['page'];
    if (json['data'] != null) {
      if (json['data'] is List) {
        data = <News>[];
        json['data'].forEach((v) {
          data!.add(News.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_page'] = totalPage;
    data['previous_page'] = previousPage;
    data['next_page'] = nextPage;
    data['page'] = page;
    if (this.data != null) {
      if (data['data'] is List) {
        data['data'] = this.data!.map((v) => v.toJson()).toList();
      }
    }
    return data;
  }
}
