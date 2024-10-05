import 'package:auto_route/auto_route.dart';
import 'package:rfid_inventory_app/core/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: ConnectRoute.page,
          initial: true,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: InventoryRoute.page),
        AutoRoute(page: CreateInventoryRoute.page),
        AutoRoute(page: CreateItemRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ];
}
