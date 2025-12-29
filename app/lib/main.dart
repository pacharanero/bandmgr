import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/songs/presentation/song_list_screen.dart';
import 'features/songs/presentation/song_detail_screen.dart';
import 'features/songs/presentation/song_edit_screen.dart';

// NOTE: Flutter project lives in /app under a mono-repo root.
// If VS Code cannot launch, either:
// 1. Open the /app folder directly, or
// 2. Keep root open and rely on .vscode/settings.json (dart.projectSearchDepth) we added.

void main() {
  debugPrint(
      '=== BandMgr main.dart loaded @ ${DateTime.now().toIso8601String()} ===');
  runApp(const ProviderScope(child: BandMgrApp()));
}

class BandMgrApp extends ConsumerWidget {
  const BandMgrApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('BandMgrApp build() -> HomeScreen');
    return MaterialApp(
      title: 'BandMgr',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      // home: const HomeScreen(),
      routes: {
        '/': (_) => const HomeScreen(),
        '/songs': (_) => const SongListScreen(),
      },
      onGenerateRoute: (settings) {
        final name = settings.name ?? '';
        if (name.startsWith('/songs/')) {
          // Supports /songs/<id> (detail) and /songs/<id>/edit (edit)
          final remainder = name.substring('/songs/'.length);
          if (remainder.endsWith('/edit')) {
            final id =
                remainder.substring(0, remainder.length - '/edit'.length);
            return MaterialPageRoute(
              builder: (_) => SongEditScreen(songId: id),
              settings: settings,
            );
          }
          final id = remainder;
          return MaterialPageRoute(
            builder: (_) => SongDetailScreen(songId: id),
            settings: settings,
          );
        }
        return null; // fall back to routes/home
      },
    );
  }
}
