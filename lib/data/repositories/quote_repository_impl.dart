import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_quote_generator/data/local/hive/hive_operation.dart';
import 'package:flutter_quote_generator/data/models/quote_model.dart';
import 'package:flutter_quote_generator/data/remote/network_service.dart';
import 'package:flutter_quote_generator/data/repositories/quote_repository.dart';
import 'package:flutter_quote_generator/global/constants/api_constants.dart';
import 'package:flutter_quote_generator/global/resources/app_failure.dart';

@Injectable(as: QuoteRepository)
final class QuoteRepositoryImpl implements QuoteRepository {
  QuoteRepositoryImpl(this._networkService, this._hiveOperation);

  final NetworkService _networkService;
  final HiveOperation<QuoteModel> _hiveOperation;

  @override
  Future<Either<AppFailure, QuoteModel>> getNewQuote() async {
    try {
      final response = await _networkService.get(
        '${ApiConstants.quoteBaseUrl}/random',
      );

      return Right(QuoteModel.fromJson(response.data));
    } on Exception catch (error) {
      return Left(AppFailure.fromException(error));
    }
  }

  @override
  Future<List<QuoteModel>> getFavoriteQuotes() async {
    return await _hiveOperation.getAllItems();
  }

  @override
  Future<void> saveFavoriteQuote(QuoteModel quoteModel) async {
    await _hiveOperation.insertOrUpdateItem(
      quoteModel.id.toString(),
      quoteModel,
    );
  }

  @override
  Future deleteFavoriteQuote(int quoteId) async {
    await _hiveOperation.deleteItem(quoteId.toString());
  }
}
