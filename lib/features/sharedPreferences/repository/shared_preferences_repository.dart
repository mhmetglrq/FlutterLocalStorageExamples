import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesRepositoryProvider = Provider(
  (ref) {
    SharedPreferences? prefs;
    SharedPreferences.getInstance().then((value) => prefs = value);
    return SharedPreferencesRepository(
      prefs: prefs,
    );
  },
);

class SharedPreferencesRepository {
  SharedPreferences? prefs;
  SharedPreferencesRepository({required this.prefs});

  Future<void> saveString(String key, String value) async {
    await prefs?.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return prefs?.getString(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await prefs?.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    return prefs?.getBool(key);
  }

  Future<void> saveInt(String key, int value) async {
    await prefs?.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    return prefs?.getInt(key);
  }

  Future<void> saveDouble(String key, double value) async {
    await prefs?.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    return prefs?.getDouble(key);
  }

  Future<void> saveStringList(String key, List<String> value) async {
    await prefs?.setStringList(key, value);
  }

  Future<List<String>?> getStringList(String key) async {
    return prefs?.getStringList(key);
  }

  Future<void> remove(String key) async {
    await prefs?.remove(key);
  }

  Future<void> clear() async {
    await prefs?.clear();
  }

  Future<bool> containsKey(String key) async {
    return prefs!.containsKey(key);
  }

  Future<Set<String>> getKeys() async {
    return prefs!.getKeys();
  }

  Future<void> reload() async {
    await prefs?.reload();
  }

  Future<bool> isInitialized() async {
    return prefs!.getKeys().isNotEmpty;
  }

  Future<bool> isNotInitialized() async {
    return prefs!.getKeys().isEmpty;
  }

  Future<bool> isInitializedKey(String key) async {
    return prefs!.containsKey(key);
  }

  Future<bool> isNotInitializedKey(String key) async {
    return !prefs!.containsKey(key);
  }
}
