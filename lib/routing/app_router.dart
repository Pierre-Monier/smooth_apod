import 'package:go_router/go_router.dart';

import '../features/apod/presentation/apod_page.dart';
import '../features/auth/presentation/login_page.dart';
import '../features/not_found/presentation/not_found_page.dart';
import 'app_route.dart';

final appRouter = GoRouter(
  initialLocation: AppRoute.apod.path,
  routes: [
    GoRoute(
      path: AppRoute.apod.path,
      name: AppRoute.apod.name,
      builder: (context, state) => const ApodPage(),
    ),
    GoRoute(
      path: AppRoute.login.path,
      name: AppRoute.login.name,
      builder: (context, state) => const LoginPage(),
    )
  ],
  errorBuilder: (context, state) => const NotFoundPage(),
);
