class ZongAppInformation {
  String? term;
  String? about;
  String? privacy;
  String? appVersion;

  ZongAppInformation({this.term, this.about, this.privacy, this.appVersion});

  factory ZongAppInformation.fromJson(Map<String, dynamic> json) =>
      ZongAppInformation(
          term: json['term'],
          about: json['about'],
          privacy: json['privacy'],
          appVersion: json['app_version']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['term'] = this.term;
    data['about'] = this.about;
    data['privacy'] = this.privacy;
    data['app_version'] = this.appVersion;
    return data;
  }
}
