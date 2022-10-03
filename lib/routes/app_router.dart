import 'package:calendar/presentation/screens/day_screen/day_screen.dart';
import 'package:calendar/presentation/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? arguments = settings.arguments;

    WidgetBuilder builder;

    switch (settings.name) {
      case MainScreen.routeName:
        builder = (_) => const MainScreen();
        break;

      case DayScreen.routeName:
        builder = (_) => DayScreen(
              date: arguments as String,
            );
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
