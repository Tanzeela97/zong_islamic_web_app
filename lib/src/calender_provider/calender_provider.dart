import 'package:flutter/material.dart';

class CalenderProvider extends ChangeNotifier {
  int fajar = 0;
  int zohar = 0;
  int asr = 0;
  int magrib = 0;
  int isha = 0;

  void setFajar(int value){
  fajar=value;
  notifyListeners();
}

  void setZohar(int value){
    zohar=value;
    notifyListeners();
  }
  void setAsr(int value){
    asr=value;
    notifyListeners();
  }
  void setMagrib(int value){
    magrib=value;
    notifyListeners();
  }
  void setIsha(int value){
    isha=value;
    notifyListeners();
  }
}
