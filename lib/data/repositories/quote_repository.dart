import 'package:dartz/dartz.dart';

import 'package:flutter_quote_generator/data/models/quote_model.dart';
import 'package:flutter_quote_generator/global/resources/app_failure.dart';

abstract class QuoteRepository {
  Future<Either<AppFailure, QuoteModel>> getNewQuote();
  Future<List<QuoteModel>> getFavoriteQuotes();
  Future saveFavoriteQuote(QuoteModel quoteModel);
  Future deleteFavoriteQuote(int quoteId);
}
