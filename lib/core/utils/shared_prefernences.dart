import 'package:moonrider_task/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  Future<DateTime?> getLastDate() async {
    final pref = await getSharedInstance();
    final value = pref.getString(AppConstants.LastScratchPrefKey);
    if (value == null) return null;
    DateTime date = DateTime.parse(value);
    return date;
  }

  Future<void> setInteger(String key, int coins) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, coins);
    return;
  }

  Future<int?> getInteger(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<void> setLastDate(String date) async {
    final pref = await getSharedInstance();
    await pref.setString(AppConstants.LastScratchPrefKey, date);
    return;
  }

  Future<SharedPreferences> getSharedInstance() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref;
  }
}
