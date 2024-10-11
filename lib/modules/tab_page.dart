import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_quote_generator/global/themes/app_theme.dart';
import 'package:flutter_quote_generator/modules/quotes/bloc/local/quote_local_bloc.dart';
import 'package:flutter_quote_generator/modules/quotes/bloc/remote/quote_remote_bloc.dart';
import '../global/configs/injectable.dart';
import '../global/router/app_router.dart';

@RoutePage()
class TabPage extends StatelessWidget {
  const TabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QuoteRemoteBloc>(
          create: (_) =>
              getIt()..add(const QuoteRemoteEvent.newQuoteRequested()),
        ),
        BlocProvider<QuoteLocalBloc>(
          create: (_) =>
              getIt()..add(const QuoteLocalEvent.favoriteQuoteRequested()),
        ),
      ],
      child: AutoTabsScaffold(
        routes: const [
          QuoteRoute(),
          FavoriteQuotesRoute(),
        ],
        bottomNavigationBuilder: (context, tabsRouter) {
          return BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            backgroundColor: context.theme.color.background,
            selectedItemColor: context.theme.color.primary,
            items: const [
              BottomNavigationBarItem(
                activeIcon: FaIcon(FontAwesomeIcons.solidCircle),
                icon: FaIcon(FontAwesomeIcons.circle),
                label: 'Quotes',
              ),
              BottomNavigationBarItem(
                activeIcon: FaIcon(FontAwesomeIcons.solidHeart),
                icon: FaIcon(FontAwesomeIcons.heart),
                label: 'Favorites',
              ),
            ],
          );
        },
      ),
    );
  }
}
