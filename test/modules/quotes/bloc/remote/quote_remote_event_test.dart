// ignore_for_file: prefer_const_constructors

import 'package:flutter_quote_generator/modules/quotes/bloc/remote/quote_remote_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'should support value comparisons for QuoteRemoteEvent.newQuoteRequested',
      () {
    expect(
      QuoteRemoteEvent.newQuoteRequested(),
      QuoteRemoteEvent.newQuoteRequested(),
    );
  });
}
