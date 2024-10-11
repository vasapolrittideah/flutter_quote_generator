import 'package:flutter_quote_generator/data/repositories/quote_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';

import '../test_injectable.dart';

@LazySingleton(as: QuoteRepository, env: [testEnv])
class QuoteRepositoryMock extends Mock implements QuoteRepository {}
