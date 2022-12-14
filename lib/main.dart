import 'package:flutter/material.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/widgets/auth/auth_widget.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.mainDarkBlue,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          backgroundColor: AppColors.mainDarkBlue,
          elevation: 0
        ),
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/' : ( content) => const AuthWidget(),
        '/main_screen' : (context) => const MainScreenWidget(),
        'main_screen/movie_details' : (context) {
          final arguments = ModalRoute.of(context)!.settings.arguments;
          if (arguments is int) {
            return MovieDetailsWidget(movieId: arguments);
          } else {
            return const MovieDetailsWidget(movieId: 0);
          }
        }
      },
      initialRoute: '/',
    );
  }
}

