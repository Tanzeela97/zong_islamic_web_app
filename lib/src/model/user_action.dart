class UserAction {
  late String status;
  late String msg;
  late Detail detail;

  UserAction({required this.status, required this.msg, required this.detail});

  UserAction.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    detail =Detail.fromJson( json['detail']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status;
    data['msg'] = this.msg;
      data['detail'] = this.detail.toJson();
    return data;
  }
}

class Detail {
  late String likes;
  late String views;
  late String shares;
  late String isLike;

  Detail({required this.likes, required this.views, required this.shares, required this.isLike});

  Detail.fromJson(Map<String, dynamic> json) {
    likes = json['likes'];
    views = json['views'];
    shares = json['shares'];
    isLike = json['isLike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likes'] = this.likes;
    data['views'] = this.views;
    data['shares'] = this.shares;
    data['isLike'] = this.isLike;
    return data;
  }
}
