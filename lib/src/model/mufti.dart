class Mufti {
  bool? status;
  List<Data>? data;

  Mufti({this.status, this.data});

  Mufti.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    return 'MuftiQirat{status: $status, data: $data}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Mufti copyWith({
    bool? status,
    List<Data>? data,
  }) {
    return Mufti(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }
}

class Data {
  String? url;
  String? answer;
  String? date;
  String? filename;
  String? duration;
  int? isAnswered;

  Data(
      {this.url,
      this.answer,
      this.date,
      this.filename,
      this.duration,
      this.isAnswered});

  @override
  String toString() {
    return 'Data{url: $url, answer: $answer, date: $date, filename: $filename, duration: $duration, isAnswered: $isAnswered}';
  }

  Data.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    answer = json['answer'];
    date = json['date'];
    filename = json['filename'];
    duration = json['duration'];
    isAnswered = json['is_answered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = this.url;
    data['answer'] = this.answer;
    data['date'] = this.date;
    data['filename'] = this.filename;
    data['duration'] = this.duration;
    data['is_answered'] = this.isAnswered;
    return data;
  }

  Data copyWith({
    String? url,
    String? answer,
    String? date,
    String? filename,
    String? duration,
    int? isAnswered,
  }) {
    return Data(
      url: url ?? this.url,
      answer: answer ?? this.answer,
      date: date ?? this.date,
      filename: filename ?? this.filename,
      duration: duration ?? this.duration,
      isAnswered: isAnswered ?? this.isAnswered,
    );
  }
}
