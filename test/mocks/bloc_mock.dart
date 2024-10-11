import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_quote_generator/modules/quotes/bloc/local/quote_local_bloc.dart';
import 'package:flutter_quote_generator/modules/quotes/bloc/remote/quote_remote_bloc.dart';
import 'package:injectable/injectable.dart';

import '../test_injectable.dart';

@LazySingleton(as: QuoteRemoteBloc, env: [testEnv])
class QuoteRemoteBlocMock extends MockBloc<QuoteRemoteEvent, QuoteRemoteState>
    implements QuoteRemoteBloc {}

@LazySingleton(as: QuoteLocalBloc, env: [testEnv])
class QuoteLocalBlocMock extends MockBloc<QuoteLocalEvent, QuoteLocalState>
    implements QuoteLocalBloc {}
