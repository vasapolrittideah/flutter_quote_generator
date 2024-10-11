// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_quote_generator/data/local/hive/hive_encryption.dart'
    as _i26;
import 'package:flutter_quote_generator/data/local/hive/hive_manager.dart'
    as _i140;
import 'package:flutter_quote_generator/data/local/hive/hive_operation.dart'
    as _i883;
import 'package:flutter_quote_generator/data/local/primitive/primitive_database.dart'
    as _i959;
import 'package:flutter_quote_generator/data/models/quote_model.dart' as _i1046;
import 'package:flutter_quote_generator/data/remote/network_info.dart' as _i597;
import 'package:flutter_quote_generator/data/remote/network_service.dart'
    as _i838;
import 'package:flutter_quote_generator/data/repositories/quote_repository.dart'
    as _i750;
import 'package:flutter_quote_generator/data/repositories/quote_repository_impl.dart'
    as _i627;
import 'package:flutter_quote_generator/global/configs/register_module.dart'
    as _i853;
import 'package:flutter_quote_generator/global/utils/file_operation_util.dart'
    as _i104;
import 'package:flutter_quote_generator/modules/quotes/bloc/local/quote_local_bloc.dart'
    as _i638;
import 'package:flutter_quote_generator/modules/quotes/bloc/remote/quote_remote_bloc.dart'
    as _i823;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_flutter/adapters.dart' as _i744;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i744.HiveInterface>(() => registerModule.hive);
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.lazySingleton<_i883.HiveOperation<_i1046.QuoteModel>>(
        () => registerModule.hiveOperation);
    gh.factory<_i959.PrimitiveDatabase>(
        () => registerModule.secureStorageManager);
    gh.factoryParam<_i140.HiveManger, _i104.FileOperation?, dynamic>((
      fileOperation,
      _,
    ) =>
        _i140.HiveManger(
          gh<_i744.HiveInterface>(),
          fileOperation: fileOperation,
        ));
    gh.factory<_i838.NetworkService>(
        () => _i838.NetworkService(gh<_i361.Dio>()));
    gh.lazySingleton<_i26.HiveEncryption>(() => _i26.HiveEncryption(
          gh<_i744.HiveInterface>(),
          gh<_i959.PrimitiveDatabase>(),
        ));
    gh.lazySingleton<_i597.NetworkInfo>(
        () => _i597.NetworkInfo(gh<_i895.Connectivity>()));
    gh.factory<_i750.QuoteRepository>(() => _i627.QuoteRepositoryImpl(
          gh<_i838.NetworkService>(),
          gh<_i883.HiveOperation<_i1046.QuoteModel>>(),
        ));
    gh.factoryParam<_i883.HiveOperation<dynamic>, _i26.HiveEncryption?,
        dynamic>((
      hiveEncryption,
      _,
    ) =>
        _i883.HiveOperation<dynamic>(
          gh<_i744.HiveInterface>(),
          gh<_i959.PrimitiveDatabase>(),
          hiveEncryption: hiveEncryption,
        ));
    gh.factory<_i638.QuoteLocalBloc>(
        () => _i638.QuoteLocalBloc(gh<_i750.QuoteRepository>()));
    gh.factory<_i823.QuoteRemoteBloc>(
        () => _i823.QuoteRemoteBloc(gh<_i750.QuoteRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i853.RegisterModule {}
