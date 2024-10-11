// ignore_for_file: prefer_const_constructors

import 'package:flutter_quote_generator/data/models/quote_model.dart';
import 'package:flutter_quote_generator/modules/quotes/bloc/local/quote_local_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../factories/quote_model_factory.dart';

void main() {
  late QuoteModel fakeQuoteModel;

  setUpAll(() {
    final quoteModelFactory = QuoteModelFactory();
    fakeQuoteModel = quoteModelFactory.generateFake();
  });

  test(
      'should support value comparisons for QuoteLocalEvent.favoriteQuoteRequested',
      () {
    expect(
      QuoteLocalEvent.favoriteQuoteRequested(),
      QuoteLocalEvent.favoriteQuoteRequested(),
    );
  });

  test(
      'should support value comparisons for QuoteLocalEvent.favoriteQuoteDeleted',
      () {
    expect(
      QuoteLocalEvent.favoriteQuoteDeleted(fakeQuoteModel),
      QuoteLocalEvent.favoriteQuoteDeleted(fakeQuoteModel),
    );
  });

  test(
      'should support value comparisons for QuoteLocalEvent.favoriteQuoteSaved',
      () {
    final quoteModelFactory = QuoteModelFactory();
    final fakeQuoteModel = quoteModelFactory.generateFake();

    expect(
      QuoteLocalEvent.favoriteQuoteSaved(fakeQuoteModel),
      QuoteLocalEvent.favoriteQuoteSaved(fakeQuoteModel),
    );
  });
}
