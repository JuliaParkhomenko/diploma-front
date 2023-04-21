import 'package:diploma_frontend/pages/admin/admin_page.dart';
import 'package:diploma_frontend/pages/auth_page/auth_page.dart';
import 'package:diploma_frontend/pages/director_page/director_page.dart';
import 'package:diploma_frontend/pages/landing_page/landing_page.dart';
import 'package:diploma_frontend/pages/manager_page/manager_page.dart';
import 'package:diploma_frontend/pages/splash_page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class RouteService {
  final RouteMap loadingMap = RouteMap(
    onUnknownRoute: (_) => const Redirect('/'),
    routes: {
      '/': (route) => const MaterialPage(
            child: SplashPage(),
          ),
    },
  );

  final RouteMap adminMap = RouteMap(
    onUnknownRoute: (_) => const Redirect('/'),
    routes: {
      '/': (route) => const MaterialPage(
            child: AdminPage(),
          ),
    },
  );

  final RouteMap managerMap = RouteMap(
    onUnknownRoute: (_) => const Redirect('/'),
    routes: {
      '/': (route) => const MaterialPage(
            child: ManagerPage(),
          ),
    },
  );

  final RouteMap directorMap = RouteMap(
    onUnknownRoute: (_) => const Redirect('/'),
    routes: {
      '/': (route) => const MaterialPage(
            child: DirectorPage(),
          ),
    },
  );

  final RouteMap authMap = RouteMap(
    onUnknownRoute: (_) => const Redirect('/'),
    routes: {
      '/': (route) => const MaterialPage(
            child: LandingPage(),
          ),
      '/sign-in': (route) => const MaterialPage(
            child: AuthPage(),
          ),
    },
  );
}
