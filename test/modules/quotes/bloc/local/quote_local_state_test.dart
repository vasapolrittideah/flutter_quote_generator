// ignore_for_file: prefer_const_constructors

import 'package:flutter_quote_generator/data/models/quote_model.dart';
import 'package:flutter_quote_generator/modules/quotes/bloc/local/quote_local_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../factories/quote_model_factory.dart';

void main() {
  late List<QuoteModel> fakeQuoteModels;

  setUpAll(() {
    final quoteModelFactory = QuoteModelFactory();
    fakeQuoteModels = quoteModelFactory.generateFakeList(length: 3);
  });

  test('should support value comparisons for QuoteLocalState.initial', () {
    expect(
      QuoteLocalState.initial(),
      QuoteLocalState.initial(),
    );
  });

  test('should support value comparisons for QuoteLocalState.loading', () {
    expect(
      QuoteLocalState.loading(),
      QuoteLocalState.loading(),
    );
  });

  test('should support value comparisons for QuoteLocalState.loaded', () {
    expect(
      QuoteLocalState.loaded(fakeQuoteModels),
      QuoteLocalState.loaded(fakeQuoteModels),
    );
  });
}
