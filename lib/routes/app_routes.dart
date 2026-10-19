import 'package:flutter/material.dart';
import '../models/tour_package.dart';
import '../screens/detail_screen.dart';
import '../screens/home_screen.dart';
import '../screens/not_found_screen.dart';
import '../screens/splash_screen.dart';

class AppRoutes {
  static const splash = '/splash';
  static const home = '/home';
  static const detail = '/detail';

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const SplashScreen(),
        home: (_) => const HomeScreen(),
      };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == detail) {
      final argument = settings.arguments;
      if (argument is TourPackage) {
        return MaterialPageRoute<void>(
          builder: (_) => DetailScreen(package: argument),
          settings: settings,
        );
      }
      return MaterialPageRoute<void>(
        builder: (_) => const NotFoundScreen(
          message: 'Data paket wisata tidak valid.',
        ),
        settings: settings,
      );
    }
    return null;
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      builder: (_) => NotFoundScreen(
        message: 'Rute "${settings.name ?? 'tidak diketahui'}" tidak ditemukan.',
      ),
      settings: settings,
    );
  }
}
