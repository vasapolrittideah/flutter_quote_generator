import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_quote_generator/data/repositories/quote_repository.dart';
import '../../../../data/models/quote_model.dart';

part 'quote_local_event.dart';
part 'quote_local_state.dart';
part 'quote_local_bloc.freezed.dart';

@injectable
class QuoteLocalBloc extends Bloc<QuoteLocalEvent, QuoteLocalState> {
  QuoteLocalBloc(
    this._quoteRepository,
  ) : super(const QuoteLocalState.initial()) {
    on<QuoteLocalEvent>((events, emit) async {
      await events.map(
        favoriteQuoteRequested: (event) async {
          return _favoriteQuoteRequested(event, emit);
        },
        favoriteQuoteSaved: (event) async {
          return _favoriteQuoteSaved(event, emit);
        },
        favoriteQuoteDeleted: (event) async {
          return _favoriteQuoteDeleted(event, emit);
        },
      );
    });
  }

  final QuoteRepository _quoteRepository;

  Future _favoriteQuoteRequested(
    _FavoriteQuoteRequested event,
    Emitter<QuoteLocalState> emit,
  ) async {
    emit(const QuoteLocalState.loading());

    final quotes = await _quoteRepository.getFavoriteQuotes();
    // await Future.delayed(const Duration(seconds: 3));

    emit(QuoteLocalState.loaded(quotes));
  }

  Future _favoriteQuoteSaved(
    _FavoriteQuoteSaved event,
    Emitter<QuoteLocalState> emit,
  ) async {
    emit(const QuoteLocalState.loading());

    await _quoteRepository.saveFavoriteQuote(event.quote);

    add(const QuoteLocalEvent.favoriteQuoteRequested());
  }

  Future _favoriteQuoteDeleted(
    _FavoriteQuoteDeleted event,
    Emitter<QuoteLocalState> emit,
  ) async {
    emit(const QuoteLocalState.loading());

    await _quoteRepository.deleteFavoriteQuote(event.quote.id);

    add(const QuoteLocalEvent.favoriteQuoteRequested());
  }
}
