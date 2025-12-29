import 'dart:io';
import 'package:bandmgr/core/persistence/json_store.dart';
import 'package:bandmgr/core/persistence/storage_provider.dart';
import 'package:bandmgr/features/songs/presentation/song_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

void main() {
  testWidgets('SongEditScreen shows existing song title', (tester) async {
    final dir = Directory.systemTemp.createTempSync('bandmgr-test');
    final store = JsonStore.withFile(File(p.join(dir.path, 'bandmgr.json')));
    final id = store.uuid();
    await store.upsertItem('songs', id, {
      'id': id,
      'bandId': 'default-band',
      'title': 'Test Song',
      'externalJson': '{}',
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [jsonStoreProvider.overrideWithValue(store)],
        child: MaterialApp(
          home: SongEditScreen(songId: id),
        ),
      ),
    );

    await tester.pump(); // initial frame
    expect(find.text('Test Song'), findsOneWidget);
  });
}
