import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




class ThemeNotifier extends ChangeNotifier{
  final String key = "theme";
  SharedPreferences prefs;
  bool _darktheme;
  bool get darktheme => _darktheme;
  ThemeNotifier(){
    _darktheme=false;
    _getPrefs();
  }
  toggleTheme(){
    _darktheme=!darktheme;
    _savePrefs();
    notifyListeners();
  }

  _initPrefs()async{
    if(prefs==null)prefs=await SharedPreferences.getInstance();
  }
  _getPrefs()async{
    await _initPrefs();
    _darktheme=prefs.getBool(key)??false;
    notifyListeners();
  }
  _savePrefs()async{
   await _initPrefs();
   prefs.setBool(key, _darktheme);
  }
}