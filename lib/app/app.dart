import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/app/app_routes.dart';
import 'package:bhutpurva_penal/core/observers/route_observer.dart';
import 'package:bhutpurva_penal/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_config.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConfig.appName,
      theme: AppTheme.adminLightTheme,
      initialRoute: AppPages.dashboard,
      getPages: AppRoutes.pages,
      defaultTransition: Transition.fadeIn,
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => const Scaffold(body: Center(child: Text('404 Not Found'))),
      ),
      navigatorObservers: [RoutesObserver()],
    );
  }
}
