import 'package:flutter_quote_generator/data/local/hive/hive_operation.dart';
import 'package:flutter_quote_generator/data/models/quote_model.dart';
import 'package:flutter_quote_generator/data/remote/network_service.dart';
import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';

import '../test_injectable.dart';

@LazySingleton(as: NetworkService, env: [testEnv])
class NetworkServiceMock extends Mock implements NetworkService {}

@LazySingleton(as: HiveOperation<QuoteModel>, env: [testEnv])
class QuoteHiveOperationMock extends Mock
    implements HiveOperation<QuoteModel> {}
