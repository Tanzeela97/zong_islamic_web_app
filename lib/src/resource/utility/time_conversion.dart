import 'package:intl/intl.dart';
import 'package:zong_islamic_web_app/src/model/prayer.dart';
import 'package:zong_islamic_web_app/src/model/prayer_information.dart';

class PrayerConvertion {
  String? sunriseTimeStart, sunsetTimeStart, zawalTimeStart, chashtNamazTime;
  PrayerInfo? _prayerInfo;
  String? currentTime;
  String? nowText, nextText;
  List<Prayer> prayerList = [];

  Future<void> prayerUpdates(PrayerInfo? prayerInfo) async {
    prayerList.clear();
    _prayerInfo = prayerInfo;
    prayerList.add(Prayer(
        namazName: "Fajr",
        namazTime: _prayerInfo!.fajr!,
        isCurrentNamaz: false));
    prayerList.add(
      Prayer(
          namazName: "Zuhr",
          namazTime: _prayerInfo!.dhuhr!,
          isCurrentNamaz: false),
    );
    prayerList.add(
      Prayer(
          namazName: "Asr",
          namazTime: _prayerInfo!.asr!,
          isCurrentNamaz: false),
    );
    prayerList.add(
      Prayer(
          namazName: "Maghrib",
          namazTime: _prayerInfo!.maghrib!,
          isCurrentNamaz: false),
    );
    prayerList.add(
      Prayer(
          namazName: "Isha",
          namazTime: _prayerInfo!.isha!,
          isCurrentNamaz: false),
    );
    await getPrayerTime();
    await getHeadingText();
  }

  Future<void> getPrayerTime() async {
    // GETTING ZAWAL AND SUNRISE TIME START
    sunriseTimeStart = await getDecreasedTime(_prayerInfo!.sunrise, 15);
    sunsetTimeStart = await getDecreasedTime(_prayerInfo!.sunset, 6);
    zawalTimeStart = await getDecreasedTime(_prayerInfo!.dhuhr, 40);
    chashtNamazTime = await getDecreasedTime(zawalTimeStart, 120);
    currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
    await setPrayerTimeImages();
  }

  Future<String> getDecreasedTime(String? time, int decreaseFactor) async {
    List<String> splittedTime = time!.split(':');
    DateTime prayerTime = DateTime(
        0, 0, 0, int.parse(splittedTime[0]), int.parse(splittedTime[1]), 0, 0);
    prayerTime = DateTime(0, 0, 0, int.parse(splittedTime[0]),
        prayerTime.minute - decreaseFactor, 0, 0);
    String hr = "0${prayerTime.hour}";
    hr = hr.substring(hr.length - 2);
    String mnt = "0${prayerTime.minute}";
    mnt = mnt.substring(mnt.length - 2);
    return "$hr:$mnt";
  }

  Future<bool> setPrayerTimeImages() async {
    if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.fajr}")! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.sunrise}")!) {
      prayerList[0].isCurrentNamaz = true;
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.sunrise}")! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.dhuhr}")!) {
      prayerList[0].isCurrentNamaz = false;
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.dhuhr}")! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.asr}")!) {
      prayerList[1].isCurrentNamaz = true;
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.asr}")! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds(sunsetTimeStart!)!) {
      prayerList[2].isCurrentNamaz = true;
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds(sunsetTimeStart!)! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.maghrib}")!) {
      prayerList[2].isCurrentNamaz = false;
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.maghrib}")! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.isha}")!) {
      prayerList[3].isCurrentNamaz = true;
    } else if (getIntoSeconds(currentTime!)! >=
            getIntoSeconds("${_prayerInfo!.isha}")! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds('23:59:59')!) {
      prayerList[4].isCurrentNamaz = true;
    } else if (getIntoSeconds(currentTime!)! >= getIntoSeconds('00:00:00')! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.fajr}")!) {
      prayerList[4].isCurrentNamaz = true;
    }
    return true;
  }

  getHeadingText() async {
    if (getIntoSeconds(currentTime!)! >=
        getIntoSeconds("${_prayerInfo!.fajr}")! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds(sunriseTimeStart)!) {
      nowText = "Now Fajr";
      nextText = "Next Sunrise";
    } else if (getIntoSeconds(currentTime!)! >=
        getIntoSeconds(sunriseTimeStart)! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.sunrise}")!) {
      nowText = "Now Fajr";
      nextText = "Next Sunrise";
    } else if (getIntoSeconds(currentTime!)! >=
        getIntoSeconds("${_prayerInfo!.sunrise}")! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds(chashtNamazTime)!) {
      nowText = "Now Ishraq";
      nextText = "Next Chasht";
    } else if (getIntoSeconds(currentTime!)! >=
        getIntoSeconds(chashtNamazTime)! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds(zawalTimeStart)!) {
      nowText = "Now Chasht";
      nextText = "Next Zawal";
    } else if (getIntoSeconds(currentTime!)! >=
        getIntoSeconds(zawalTimeStart)! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.dhuhr}")!) {
      nowText = "Zawal Time";
      nextText = "Next Zuhr ${_prayerInfo!.dhuhr}";
    } else if (getIntoSeconds(currentTime!)! >=
        getIntoSeconds("${_prayerInfo!.dhuhr}")! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.asr}")!) {
      nowText = "Now Zuhr";
      nextText = "Next Asr ${_prayerInfo!.asr}";
    } else if (getIntoSeconds(currentTime!)! >=
        getIntoSeconds("${_prayerInfo!.asr}")! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds(sunsetTimeStart!)!) {
      nowText = "Now Asr";
      nextText = "Next Sunset";
    } else if (getIntoSeconds(currentTime!)! >=
        getIntoSeconds(sunsetTimeStart!)! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.maghrib}")!) {
      nowText = "Now Asr";
      nextText = "Next Sunset";
    } else if (getIntoSeconds(currentTime!)! >=
        getIntoSeconds("${_prayerInfo!.maghrib}")! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.isha}")!) {
      nowText = "Now Maghrib";
      nextText = "Next Ish ${_prayerInfo!.isha}";
    } else if (getIntoSeconds(currentTime!)! >=
        getIntoSeconds("${_prayerInfo!.isha}")! &&
        getIntoSeconds(currentTime!)! < getIntoSeconds('23:59:59')!) {
      nowText = "Now Isha";
      nextText = "Next Fajr ${_prayerInfo!.fajr}";
    } else if (getIntoSeconds(currentTime!)! >= getIntoSeconds('00:00:00')! &&
        getIntoSeconds(currentTime!)! <
            getIntoSeconds("${_prayerInfo!.fajr}")!) {
      nowText = "Now Isha";
      nextText = "Next Fajr ${_prayerInfo!.fajr}";
    }
  }

  int? getIntoSeconds(String? time) {
    List<String> splittedTime = time!.split(':');
    int hr_sec = int.parse(splittedTime[0]) * 60 * 60;
    int min_sec = int.parse(splittedTime[1]) * 60;
    return hr_sec + min_sec;
  }

}

