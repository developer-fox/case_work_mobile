
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/enums/locale_keys_enum.dart';

/// [LocaleManager] class enables shared_preferences operations to be more efficient and manageable over a single instance.
class LocaleManager{
  static LocaleManager? _instance =  LocaleManager._init();
  static LocaleManager get instance{
    _instance ??= LocaleManager._init();
    return _instance!;
  }

  SharedPreferences? _sharedPreferences;
  LocaleManager._init(){
    SharedPreferences.getInstance().then((value) => _sharedPreferences = value);
  }

  // Creates a shared_preferences instance
  static preferencesInit() async{
    instance._sharedPreferences ??= await SharedPreferences.getInstance();
    return;
  }

  Future<void> setStringValue(PreferencesKeys key, String value) async {
    await _sharedPreferences?.setString(key.toString(), value);
  }

  Future<void> deleteValue(PreferencesKeys key) async {
    await _sharedPreferences?.remove(key.toString());  
  }

  /// Converts the parameter [PreferencesKeys] to string data and then returns it from local storage.
  String getStringValue(PreferencesKeys key) => _sharedPreferences?.getString(key.toString()) ?? "";

  Future<void> setIntValue(PreferencesKeys key, int value) async {
    await _sharedPreferences?.setInt(key.toString(), value);
  }

  int getIntValue(PreferencesKeys key) =>
    _sharedPreferences?.getInt(key.toString()) ?? 0;

  Future<void> logout() async {
    await _sharedPreferences?.remove(PreferencesKeys.x_access_refresh_key.toString());
    await _sharedPreferences?.remove(PreferencesKeys.x_access_key.toString());
  }
}