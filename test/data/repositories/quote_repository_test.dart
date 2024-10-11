import 'dart:convert';

import 'package:flutter_quote_generator/data/local/hive/hive_operation.dart';
import 'package:flutter_quote_generator/data/models/quote_model.dart';
import 'package:flutter_quote_generator/data/remote/network_service.dart';
import 'package:flutter_quote_generator/data/repositories/quote_repository_impl.dart';
import 'package:flutter_quote_generator/global/constants/api_constants.dart';
import 'package:flutter_quote_generator/global/resources/app_failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../factories/quote_model_factory.dart';
import '../../fixtures/fixture_reader.dart';
import '../../mocks/datasource_mock.dart';
import '../../test_helpers.dart';
import '../../test_injectable.dart';

void main() {
  late NetworkServiceMock networkServiceMock;
  late QuoteHiveOperationMock quoteHiveOperation;
  late QuoteRepositoryImpl quoteRepository;
  late List<QuoteModel> fakeQuoteModels;
  late QuoteModel fakeQuoteModel;

  setUpAll(() {
    configureTestDependencies();

    networkServiceMock = getIt<NetworkService>() as NetworkServiceMock;
    quoteHiveOperation =
        getIt<HiveOperation<QuoteModel>>() as QuoteHiveOperationMock;
    quoteRepository =
        QuoteRepositoryImpl(networkServiceMock, quoteHiveOperation);

    final quoteModelFactory = QuoteModelFactory();
    fakeQuoteModels = quoteModelFactory.generateFakeList(length: 3);
    fakeQuoteModel = quoteModelFactory.generateFake();
  });

  group('getNewQuote', () {
    test('should return QuoteModel when the response code is 200', () async {
      const fixtureName = 'quote.json';

      setUpNetworkServiceMockSuccess200(
        networkServiceMock,
        fixtureName: fixtureName,
      );

      final result = await quoteRepository.getNewQuote();

      verify(
        () => networkServiceMock.get(
          '${ApiConstants.quoteBaseUrl}/random',
        ),
      );
      result.fold(
        (l) => fail('test failed'),
        (r) => expect(
          r,
          equals(QuoteModel.fromJson(jsonDecode(fixture(fixtureName)))),
        ),
      );
    });

    test(
        'should return AppFailure.notFound when the response code is 404 or other',
        () async {
      setUpNetworkServiceMockFailure404(networkServiceMock);

      final result = await quoteRepository.getNewQuote();

      verify(
        () => networkServiceMock.get(
          '${ApiConstants.quoteBaseUrl}/random',
        ),
      );
      result.fold(
        (l) => expect(l, const AppFailure.notFound('Not found')),
        (r) => fail('test failed'),
      );
    });
  });

  group('getFavoriteQuotes', () {
    test('should return List<QuoteModel> without throwing an exception',
        () async {
      when(() => quoteHiveOperation.getAllItems())
          .thenAnswer((_) async => fakeQuoteModels);

      final quotes = await quoteRepository.getFavoriteQuotes();

      expect(quotes, fakeQuoteModels);
    });
  });

  group('saveFavoriteQuote', () {
    test('should save QuoteModel to Hive with the appropriate key', () async {
      when(() => quoteHiveOperation.insertOrUpdateItem(any(), fakeQuoteModel))
          .thenAnswer((_) async {});

      await quoteRepository.saveFavoriteQuote(fakeQuoteModel);

      verify(
        () => quoteHiveOperation.insertOrUpdateItem(
            fakeQuoteModel.id.toString(), fakeQuoteModel),
      );
    });
  });

  group('deleteFavoriteQuote', () {
    test('should delete QuoteModel from Hive with the appropriate key',
        () async {
      when(() => quoteHiveOperation.deleteItem(any())).thenAnswer((_) async {});

      await quoteRepository.deleteFavoriteQuote(fakeQuoteModel.id);

      verify(
        () => quoteHiveOperation.deleteItem(fakeQuoteModel.id.toString()),
      );
    });
  });
}
