import 'package:auto_route/auto_route.dart';

import '../../modules/quotes/pages/favorite_quotes_page.dart';
import '../../modules/quotes/pages/quote_page.dart';
import '../../modules/tab_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          initial: true,
          page: TabRoute.page,
          children: [
            AutoRoute(page: QuoteRoute.page),
            AutoRoute(page: FavoriteQuotesRoute.page),
          ],
        )
      ];
}
