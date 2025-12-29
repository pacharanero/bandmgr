import 'package:csv/csv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/persistence/json_store.dart';
import '../../../core/persistence/storage_provider.dart';
import '../../../core/band/current_band_provider.dart';
import '../domain/song.dart' as domain;
import '../infrastructure/song_repository.dart';

enum SongImportFormat { plainText, markdown, csv }

class SongImportResult {
  final int added;
  final int skippedDuplicates;
  final List<String> errors;
  const SongImportResult({
    required this.added,
    required this.skippedDuplicates,
    required this.errors,
  });
}

final songRepositoryProvider = Provider<SongRepository>((ref) {
  final store = ref.watch(jsonStoreProvider);
  return JsonSongRepository(store);
});

final songImportServiceProvider = Provider<SongImportService>((ref) {
  return SongImportService(
    ref.watch(songRepositoryProvider),
    ref.watch(jsonStoreProvider),
    () => ref.read(currentBandIdProvider),
  );
});

class SongImportService {
  final SongRepository repo;
  final JsonStore store;
  final String Function() _bandId;
  SongImportService(this.repo, this.store, this._bandId);

  Future<SongImportResult> import(
    String raw,
    SongImportFormat format,
  ) async {
    final bandId = _bandId();
    final errors = <String>[];
    final toInsert = <domain.Song>[];
    int duplicates = 0;

    Future<void> addCandidate(String title, {String? artist}) async {
      final t = title.trim();
      final a = artist?.trim();
      if (t.isEmpty) return;
      if (await repo.existsByTitleArtist(bandId, t, a)) {
        duplicates++;
        return;
      }
      toInsert.add(domain.Song(
        id: store.uuid(),
        bandId: bandId,
        title: t,
        artist: a?.isEmpty == true ? null : a,
      ));
    }

    try {
      switch (format) {
        case SongImportFormat.plainText:
          for (final line in raw.split('\n')) {
            final l = line.trim();
            if (l.isEmpty) continue;
            final parts = l.split(' - ');
            if (parts.length >= 2) {
              await addCandidate(parts[0],
                  artist: parts.sublist(1).join(' - '));
            } else {
              await addCandidate(l);
            }
          }
          break;
        case SongImportFormat.markdown:
          for (final line in raw.split('\n')) {
            final trimmed = line.trimLeft();
            if (trimmed.startsWith('- ') ||
                trimmed.startsWith('* ') ||
                trimmed.startsWith('1. ')) {
              final content =
                  trimmed.replaceFirst(RegExp(r'^(-|\*|[0-9]+\.)\s+'), '');
              final parts = content.split(' - ');
              if (parts.length >= 2) {
                await addCandidate(parts[0],
                    artist: parts.sublist(1).join(' - '));
              } else {
                await addCandidate(content);
              }
            }
          }
          break;
        case SongImportFormat.csv:
          final rows = const CsvToListConverter()
              .convert(raw, shouldParseNumbers: false);
          // Expect header row containing at least 'title'
          if (rows.isEmpty) break;
          final header =
              rows.first.map((e) => e.toString().toLowerCase()).toList();
          final titleIdx = header.indexOf('title');
          if (titleIdx == -1) {
            errors.add('CSV missing title column');
            break;
          }
          final artistIdx = header.indexOf('artist');
          for (final row in rows.skip(1)) {
            if (row.length <= titleIdx) continue;
            final title = row[titleIdx].toString();
            final artist = artistIdx >= 0 && row.length > artistIdx
                ? row[artistIdx].toString()
                : null;
            await addCandidate(title, artist: artist);
          }
          break;
      }
    } catch (e) {
      errors.add(e.toString());
    }

    if (toInsert.isNotEmpty) {
      await repo.upsertAll(toInsert);
    }
    return SongImportResult(
      added: toInsert.length,
      skippedDuplicates: duplicates,
      errors: errors,
    );
  }
}
