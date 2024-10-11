import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_quote_generator/global/constants/app_constants.dart';
import '../../../global/utils/file_operation_util.dart';
import '../../models/quote_model.dart';

@injectable
final class HiveManger {
  HiveManger(this._hive, {@factoryParam FileOperation? fileOperation})
      : _fileOperation = fileOperation ?? FileOperation();

  final HiveInterface _hive;
  late final FileOperation _fileOperation;
  String get _subDirectory => AppConstants.appName;

  Future<void> init() async {
    await _open();
    registerAdapters();
  }

  Future<void> clear() async {
    await _hive.deleteFromDisk();
    await _fileOperation.removeSubDirectory(_subDirectory);
  }

  Future<void> _open() async {
    final subPath = await _fileOperation.createSubDirectory(_subDirectory);
    await _hive.initFlutter(subPath);
  }

  void registerAdapters() {
    _hive.registerAdapter(QuoteModelAdapter());
  }
}
