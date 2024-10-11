part of 'quote_local_bloc.dart';

@freezed
class QuoteLocalEvent with _$QuoteLocalEvent {
  const factory QuoteLocalEvent.favoriteQuoteRequested() =
      _FavoriteQuoteRequested;
  const factory QuoteLocalEvent.favoriteQuoteSaved(QuoteModel quote) =
      _FavoriteQuoteSaved;
  const factory QuoteLocalEvent.favoriteQuoteDeleted(QuoteModel quote) =
      _FavoriteQuoteDeleted;
}
