import 'package:flutter/cupertino.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../primitive/primitive_database.dart';
import 'hive_encryption.dart';

@injectable
class HiveOperation<T> {
  @visibleForTesting
  late final HiveEncryption encryption;
  late final HiveInterface _hive;
  final String _key = T.toString();
  Box<T>? _box;

  HiveOperation(
    this._hive,
    PrimitiveDatabase primitiveDatabase, {
    @factoryParam HiveEncryption? hiveEncryption,
  }) : encryption = hiveEncryption ?? HiveEncryption(_hive, primitiveDatabase);

  Future<void> startBox() async {
    if (_hive.isBoxOpen(_key)) {
      return;
    }

    final encryptionKey = await encryption.getSecureKey();
    _box = await _hive.openBox<T>(
      _key,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
  }

  Future<void> insertOrUpdateItem(String key, T model) =>
      _run<void>(() => _box!.put(key, model));

  Future<void> insertOrUpdateItems(List<String> keys, List<T> models) =>
      _run<void>(() async {
        if (keys.length != models.length) {
          throw ArgumentError('Number of keys and models should be the same');
        }

        final map = Map.fromIterables(keys, models);
        await _box!.putAll(map);
      });

  Future<T?> getItem(String key) => _run<T?>(() => _box!.get(key));

  Future<List<T>> getAllItems() => _run<List<T>>(() => _box!.values.toList());

  Future<void> deleteItem(String key) => _run<void>(() => _box!.delete(key));

  Future<void> deleteAllItems() => _run<void>(() => _box!.clear());

  Future<U> _run<U>(U Function() operation) async {
    if (_box == null) await startBox();
    return operation();
  }
}