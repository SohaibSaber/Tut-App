import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/presentation/resources/language_manager.dart';

// const String prefs_key_lang = "prefs_key_lang";
// class AppPreferences{
//
//   SharedPreferences _sharedPreferences;
//
//   AppPreferences(this._sharedPreferences);
//
//   Future<String> getAppLanguage() async{
//
//     String? language = _sharedPreferences.getString(prefs_key_lang);
//
//     if (language !=null && language.isNotEmpty){
//       return language;
//     }else{
//       return LanguageType.english.getValue();
//     }
//   }
// }
const String PREFS_KEY_LANG = "PREFS_KEY_LANG";

class AppPreferences {
  SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }
}