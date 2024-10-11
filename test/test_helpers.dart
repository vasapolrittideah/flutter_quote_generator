import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_quote_generator/global/themes/app_theme.dart';

import 'fixtures/fixture_reader.dart';
import 'mocks/datasource_mock.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

Future pumpRouterApp(
  WidgetTester tester,
  List<BlocProvider> providers,
  RootStackRouter router, {
  NavigatorObserver? mockObserverOverride,
}) {
  final mockObserver = MockNavigatorObserver();

  return tester
      .pumpWidget(
    ScreenUtilInit(
      ensureScreenSize: true,
      minTextAdapt: true,
      designSize: const Size(1080, 1920),
      builder: (_, child) {
        return MultiBlocProvider(
          providers: providers,
          child: MaterialApp.router(
            theme: AppTheme.dark,
            routerDelegate: AutoRouterDelegate(
              router,
              navigatorObservers: () => [mockObserverOverride ?? mockObserver],
            ),
          ),
        );
      },
    ),
  )
      .then((_) async {
    for (int i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }
  });
}

void setUpNetworkServiceMockSuccess200(
  NetworkServiceMock networkServiceMock, {
  required String fixtureName,
}) {
  when(
    () => networkServiceMock.get(
      any(),
      token: any(named: 'token'),
      headers: any(named: 'headers'),
    ),
  ).thenAnswer(
    (_) async => Response(
      statusCode: 200,
      data: jsonDecode(fixture(fixtureName)),
      requestOptions: RequestOptions(),
    ),
  );
}

void setUpNetworkServiceMockFailure404(NetworkServiceMock networkServiceMock) {
  when(
    () => networkServiceMock.get(
      any(),
      token: any(named: 'token'),
      headers: any(named: 'headers'),
    ),
  ).thenThrow(
    DioException(
      type: DioExceptionType.badResponse,
      message: 'Not found',
      response: Response(
        statusCode: 404,
        requestOptions: RequestOptions(),
      ),
      requestOptions: RequestOptions(),
    ),
  );
}
