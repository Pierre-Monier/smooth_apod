import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/apod/presentation/apod_page.dart';
import '../features/auth/data/repository/auth_repository.dart';
import '../features/auth/presentation/ui/login_page.dart';
import '../features/not_found/presentation/not_found_page.dart';
import 'app_route.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: AppRoute.apod.path,
    // * this doesn't stack routes, it replaces the current route
    // * thats what we want on redirect
    routerNeglect: true,
    redirect: (state) {
      final isLoggedIn = authRepository.user != null;
      final loginRoutePath = state.namedLocation(AppRoute.login.name);

      if (isLoggedIn && state.location == loginRoutePath) {
        return state.namedLocation(AppRoute.apod.name);
      } else if (!isLoggedIn && state.location != loginRoutePath) {
        return loginRoutePath;
      }

      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.watchUser),
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
});
