import 'package:flutter/material.dart';

import 'L10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale("en");
  double _scale = 1.0;

  Locale get locale => _locale;
  double get scale => _scale;

  void setLocale(Locale locale ,{bool shouldUpdate=true}) {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    if(shouldUpdate)
    notifyListeners();
  }
  void setScale(double scale) {

    _scale = scale;

    notifyListeners();
  }

  void clearLocale() {
    _locale = Locale('en');
    notifyListeners();
  }
}
