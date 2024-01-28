import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final hiveRepositoryProvider = Provider((ref) {
  Box<dynamic>? box;
  if (Hive.isBoxOpen('myBox')) {
    box = Hive.box('myBox');
  } else {
    Hive.openBox('myBox').then((value) => box = value);
  }
  return HiveRepository(box: box);
});

class HiveRepository {
  final Box<dynamic>? box;

  HiveRepository({required this.box});

  Future<String> get(String key) async {
    final box = await Hive.openBox('myBox');
    return box.get(key);
  }

  Future<void> add(String key, String value) async {
    final box = await Hive.openBox('myBox');
    await box.put(key, value);
  }

  Future<void> delete(String key) async {
    final box = await Hive.openBox('myBox');
    await box.delete(key);
  }

  Future<void> update(String key, String value) async {
    final box = await Hive.openBox('myBox');
    await box.put(key, value);
  }

  Future<void> clear() async {
    final box = await Hive.openBox('myBox');
    await box.clear();
  }

  Future<List<String>> getAll() async {
    final box = await Hive.openBox('myBox');
    return box.values.toList().cast<String>();
  }

  Future<void> addAll(List<String> values) async {
    final box = await Hive.openBox('myBox');
    await box.addAll(values);
  }

  Future<void> deleteAll(List<String> keys) async {
    final box = await Hive.openBox('myBox');
    await box.deleteAll(keys);
  }

  Future<void> updateAll(List<String> keys, List<String> values) async {
    final box = await Hive.openBox('myBox');
    await box.putAll(Map.fromIterables(keys, values));
  }

  Future<void> close() async {
    final box = await Hive.openBox('myBox');
    await box.close();
  }
}
