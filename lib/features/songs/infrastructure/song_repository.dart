import 'dart:convert';
import 'package:drift/drift.dart' show Value;
import '../../../core/persistence/app_database.dart';
import '../domain/song.dart' as domain;

abstract class SongRepository {
  Stream<List<domain.Song>> watchAll(String bandId);
  Stream<domain.Song?> watchOne(String id); // added
  Future<void> upsert(domain.Song song);
  Future<void> upsertAll(List<domain.Song> songs);
  Future<bool> existsByTitleArtist(String bandId, String title, String? artist);
}

class DriftSongRepository implements SongRepository {
  final AppDatabase db;
  DriftSongRepository(this.db);

  domain.Song _map(SongRow row) {
    Map<String, dynamic> external = {};
    try {
      external = jsonDecode(row.externalJson) as Map<String, dynamic>;
    } catch (_) {}
    Duration? length;
    final len = external['lengthSeconds'];
    if (len is int) length = Duration(seconds: len);
    return domain.Song(
      id: row.id,
      bandId: row.bandId,
      title: row.title,
      artist: row.artist,
      album: row.album,
      key: row.key,
      tempo: row.tempo,
      length: length,
      external: external,
      streamingUrl: external['streamingUrl'] as String?, // added
    );
  }

  Map<String, dynamic> _encodeExternal(domain.Song song) {
    final map = Map<String, dynamic>.from(song.external);
    if (song.length != null) {
      map['lengthSeconds'] = song.length!.inSeconds;
    }
    if (song.streamingUrl != null && song.streamingUrl!.isNotEmpty) {
      map['streamingUrl'] = song.streamingUrl;
    } else {
      map.remove('streamingUrl');
    }
    return map;
  }

  @override
  Stream<List<domain.Song>> watchAll(String bandId) =>
      db.watchSongsByBand(bandId).map((rows) => rows.map(_map).toList());

  @override
  Stream<domain.Song?> watchOne(String id) =>
      (db.select(db.songs)..where((s) => s.id.equals(id)))
          .watchSingleOrNull()
          .map(
            (row) => row == null ? null : _map(row),
          );

  @override
  Future<void> upsert(domain.Song song) async {
    await db.into(db.songs).insertOnConflictUpdate(
          SongsCompanion(
            id: Value(song.id),
            bandId: Value(song.bandId),
            title: Value(song.title),
            artist: Value(song.artist),
            album: Value(song.album),
            key: Value(song.key),
            tempo: Value(song.tempo),
            externalJson: Value(jsonEncode(_encodeExternal(song))),
          ),
        );
  }

  @override
  Future<void> upsertAll(List<domain.Song> songs) async {
    if (songs.isEmpty) return;
    await db.batch((b) {
      b.insertAllOnConflictUpdate(
        db.songs,
        songs
            .map(
              (s) => SongsCompanion(
                id: Value(s.id),
                bandId: Value(s.bandId),
                title: Value(s.title),
                artist: Value(s.artist),
                album: Value(s.album),
                key: Value(s.key),
                tempo: Value(s.tempo),
                externalJson: Value(jsonEncode(_encodeExternal(s))),
              ),
            )
            .toList(),
      );
    });
  }

  @override
  Future<bool> existsByTitleArtist(
      String bandId, String title, String? artist) async {
    final q = db.select(db.songs)
      ..where((s) => s.bandId.equals(bandId))
      ..where((s) => s.title.equals(title));
    if (artist == null) {
      q.where((s) => s.artist.isNull());
    } else {
      q.where((s) => s.artist.equals(artist));
    }
    return (await q.getSingleOrNull()) != null;
  }
}
