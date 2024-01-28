import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/shared_preferences_repository.dart';

final sharedPreferencesControllerProvider = Provider(
  (ref) => SharedPreferencesController(
    sharedPreferencesRepository: ref.watch(sharedPreferencesRepositoryProvider),
  ),
);

class SharedPreferencesController {
  final SharedPreferencesRepository sharedPreferencesRepository;

  SharedPreferencesController({required this.sharedPreferencesRepository});

  Future<void> saveString(String key, String value) async {
    await sharedPreferencesRepository.saveString(key, value);
  }

  Future<String?> getString(String key) async {
    return sharedPreferencesRepository.getString(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await sharedPreferencesRepository.saveBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    return sharedPreferencesRepository.getBool(key);
  }

  Future<void> saveInt(String key, int value) async {
    await sharedPreferencesRepository.saveInt(key, value);
  }

  Future<int?> getInt(String key) async {
    return sharedPreferencesRepository.getInt(key);
  }

  Future<void> saveDouble(String key, double value) async {
    await sharedPreferencesRepository.saveDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    return sharedPreferencesRepository.getDouble(key);
  }

  Future<void> saveStringList(String key, List<String> value) async {
    await sharedPreferencesRepository.saveStringList(key, value);
  }

  Future<List<String>?> getStringList(String key) async {
    return sharedPreferencesRepository.getStringList(key);
  }

  Future<void> remove(String key) async {
    await sharedPreferencesRepository.remove(key);
  }

  Future<void> clear() async {
    await sharedPreferencesRepository.clear();
  }

  Future<bool> containsKey(String key) async {
    return sharedPreferencesRepository.containsKey(key);
  }

  Future<void> reload() async {
    await sharedPreferencesRepository.reload();
  }

  Future<Set<String>> getKeys() async {
    return sharedPreferencesRepository.getKeys();
  }
}
