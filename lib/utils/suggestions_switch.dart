import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuggestionTipsProvider with ChangeNotifier {
  bool _showTips = true;

  bool get showTips => _showTips;

  Future<void> loadShowTips() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? showTipsValue = prefs.getBool('showTips');
    if (showTipsValue == null) {
      _showTips = true;
    } else {
      _showTips = showTipsValue;
    }
    notifyListeners();
  }

  Future<void> setShowTips(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showTips', value);
    _showTips = value;
    notifyListeners();
  }
}
