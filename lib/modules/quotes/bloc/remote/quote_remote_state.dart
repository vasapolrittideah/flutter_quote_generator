part of 'quote_remote_bloc.dart';

@freezed
class QuoteRemoteState with _$QuoteRemoteState {
  const factory QuoteRemoteState.initial() = _Initial;
  const factory QuoteRemoteState.loading() = _Loading;
  const factory QuoteRemoteState.success(QuoteModel quote) = _Success;
  const factory QuoteRemoteState.failure(AppFailure failure) = _Failure;
}
