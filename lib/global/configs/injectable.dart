import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_quote_generator/global/configs/injectable.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
void configureDependencies() => getIt.init();
