import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_quote_generator/data/local/hive/hive_encryption.dart';
import 'package:flutter_quote_generator/data/local/hive/hive_operation.dart';
import 'package:flutter_quote_generator/data/local/primitive/primitive_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mocktail/mocktail.dart';

class FakeType extends Fake implements Type {}

class HiveBoxMock<T> extends Mock implements Box<T> {}

class HiveEncryptionMock extends Mock implements HiveEncryption {}

class HiveInterfaceMock extends Mock implements HiveInterface {}

class PrimitiveDatabaseMock extends Mock implements PrimitiveDatabase {}

void main() {
  late HiveInterfaceMock hiveMock;
  late HiveEncryptionMock hiveEncryptionMock;
  late PrimitiveDatabaseMock primitiveDatabaseMock;
  late HiveBoxMock<FakeType> hiveBoxMock;
  late HiveOperation<FakeType> hiveOperation;

  setUpAll(() {
    registerFallbackValue(FakeType());
  });

  setUp(() {
    hiveMock = HiveInterfaceMock();
    primitiveDatabaseMock = PrimitiveDatabaseMock();
    hiveEncryptionMock = HiveEncryptionMock();
    hiveBoxMock = HiveBoxMock();
    hiveOperation = HiveOperation(
      hiveMock,
      primitiveDatabaseMock,
      hiveEncryption: hiveEncryptionMock,
    );

    final Uint8List secureKey = Uint8List.fromList(
        List.generate(32, (index) => Random.secure().nextInt(256)));

    when(() => hiveMock.isBoxOpen(any())).thenReturn(false);
    when(() => hiveEncryptionMock.getSecureKey())
        .thenAnswer((_) async => secureKey);
    when(() => hiveMock.openBox<FakeType>(
          any(),
          encryptionCipher: any(named: 'encryptionCipher'),
        )).thenAnswer((_) async => hiveBoxMock);
  });

  test(
      'HiveEncryption should not be empty when not provided in the hive operation',
      () {
    final hiveOperation = HiveOperation(hiveMock, primitiveDatabaseMock);

    expect(hiveOperation.encryption, isNotNull);
  });

  group('startBox', () {
    test('should open a new box with an encrypted key when the box is not open',
        () async {
      await hiveOperation.startBox();

      verify(() => hiveEncryptionMock.getSecureKey());
      verify(
        () => hiveMock.openBox<FakeType>(
          'FakeType',
          encryptionCipher: any(named: 'encryptionCipher'),
        ),
      );
    });

    test('should not open a new box again when the box is already open',
        () async {
      when(() => hiveMock.isBoxOpen(any())).thenReturn(true);

      await hiveOperation.startBox();

      verifyNever(
        () => hiveMock.openBox<FakeType>(
          'FakeType',
          encryptionCipher: any(named: 'encryptionCipher'),
        ),
      );
    });
  });

  group('insertOrUpdateItem', () {
    test('should put an item in the box at the specified key', () async {
      const key = 'someKey';
      final model = FakeType();
      when(() => hiveBoxMock.put(key, any())).thenAnswer((_) async {});

      await hiveOperation.insertOrUpdateItem(key, model);

      verify(() => hiveBoxMock.put(key, model));
    });
  });

  group('insertOrUpdateItems', () {
    test('should put multiple items in the box at the specified key', () async {
      final keys = List.generate(8, (index) => 'key-$index');
      final models = List.generate(8, (index) => FakeType());
      when(() => hiveBoxMock.putAll(any())).thenAnswer((_) async {});

      await hiveOperation.insertOrUpdateItems(keys, models);

      verify(() => hiveBoxMock.putAll(Map.fromIterables(keys, models)));
    });

    test(
        'should throw ArgumentError when the number of keys and models are different',
        () async {
      final keys = List.generate(8, (index) => 'key-$index');
      final models = List.generate(6, (index) => FakeType());

      await expectLater(
        hiveOperation.insertOrUpdateItems(keys, models),
        throwsArgumentError,
      );
    });
  });

  group('getItem', () {
    test('should return an item of type T from the box at the specified key',
        () async {
      const key = 'someKey';
      final model = FakeType();
      when(() => hiveBoxMock.get(key)).thenReturn(model);

      final result = await hiveOperation.getItem(key);

      verify(() => hiveBoxMock.get(key));
      expect(result, equals(model));
    });
  });

  group('getAllItems', () {
    test('should return all items of type T from the box', () async {
      final models = List.generate(8, (index) => FakeType());
      when(() => hiveBoxMock.values.toList()).thenReturn(models);

      final result = await hiveOperation.getAllItems();

      verify(() => hiveBoxMock.values.toList());
      expect(result, equals(models));
    });
  });

  group('deleteItem', () {
    test('should delete an item from the box at the specified key', () async {
      const key = 'someKey';
      when(() => hiveBoxMock.delete(key)).thenAnswer((_) async {});

      await hiveOperation.deleteItem(key);

      verify(() => hiveBoxMock.delete(key));
    });
  });

  group('deleteAllItems', () {
    test('should delete all items from the box', () async {
      when(() => hiveBoxMock.clear()).thenAnswer((_) async => 0);

      await hiveOperation.deleteAllItems();

      verify(() => hiveBoxMock.clear());
    });
  });
}
