import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_quote_generator/data/local/hive/hive_operation.dart';
import 'package:flutter_quote_generator/data/models/quote_model.dart';
import 'package:flutter_quote_generator/data/remote/app_dio.dart';
import '../../data/local/primitive/primitive_database.dart';
import '../../data/local/secure/secure_storage_manager.dart';

@module
abstract class RegisterModule {
  @singleton
  HiveInterface get hive => Hive;

  @lazySingleton
  Dio get dio => AppDio.getInstance();

  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @Injectable(as: PrimitiveDatabase)
  SecureStorageManager get secureStorageManager =>
      SecureStorageManager(const FlutterSecureStorage());

  @lazySingleton
  HiveOperation<QuoteModel> get hiveOperation =>
      HiveOperation<QuoteModel>(hive, secureStorageManager);
}
