import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_quote_generator/data/local/hive/hive_encryption.dart';
import 'package:flutter_quote_generator/data/local/primitive/primitive_keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'hive_operation_test.dart';

void main() {
  late HiveInterfaceMock hiveMock;
  late PrimitiveDatabaseMock primitiveDatabaseMock;
  late HiveEncryption hiveEncryption;

  setUpAll(() {
    registerFallbackValue(PrimitiveKeys.secureStorageKey);
  });

  setUp(() {
    hiveMock = HiveInterfaceMock();
    primitiveDatabaseMock = PrimitiveDatabaseMock();
    hiveEncryption = HiveEncryption(hiveMock, primitiveDatabaseMock);
  });

  group('getSecureKey', () {
    test(
        'should return the existing encryption key when the primitive database contains it',
        () async {
      const secureKey = 'c2VjdXJlS2V5'; // 'secureKey' in base64URL

      when(
        () =>
            primitiveDatabaseMock.read<String>(PrimitiveKeys.secureStorageKey),
      ).thenAnswer((_) async => secureKey);

      final result = await hiveEncryption.getSecureKey();

      expect(result, equals(base64Url.decode(secureKey)));
    });

    test(
        'should generate a new encryption key when the primitive database does not contain it',
        () async {
      const secureKey = 'c2VjdXJlS2V5'; // 'secureKey' in base64URL
      final fakePrimitiveDatabaseReadResponses = [null, secureKey];

      when(
        () =>
            primitiveDatabaseMock.read<String>(PrimitiveKeys.secureStorageKey),
      ).thenAnswer((_) async => fakePrimitiveDatabaseReadResponses.removeAt(0));
      when(
        () => primitiveDatabaseMock.write<String>(
          PrimitiveKeys.secureStorageKey,
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async => true);
      when(() => hiveMock.generateSecureKey()).thenReturn([]);

      final result = await hiveEncryption.getSecureKey();

      verifyInOrder([
        () => hiveMock.generateSecureKey(),
        () => primitiveDatabaseMock.write<String>(
              PrimitiveKeys.secureStorageKey,
              data: any(named: 'data'),
            )
      ]);
      expect(result, equals(base64Url.decode(secureKey)));
    });

    test(
        'should throw an exception when the primitive could not store the encryption key',
        () async {
      when(
        () =>
            primitiveDatabaseMock.read<String>(PrimitiveKeys.secureStorageKey),
      ).thenAnswer((_) async => null);
      when(
        () => primitiveDatabaseMock.write<String>(
          PrimitiveKeys.secureStorageKey,
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async => true);
      when(() => hiveMock.generateSecureKey()).thenReturn([]);

      expectLater(hiveEncryption.getSecureKey(), throwsException);
    });

    test(
        'should return the encryption key right away when it is save in memory',
        () async {
      final Uint8List encryptionKey = Uint8List.fromList(
        List.generate(32, (index) => Random.secure().nextInt(256)),
      );
      hiveEncryption.encryptionKey = encryptionKey;

      final result = await hiveEncryption.getSecureKey();

      expect(result, equals(encryptionKey));
      verifyNever(() =>
          primitiveDatabaseMock.read<String>(PrimitiveKeys.secureStorageKey));
    });
  });
}
