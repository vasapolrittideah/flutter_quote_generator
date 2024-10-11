part of 'quote_local_bloc.dart';

@freezed
class QuoteLocalState with _$QuoteLocalState {
  const factory QuoteLocalState.initial() = _Initial;
  const factory QuoteLocalState.loading() = _Loading;
  const factory QuoteLocalState.loaded(List<QuoteModel> quotes) = _Loaded;
}
