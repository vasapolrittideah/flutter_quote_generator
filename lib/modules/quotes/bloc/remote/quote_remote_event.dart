part of 'quote_remote_bloc.dart';

@freezed
class QuoteRemoteEvent with _$QuoteRemoteEvent {
  const factory QuoteRemoteEvent.newQuoteRequested() = _NewQuoteRequested;
}
