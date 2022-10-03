import 'package:calendar/common/app_theme.dart';
import 'package:calendar/presentation/bloc/day_screen_bloc/day_screen_bloc.dart';
import 'package:calendar/presentation/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:calendar/presentation/screens/main_screen/main_screen.dart';
import 'package:calendar/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainScreenBloc>(create: (context) => MainScreenBloc()),
        BlocProvider<DayScreenBloc>(create: (context) => DayScreenBloc()),
      ],
      child: MaterialApp(
        theme: AppThemes.light(),
        debugShowCheckedModeBanner: false,
        initialRoute: MainScreen.routeName,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
