import 'package:calendar/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final Object? arguments = settings.arguments;

    WidgetBuilder builder;

    switch (settings.name) {
      case MainScreen.routeName:
        builder = (_) => const MainScreen();
        break;

      default:
        builder = (_) => const MainScreen();
    }

    return MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
  }
}
