import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_storage/features/hive/repository/hive_repository.dart';

final hiveControllerProvider = Provider((ref) {
  final hiveRepository = ref.watch(hiveRepositoryProvider);
  return HiveController(hiveRepository: hiveRepository);
});

class HiveController {
  final HiveRepository hiveRepository;

  HiveController({required this.hiveRepository});

  Future<String> get(String key) async {
    return hiveRepository.get(key);
  }

  Future<void> add(String key, String value) async {
    await hiveRepository.add(key, value);
  }

  Future<void> delete(String key) async {
    await hiveRepository.delete(key);
  }

  Future<void> update(String key, String value) async {
    await hiveRepository.update(key, value);
  }

  Future<void> clear() async {
    await hiveRepository.clear();
  }

  Future<List<String>> getAll() async {
    return hiveRepository.getAll();
  }

  Future<void> addAll(List<String> values) async {
    await hiveRepository.addAll(values);
  }

  Future<void> deleteAll(List<String> keys) async {
    await hiveRepository.deleteAll(keys);
  }

  Future<void> updateAll(List<String> keys, List<String> values) async {
    await hiveRepository.updateAll(keys, values);
  }

  Future<void> close() async {
    await hiveRepository.close();
  }
}
