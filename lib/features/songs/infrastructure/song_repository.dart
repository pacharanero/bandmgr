import 'dart:convert';
import '../../../core/persistence/json_store.dart';
import '../domain/song.dart' as domain;

abstract class SongRepository {
  Stream<List<domain.Song>> watchAll(String bandId);
  Stream<domain.Song?> watchOne(String id); // added
  Future<void> upsert(domain.Song song);
  Future<void> upsertAll(List<domain.Song> songs);
  Future<bool> existsByTitleArtist(String bandId, String title, String? artist);
}

class JsonSongRepository implements SongRepository {
  final JsonStore store;
  JsonSongRepository(this.store);

  domain.Song _map(Map<String, dynamic> row) {
    Map<String, dynamic> external = {};
    try {
      final raw = row['externalJson'];
      if (raw is String) {
        external = jsonDecode(raw) as Map<String, dynamic>;
      } else if (row['external'] is Map) {
        external = Map<String, dynamic>.from(row['external'] as Map);
      }
    } catch (_) {}
    Duration? length;
    final len = external['lengthSeconds'];
    if (len is int) length = Duration(seconds: len);
    return domain.Song(
      id: row['id'] as String,
      bandId: row['bandId'] as String,
      title: row['title'] as String,
      artist: row['artist'] as String?,
      album: row['album'] as String?,
      key: row['key'] as String?,
      tempo: row['tempo'] as int?,
      length: length,
      external: external,
      streamingUrl: external['streamingUrl'] as String?,
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
  Stream<List<domain.Song>> watchAll(String bandId) => store
      .watchCollection('songs')
      .map((rows) => rows.where((r) => r['bandId'] == bandId).map(_map).toList());

  @override
  Stream<domain.Song?> watchOne(String id) => store.watchCollection('songs').map(
        (rows) {
          final match = rows.where((r) => r['id'] == id).map(_map).toList();
          return match.isEmpty ? null : match.first;
        },
      );

  @override
  Future<void> upsert(domain.Song song) async {
    await store.upsertItem('songs', song.id, {
      'id': song.id,
      'bandId': song.bandId,
      'title': song.title,
      'artist': song.artist,
      'album': song.album,
      'key': song.key,
      'tempo': song.tempo,
      'externalJson': jsonEncode(_encodeExternal(song)),
    });
  }

  @override
  Future<void> upsertAll(List<domain.Song> songs) async {
    if (songs.isEmpty) return;
    await store.upsertAll(
      'songs',
      songs
          .map((s) => {
                'id': s.id,
                'bandId': s.bandId,
                'title': s.title,
                'artist': s.artist,
                'album': s.album,
                'key': s.key,
                'tempo': s.tempo,
                'externalJson': jsonEncode(_encodeExternal(s)),
              })
          .toList(),
    );
  }

  @override
  Future<bool> existsByTitleArtist(
      String bandId, String title, String? artist) async {
    final rows = await store.readCollection('songs');
    return rows.any((r) =>
        r['bandId'] == bandId &&
        r['title'] == title &&
        ((artist == null && r['artist'] == null) || r['artist'] == artist));
  }
}
