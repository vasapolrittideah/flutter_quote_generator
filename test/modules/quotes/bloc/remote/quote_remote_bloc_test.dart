import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_quote_generator/data/models/quote_model.dart';
import 'package:flutter_quote_generator/data/repositories/quote_repository.dart';
import 'package:flutter_quote_generator/global/resources/app_failure.dart';
import 'package:flutter_quote_generator/modules/quotes/bloc/remote/quote_remote_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../factories/quote_model_factory.dart';
import '../../../../mocks/repository_mock.dart';
import '../../../../test_injectable.dart';

void main() {
  late QuoteRepositoryMock quoteRepositoryMock;
  late QuoteRemoteBloc quoteRemoteBloc;
  late QuoteModel fakeQuoteModel;

  setUpAll(() {
    final quoteModelFactory = QuoteModelFactory();
    fakeQuoteModel = quoteModelFactory.generateFake();

    configureTestDependencies();
    registerFallbackValue(fakeQuoteModel);
  });

  setUp(() {
    quoteRepositoryMock = getIt<QuoteRepository>() as QuoteRepositoryMock;
    quoteRemoteBloc = QuoteRemoteBloc(quoteRepositoryMock);
  });

  test('initial state should be QuoteRemoteState.initial', () {
    expect(quoteRemoteBloc.state, const QuoteRemoteState.initial());
  });

  group('QuoteRemoteEvent.newQuoteRequested', () {
    blocTest(
      'should emit [QuoteRemoteState.loading, QuoteRemoteState.success] when successful',
      setUp: () {
        when(() => quoteRepositoryMock.getNewQuote())
            .thenAnswer((_) async => Right(fakeQuoteModel));
      },
      build: () => quoteRemoteBloc,
      act: (bloc) => bloc.add(const QuoteRemoteEvent.newQuoteRequested()),
      expect: () => [
        const QuoteRemoteState.loading(),
        QuoteRemoteState.success(fakeQuoteModel),
      ],
    );

    blocTest(
      'should emit [QuoteRemoteState.loading, QuoteRemoteState.failure] when unsuccessful',
      setUp: () {
        when(() => quoteRepositoryMock.getNewQuote()).thenAnswer(
            (_) async => Left(AppFailure.fromException(Exception())));
      },
      build: () => quoteRemoteBloc,
      act: (bloc) => bloc.add(const QuoteRemoteEvent.newQuoteRequested()),
      expect: () => [
        const QuoteRemoteState.loading(),
        QuoteRemoteState.failure(AppFailure.fromException(Exception())),
      ],
    );
  });
}
