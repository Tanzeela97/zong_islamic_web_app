class SurahWise {
  int? surah;
  int? ayat;
  String? qtext;
  String? lang;

  SurahWise({this.surah, this.ayat, this.qtext, this.lang});

  SurahWise.fromJson(Map<String, dynamic> json) {
    surah = json['surah'];
    ayat = json['ayat'];
    qtext = json['qtext'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surah'] = this.surah;
    data['ayat'] = this.ayat;
    data['qtext'] = this.qtext;
    data['lang'] = this.lang;
    return data;
  }
}
