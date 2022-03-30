class SalahTracker {
  String? userId;
  String? date;
  int? fujr;
  int? zuhr;
  int? asr;
  int? maghrib;
  int? isha;

  SalahTracker(
      {this.userId,
        this.date,
        this.fujr,
        this.zuhr,
        this.asr,
        this.maghrib,
        this.isha});

  @override
  String toString() {
    return 'SalahTracker{userId: $userId, date: $date, fujr: $fujr, zuhr: $zuhr, asr: $asr, maghrib: $maghrib, isha: $isha}';
  }

  SalahTracker.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    date = json['date'];
    fujr = json['fujr'];
    zuhr = json['zuhr'];
    asr = json['asr'];
    maghrib = json['maghrib'];
    isha = json['isha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['date'] = this.date;
    data['fujr'] = this.fujr;
    data['zuhr'] = this.zuhr;
    data['asr'] = this.asr;
    data['maghrib'] = this.maghrib;
    data['isha'] = this.isha;
    return data;
  }

  SalahTracker copyWith({
    String? userId,
    String? date,
    int? fujr,
    int? zuhr,
    int? asr,
    int? maghrib,
    int? isha,
  }) {
    return SalahTracker(
      userId: userId ?? this.userId,
      date: date ?? this.date,
      fujr: fujr ?? this.fujr,
      zuhr: zuhr ?? this.zuhr,
      asr: asr ?? this.asr,
      maghrib: maghrib ?? this.maghrib,
      isha: isha ?? this.isha,
    );
  }
}
