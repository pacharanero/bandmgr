import 'package:bandmgr/core/persistence/app_database.dart';
import 'package:bandmgr/features/songs/presentation/song_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// NOTE: Requires generated Drift code. Run build_runner before this test.

void main() {
  testWidgets('SongEditScreen shows existing song title', (tester) async {
    final db = AppDatabase();
    final id = db.uuid();
    await db.into(db.songs).insert(
          SongsCompanion.insert(
            id: id,
            bandId: 'default-band',
            title: 'Test Song',
            // externalJson omitted; table default '{}' used.
          ),
        );

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: SizedBox(), // placeholder replaced below
        ),
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: SongEditScreen(songId: id),
        ),
      ),
    );

    await tester.pump(); // initial frame
    expect(find.text('Test Song'), findsOneWidget);
  });
}
