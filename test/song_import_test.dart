import 'package:flutter_test/flutter_test.dart';
import 'package:bandmgr/core/persistence/app_database.dart';
import 'package:bandmgr/features/songs/infrastructure/song_repository.dart';
import 'package:bandmgr/features/songs/application/song_import_service.dart';

void main() {
  final db = AppDatabase();
  final repo = DriftSongRepository(db);
  final service = SongImportService(repo, db, () => 'default-band');

  test('plain text import parses title and artist', () async {
    final res = await service.import(
        'Song A - Artist A\nSong B', SongImportFormat.plainText);
    expect(res.added, 2);
  });

  test('markdown import ignores non-list lines', () async {
    final res = await service.import(
        '# Heading\n- Track 1 - Artist 1\n* Track 2',
        SongImportFormat.markdown);
    expect(res.added, 2);
  });

  test('csv import requires title', () async {
    final csv = 'title,artist\nAlpha,One\nBeta,Two';
    final res = await service.import(csv, SongImportFormat.csv);
    expect(res.added, 2);
  });

  test('duplicates skipped', () async {
    await service.import('Dup Song - Artist', SongImportFormat.plainText);
    final res =
        await service.import('Dup Song - Artist', SongImportFormat.plainText);
    expect(res.skippedDuplicates, 1);
  });
}
