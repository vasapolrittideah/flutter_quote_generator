// ignore_for_file: prefer_const_constructors

import 'package:flutter_quote_generator/global/resources/app_failure.dart';
import 'package:flutter_quote_generator/modules/quotes/bloc/remote/quote_remote_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../factories/quote_model_factory.dart';

void main() {
  test('should support value comparisons for QuoteRemoteState.initial', () {
    expect(
      QuoteRemoteState.initial(),
      QuoteRemoteState.initial(),
    );
  });

  test('should support value comparisons for QuoteRemoteState.loading', () {
    expect(
      QuoteRemoteState.loading(),
      QuoteRemoteState.loading(),
    );
  });

  test('should support value comparisons for QuoteRemoteState.success', () {
    final quoteModelFactory = QuoteModelFactory();
    final fakeQuoteModel = quoteModelFactory.generateFake();

    expect(
      QuoteRemoteState.success(fakeQuoteModel),
      QuoteRemoteState.success(fakeQuoteModel),
    );
  });

  test('should support value comparisons for QuoteRemoteState.failure', () {
    final fakeAppFailure = AppFailure.fromException(Exception());

    expect(
      QuoteRemoteState.failure(fakeAppFailure),
      QuoteRemoteState.failure(fakeAppFailure),
    );
  });
}
