import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_quote_generator/data/models/quote_model.dart';
import 'package:flutter_quote_generator/global/resources/app_failure.dart';
import '../../../../data/repositories/quote_repository.dart';

part 'quote_remote_event.dart';
part 'quote_remote_state.dart';
part 'quote_remote_bloc.freezed.dart';

@injectable
class QuoteRemoteBloc extends Bloc<QuoteRemoteEvent, QuoteRemoteState> {
  QuoteRemoteBloc(
    this._quoteRepository,
  ) : super(const QuoteRemoteState.initial()) {
    on<QuoteRemoteEvent>((events, emit) async {
      await events.map(
        newQuoteRequested: (event) async {
          return _newQuoteRequested(event, emit);
        },
      );
    });
  }

  final QuoteRepository _quoteRepository;

  Future _newQuoteRequested(
    _NewQuoteRequested event,
    Emitter<QuoteRemoteState> emit,
  ) async {
    emit(const QuoteRemoteState.loading());

    final result = await _quoteRepository.getNewQuote();

    result.fold(
      (l) => emit(QuoteRemoteState.failure(l)),
      (r) => emit(QuoteRemoteState.success(r)),
    );
  }
}
