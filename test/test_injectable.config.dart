// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_quote_generator/data/local/hive/hive_operation.dart'
    as _i883;
import 'package:flutter_quote_generator/data/models/quote_model.dart' as _i1046;
import 'package:flutter_quote_generator/data/remote/network_service.dart'
    as _i838;
import 'package:flutter_quote_generator/data/repositories/quote_repository.dart'
    as _i750;
import 'package:flutter_quote_generator/modules/quotes/bloc/local/quote_local_bloc.dart'
    as _i638;
import 'package:flutter_quote_generator/modules/quotes/bloc/remote/quote_remote_bloc.dart'
    as _i823;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'mocks/bloc_mock.dart' as _i309;
import 'mocks/datasource_mock.dart' as _i795;
import 'mocks/repository_mock.dart' as _i1051;

const String _test = 'test';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt testInit({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i750.QuoteRepository>(
      () => _i1051.QuoteRepositoryMock(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i823.QuoteRemoteBloc>(
      () => _i309.QuoteRemoteBlocMock(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i883.HiveOperation<_i1046.QuoteModel>>(
      () => _i795.QuoteHiveOperationMock(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i638.QuoteLocalBloc>(
      () => _i309.QuoteLocalBlocMock(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i838.NetworkService>(
      () => _i795.NetworkServiceMock(),
      registerFor: {_test},
    );
    return this;
  }
}
