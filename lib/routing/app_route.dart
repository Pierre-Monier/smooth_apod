enum AppRoute {
  login,
  apod,
  history,
  favorites,
}

extension AppRoutePath on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.login:
        return '/login';
      case AppRoute.apod:
        return '/';
      case AppRoute.history:
        return '/history';
      case AppRoute.favorites:
        return '/favorites';
    }
  }
}
