import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';

import '../../global/constants/hive_constants.dart';

part 'quote_model.freezed.dart';
part 'quote_model.g.dart';

@freezed
abstract class QuoteModel extends HiveObject with _$QuoteModel {
  QuoteModel._();

  @HiveType(
    typeId: HiveConstants.quoteTypeId,
    adapterName: HiveConstants.quoteAdapterName,
  )
  factory QuoteModel({
    @HiveField(1) required int id,
    @HiveField(2) required String quote,
    @HiveField(3) required String author,
  }) = _QuoteModel;

  factory QuoteModel.fromJson(Map<String, dynamic> json) =>
      _$QuoteModelFromJson(json);
}
