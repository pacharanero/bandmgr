import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/song.dart';
import '../infrastructure/song_repository.dart';
import '../../../core/band/current_band_provider.dart';
import 'song_import_service.dart'; // added for songRepositoryProvider

enum SongSortField { artist, title, album, tempo }

enum SortOrder { asc, desc }

class SongSortState {
  final SongSortField field;
  final SortOrder order;
  const SongSortState(this.field, this.order);

  SongSortState toggleOrder() => SortOrder.asc == order
      ? SongSortState(field, SortOrder.desc)
      : SongSortState(field, SortOrder.asc);

  Map<String, String> toMap() => {'field': field.name, 'order': order.name};
  static SongSortState fromPrefs(String? f, String? o) {
    final field = SongSortField.values.firstWhere(
      (e) => e.name == f,
      orElse: () => SongSortField.artist,
    );
    final order = SortOrder.values.firstWhere(
      (e) => e.name == o,
      orElse: () => SortOrder.asc,
    );
    return SongSortState(field, order);
  }
}

class SongSortNotifier extends StateNotifier<SongSortState> {
  SongSortNotifier()
      : super(const SongSortState(SongSortField.artist, SortOrder.asc)) {
    _load();
  }
  static const _kField = 'song_sort_field';
  static const _kOrder = 'song_sort_order';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = SongSortState.fromPrefs(
        prefs.getString(_kField), prefs.getString(_kOrder));
  }

  Future<void> setField(SongSortField f) async {
    state = SongSortState(f, SortOrder.asc);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kField, f.name);
    await prefs.setString(_kOrder, SortOrder.asc.name);
  }

  Future<void> toggleOrder() async {
    state = state.toggleOrder();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kField, state.field.name);
    await prefs.setString(_kOrder, state.order.name);
  }
}

final songSortProvider = StateNotifierProvider<SongSortNotifier, SongSortState>(
  (ref) => SongSortNotifier(),
);

// Raw songs stream (re-export for convenience)
final songsRawProvider =
    StreamProvider.family<List<Song>, String>((ref, bandId) {
  return ref.watch(songRepositoryProvider).watchAll(bandId);
});

// Sorted songs
final songsSortedProvider = Provider.family<List<Song>, String>((ref, bandId) {
  final raw = ref
      .watch(songsRawProvider(bandId))
      .maybeWhen(data: (d) => d, orElse: () => const <Song>[]);
  final sort = ref.watch(songSortProvider);
  int Function(Song a, Song b) cmp;
  int str(String? s1, String? s2) =>
      (s1 ?? '').toLowerCase().compareTo((s2 ?? '').toLowerCase());
  switch (sort.field) {
    case SongSortField.artist:
      cmp = (a, b) {
        final c = str(a.artist, b.artist);
        return c != 0 ? c : str(a.title, b.title);
      };
      break;
    case SongSortField.title:
      cmp = (a, b) {
        final c = str(a.title, b.title);
        return c != 0 ? c : str(a.artist, b.artist);
      };
      break;
    case SongSortField.album:
      cmp = (a, b) {
        final c = str(a.album, b.album);
        return c != 0 ? c : str(a.title, b.title);
      };
      break;
    case SongSortField.tempo:
      cmp = (a, b) {
        final tA = (a.tempo ?? 0).compareTo(b.tempo ?? 0);
        return tA != 0 ? tA : str(a.title, b.title);
      };
      break;
  }
  final list = [...raw]..sort(cmp);
  if (sort.order == SortOrder.desc) {
    return list.reversed.toList();
  }
  return list;
});
