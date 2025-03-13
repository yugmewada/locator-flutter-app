import 'package:auto_route/auto_route.dart';
import 'package:demo/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../ui/auth/complete_profile_page.dart';
import '../ui/auth/create_account_page.dart';
import '../ui/auth/email_login_page.dart';
import '../ui/auth/mobile_login_page.dart';
import '../ui/auth/select_language_page.dart';
import '../ui/auth/walkthrough_page.dart';
import '../ui/auth/welcome_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashScreenRoute.page, initial: true),
    AutoRoute(page: SelectLanguageRoute.page),
    AutoRoute(page: WalkthroughRoute.page),
    AutoRoute(page: WelcomeRoute.page),
    AutoRoute(page: EmailLoginRoute.page),
    AutoRoute(page: MobileLoginRoute.page),
    AutoRoute(page: CompleteProfileRoute.page),
  ];
}

final appRouter = locator<AppRouter>();
