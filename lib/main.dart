import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/apllication/dowloads/downloads_bloc.dart';
import 'package:netflix/apllication/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix/core/color/colors.dart';
import 'package:netflix/domain/core/di/injectable.dart';
import 'package:netflix/presentation/main/main_page.dart';

import 'apllication/search/search_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // this will connect to the native channels
  await configureInjeactable();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          //dependency injection, means passing object indirectly, instead of passing object directly in the constructor
          BlocProvider(create: (ctx) => getIt<DownloadsBloc>()),
          BlocProvider(create: (ctx) => getIt<SearchBloc>()),
          BlocProvider(create: (ctx) => getIt<FastLaughBloc>()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            backgroundColor: Colors.black,
            scaffoldBackgroundColor: primaryColor,
            textTheme: const TextTheme(
              bodyText1: TextStyle(
                color: Colors.white,
              ),
              bodyText2: TextStyle(
                color: Colors.white,
                // fontSize: 24,
              ),
              headline2: TextStyle(
                color: Colors.white,
                // fontSize: 20,
              ),
            ),
          ),
          home: MainPage(),
        ));
  }
}
