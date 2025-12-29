import 'package:flutter/material.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/songs/presentation/song_list_screen.dart';

class AppRouter {
  static const home = '/';
  static const songs = '/songs';
  // Future: static const members = '/members'; etc.

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case songs:
        return MaterialPageRoute(builder: (_) => const SongListScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Unknown route: ${settings.name}')),
          ),
        );
    }
  }
}
