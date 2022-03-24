class QuranPlanner {
  int? magribPlan;
  int? ishaaPlan;
  int? fajarPlan;
  int? zohrPlan;
  int? asarPlan;
  int? totalDays;
  int? daysRead;
  int? targetQurans;
  int? quranPages;
  int? todaysTarget;
  String? target;
  String? days;
  int? pageLeft;
  int? totalReadPage;
  int? perPageReadTime;

  QuranPlanner(
      {this.magribPlan,
      this.ishaaPlan,
      this.fajarPlan,
      this.zohrPlan,
      this.asarPlan,
      this.totalDays,
      this.daysRead,
      this.targetQurans,
      this.quranPages,
      this.todaysTarget,
      this.target,
      this.days,
      this.pageLeft,
      this.totalReadPage,
      this.perPageReadTime});

  QuranPlanner.fromJson(Map<String, dynamic> json) {
    magribPlan = json['magrib_plan'];
    ishaaPlan = json['ishaa_plan'];
    fajarPlan = json['fajar_plan'];
    zohrPlan = json['zohr_plan'];
    asarPlan = json['asar_plan'];
    totalDays = json['total_days'];
    daysRead = json['days_read'];
    targetQurans = json['target_qurans'];
    quranPages = json['quran_pages'];
    todaysTarget = json['todays_target'];
    target = json['target'];
    days = json['days'];
    pageLeft = json['page_left'];
    totalReadPage = json['total_read_page'];
    perPageReadTime = json['per_page_read_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['magrib_plan'] = this.magribPlan;
    data['ishaa_plan'] = this.ishaaPlan;
    data['fajar_plan'] = this.fajarPlan;
    data['zohr_plan'] = this.zohrPlan;
    data['asar_plan'] = this.asarPlan;
    data['total_days'] = this.totalDays;
    data['days_read'] = this.daysRead;
    data['target_qurans'] = this.targetQurans;
    data['quran_pages'] = this.quranPages;
    data['todays_target'] = this.todaysTarget;
    data['target'] = this.target;
    data['days'] = this.days;
    data['page_left'] = this.pageLeft;
    data['total_read_page'] = this.totalReadPage;
    data['per_page_read_time'] = this.perPageReadTime;
    return data;
  }
}

class Autogenerated {
  int? magribPlan;
  int? ishaaPlan;
  int? fajarPlan;
  int? zohrPlan;
  int? asarPlan;
  int? totalDays;
  int? daysRead;
  int? targetQurans;
  int? quranPages;
  int? todaysTarget;
  String? target;
  String? days;
  int? pageLeft;
  int? totalReadPage;
  int? perPageReadTime;

  Autogenerated(
      {this.magribPlan,
      this.ishaaPlan,
      this.fajarPlan,
      this.zohrPlan,
      this.asarPlan,
      this.totalDays,
      this.daysRead,
      this.targetQurans,
      this.quranPages,
      this.todaysTarget,
      this.target,
      this.days,
      this.pageLeft,
      this.totalReadPage,
      this.perPageReadTime});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    magribPlan = json['magrib_plan'];
    ishaaPlan = json['ishaa_plan'];
    fajarPlan = json['fajar_plan'];
    zohrPlan = json['zohr_plan'];
    asarPlan = json['asar_plan'];
    totalDays = json['total_days'];
    daysRead = json['days_read'];
    targetQurans = json['target_qurans'];
    quranPages = json['quran_pages'];
    todaysTarget = json['todays_target'];
    target = json['target'];
    days = json['days'];
    pageLeft = json['page_left'];
    totalReadPage = json['total_read_page'];
    perPageReadTime = json['per_page_read_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['magrib_plan'] = this.magribPlan;
    data['ishaa_plan'] = this.ishaaPlan;
    data['fajar_plan'] = this.fajarPlan;
    data['zohr_plan'] = this.zohrPlan;
    data['asar_plan'] = this.asarPlan;
    data['total_days'] = this.totalDays;
    data['days_read'] = this.daysRead;
    data['target_qurans'] = this.targetQurans;
    data['quran_pages'] = this.quranPages;
    data['todays_target'] = this.todaysTarget;
    data['target'] = this.target;
    data['days'] = this.days;
    data['page_left'] = this.pageLeft;
    data['total_read_page'] = this.totalReadPage;
    data['per_page_read_time'] = this.perPageReadTime;
    return data;
  }
}