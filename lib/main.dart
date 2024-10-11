import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_quote_generator/data/local/hive/hive_manager.dart';
import 'package:flutter_quote_generator/global/configs/injectable.dart';
import 'package:flutter_quote_generator/global/router/app_router.dart';
import 'package:flutter_quote_generator/global/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  getIt<HiveManger>().init();
  runApp(MyApp(key: UniqueKey()));
}

class MyApp extends HookWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      minTextAdapt: true,
      designSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      builder: (_, child) {
        return MaterialApp.router(
          theme: AppTheme.dark,
          debugShowCheckedModeBanner: false,
          routerConfig: _appRouter.config(),
        );
      },
    );
  }
}
