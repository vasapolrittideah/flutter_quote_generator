import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_quote_generator/data/models/quote_model.dart';
import 'package:flutter_quote_generator/data/repositories/quote_repository.dart';
import 'package:flutter_quote_generator/modules/quotes/bloc/local/quote_local_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import '../../../../factories/quote_model_factory.dart';
import '../../../../mocks/repository_mock.dart';
import '../../../../test_injectable.dart';

void main() {
  late QuoteRepositoryMock quoteRepositoryMock;
  late QuoteLocalBloc quoteLocalBloc;
  late QuoteModel fakeQuoteModel;
  late List<QuoteModel> fakeQuoteModels;

  setUpAll(() {
    final quoteModelFactory = QuoteModelFactory();
    fakeQuoteModels = quoteModelFactory.generateFakeList(length: 3);
    fakeQuoteModel = quoteModelFactory.generateFake();

    configureTestDependencies();
    registerFallbackValue(fakeQuoteModel);
  });

  setUp(() {
    quoteRepositoryMock = getIt.get<QuoteRepository>() as QuoteRepositoryMock;
    quoteLocalBloc = QuoteLocalBloc(quoteRepositoryMock);
  });

  test('initial state should be QuoteLocalState.initial', () {
    expect(quoteLocalBloc.state, const QuoteLocalState.initial());
  });

  group('QuoteLocalEvent.favoriteQuoteRequested', () {
    blocTest(
      'should emit [QuoteLocalState.loading, QuoteLocalState.loaded]',
      setUp: () {
        when(() => quoteRepositoryMock.getFavoriteQuotes())
            .thenAnswer((_) async => fakeQuoteModels);
      },
      build: () => quoteLocalBloc,
      act: (bloc) => bloc.add(const QuoteLocalEvent.favoriteQuoteRequested()),
      expect: () => <QuoteLocalState>[
        const QuoteLocalState.loading(),
        QuoteLocalState.loaded(fakeQuoteModels),
      ],
      verify: (_) => verify(() => quoteRepositoryMock.getFavoriteQuotes()),
    );
  });

  group('QuoteLocalEvent.favoriteQuoteSaved', () {
    blocTest(
      'should emit [QuoteLocalState.loading, QuoteLocalState.loaded]',
      setUp: () {
        when(() => quoteRepositoryMock.getFavoriteQuotes())
            .thenAnswer((_) async => fakeQuoteModels);
        when(() => quoteRepositoryMock.saveFavoriteQuote(any()))
            .thenAnswer((_) async {});
      },
      build: () => quoteLocalBloc,
      act: (bloc) =>
          bloc.add(QuoteLocalEvent.favoriteQuoteSaved(fakeQuoteModel)),
      expect: () => <QuoteLocalState>[
        const QuoteLocalState.loading(),
        QuoteLocalState.loaded(fakeQuoteModels),
      ],
      verify: (_) {
        verifyInOrder([
          () => quoteRepositoryMock.saveFavoriteQuote(any()),
          () => quoteRepositoryMock.getFavoriteQuotes(),
        ]);
      },
    );
  });

  group('QuoteLocalEvent.favoriteQuoteDeleted', () {
    blocTest(
      'should emit [QuoteLocalState.loading, QuoteLocalState.loaded]',
      setUp: () {
        when(() => quoteRepositoryMock.getFavoriteQuotes())
            .thenAnswer((_) async => fakeQuoteModels);
        when(() => quoteRepositoryMock.deleteFavoriteQuote(any()))
            .thenAnswer((_) async {});
      },
      build: () => quoteLocalBloc,
      act: (bloc) =>
          bloc.add(QuoteLocalEvent.favoriteQuoteDeleted(fakeQuoteModel)),
      expect: () => <QuoteLocalState>[
        const QuoteLocalState.loading(),
        QuoteLocalState.loaded(fakeQuoteModels),
      ],
      verify: (_) {
        verifyInOrder([
          () => quoteRepositoryMock.deleteFavoriteQuote(fakeQuoteModel.id),
          () => quoteRepositoryMock.getFavoriteQuotes(),
        ]);
      },
    );
  });
}
