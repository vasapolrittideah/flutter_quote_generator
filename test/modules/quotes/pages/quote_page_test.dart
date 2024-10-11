import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_quote_generator/data/models/quote_model.dart';
import 'package:flutter_quote_generator/global/router/app_router.dart';
import 'package:flutter_quote_generator/global/themes/app_theme.dart';
import 'package:flutter_quote_generator/global/widgets/icon_button.dart';
import 'package:flutter_quote_generator/modules/quotes/bloc/local/quote_local_bloc.dart';
import 'package:flutter_quote_generator/modules/quotes/bloc/remote/quote_remote_bloc.dart';
import 'package:flutter_quote_generator/modules/quotes/pages/quote_page.dart';
import 'package:flutter_quote_generator/modules/quotes/widgets/quote_card.dart';
import '../../../factories/quote_model_factory.dart';
import '../../../mocks/bloc_mock.dart';
import '../../../test_helpers.dart';
import '../../../test_injectable.dart';

void main() {
  late AppRouter router;
  late QuoteRemoteBlocMock quoteRemoteBlocMock;
  late QuoteLocalBlocMock quoteLocalBlocMock;
  late QuoteModel fakeQuoteModel;
  late List<QuoteModel> fakeQuoteModels;

  setUpAll(() {
    configureTestDependencies();

    final quoteModelFactory = QuoteModelFactory();
    fakeQuoteModel = quoteModelFactory.generateFake();
    fakeQuoteModels = quoteModelFactory.generateFakeList(length: 3);
  });

  setUp(() {
    router = AppRouter();
    quoteRemoteBlocMock = getIt<QuoteRemoteBloc>() as QuoteRemoteBlocMock;
    quoteLocalBlocMock = getIt<QuoteLocalBloc>() as QuoteLocalBlocMock;
  });

  testWidgets(
      'should show QuoteRemoteStateLoadingSpinner when fetching new quote',
      (tester) async {
    when(() => quoteRemoteBlocMock.state).thenReturn(
      const QuoteRemoteState.loading(),
    );

    router.push(const TabRoute());
    await pumpRouterApp(
      tester,
      [
        BlocProvider(create: (_) => getIt<QuoteRemoteBloc>()),
      ],
      router,
    );

    expect(
      find.byKey(const Key('QuoteRemoteStateLoadingSpinner')),
      findsOneWidget,
    );
  });

  testWidgets(
      'should display QuoteCard correctly when new quote is fetched successfully',
      (tester) async {
    when(() => quoteRemoteBlocMock.state).thenReturn(
      QuoteRemoteState.success(fakeQuoteModel),
    );
    when(() => quoteLocalBlocMock.state).thenReturn(
      const QuoteLocalState.loading(),
    );

    router.push(const QuoteRoute());
    await pumpRouterApp(
      tester,
      [
        BlocProvider(create: (_) => getIt<QuoteRemoteBloc>()),
        BlocProvider(create: (_) => getIt<QuoteLocalBloc>()),
      ],
      router,
    );

    expect(find.byType(QuoteCard), findsOneWidget);
    expect(find.text('"${fakeQuoteModel.quote}"'), findsOneWidget);
    expect(find.text('- ${fakeQuoteModel.author} -'), findsOneWidget);
  });

  testWidgets(
      'should show QuoteLocalStateLoadingSpinner when loading cached quotes',
      (tester) async {
    when(() => quoteRemoteBlocMock.state).thenReturn(
      QuoteRemoteState.success(fakeQuoteModel),
    );
    when(() => quoteLocalBlocMock.state).thenReturn(
      const QuoteLocalState.loading(),
    );

    router.push(const QuoteRoute());
    await pumpRouterApp(
      tester,
      [
        BlocProvider(create: (_) => getIt<QuoteRemoteBloc>()),
        BlocProvider(create: (_) => getIt<QuoteLocalBloc>()),
      ],
      router,
    );

    expect(
      find.byKey(const Key('QuoteLocalStateLoadingSpinner')),
      findsOneWidget,
    );
  });

  testWidgets(
      'should display FavoriteQuoteIconButton correctly when saved quotes are loaded',
      (tester) async {
    when(() => quoteRemoteBlocMock.state).thenReturn(
      QuoteRemoteState.success(fakeQuoteModel),
    );
    when(() => quoteLocalBlocMock.state).thenReturn(
      QuoteLocalState.loaded(fakeQuoteModels),
    );

    router.push(const QuoteRoute());
    await pumpRouterApp(
      tester,
      [
        BlocProvider(create: (_) => getIt<QuoteRemoteBloc>()),
        BlocProvider(create: (_) => getIt<QuoteLocalBloc>()),
      ],
      router,
    );

    expect(
      find.byKey(const Key('QuoteLocalStateLoadingSpinner')),
      findsNothing,
    );
    expect(
      tester.widget(find.byKey(const Key('FavoriteQuoteIconButton'))),
      isA<CustomIconButton>().having(
        (t) => t.icon,
        'icon',
        FontAwesomeIcons.heart,
      ),
    );
  });

  testWidgets(
      'should change FavoriteQuoteIconButton color to green when tapped',
      (tester) async {
    when(() => quoteRemoteBlocMock.state).thenReturn(
      QuoteRemoteState.success(fakeQuoteModel),
    );
    when(() => quoteLocalBlocMock.state).thenReturn(
      QuoteLocalState.loaded(fakeQuoteModels),
    );

    router.push(const QuoteRoute());
    await pumpRouterApp(
      tester,
      [
        BlocProvider(create: (_) => getIt<QuoteRemoteBloc>()),
        BlocProvider(create: (_) => getIt<QuoteLocalBloc>()),
      ],
      router,
    );

    final favoriteQuoteIconButton =
        find.byKey(const Key('FavoriteQuoteIconButton'));
    final BuildContext context = tester.element(find.byType(QuotePage));

    await tester.tap(favoriteQuoteIconButton);
    await tester.pump();

    expect(
      tester.widget(favoriteQuoteIconButton),
      isA<CustomIconButton>().having(
        (t) => t.color,
        'icon',
        context.theme.color.success,
      ),
    );
  });

  testWidgets(
      'should save favorite quote when FavoriteQuoteIconButton is tapped',
      (tester) async {
    when(() => quoteRemoteBlocMock.state).thenReturn(
      QuoteRemoteState.success(fakeQuoteModel),
    );
    when(() => quoteLocalBlocMock.state).thenReturn(
      QuoteLocalState.loaded(fakeQuoteModels),
    );

    router.push(const QuoteRoute());
    await pumpRouterApp(
      tester,
      [
        BlocProvider(create: (_) => getIt<QuoteRemoteBloc>()),
        BlocProvider(create: (_) => getIt<QuoteLocalBloc>()),
      ],
      router,
    );

    final favoriteQuoteIconButton =
        find.byKey(const Key('FavoriteQuoteIconButton'));

    await tester.tap(favoriteQuoteIconButton);
    await tester.pump();

    verify(
      () => quoteLocalBlocMock
          .add(QuoteLocalEvent.favoriteQuoteSaved(fakeQuoteModel)),
    );
  });

  testWidgets('should fetch new quote when QuoteCard is swiped',
      (tester) async {
    when(() => quoteRemoteBlocMock.state).thenReturn(
      QuoteRemoteState.success(fakeQuoteModel),
    );
    when(() => quoteLocalBlocMock.state).thenReturn(
      QuoteLocalState.loaded(fakeQuoteModels),
    );

    router.push(const QuoteRoute());
    await pumpRouterApp(
      tester,
      [
        BlocProvider(create: (_) => getIt<QuoteRemoteBloc>()),
        BlocProvider(create: (_) => getIt<QuoteLocalBloc>()),
      ],
      router,
    );

    final quoteCard = find.byType(QuoteCard);

    await tester.drag(quoteCard, const Offset(500, 500));
    await tester.pump();

    verify(
      () => quoteRemoteBlocMock.add(const QuoteRemoteEvent.newQuoteRequested()),
    );
  });
}
