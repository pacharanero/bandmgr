import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../songs/infrastructure/song_repository.dart';
import '../../songs/domain/song.dart';
import '../application/song_sort_provider.dart'; // ensures providers loaded (optional)
import '../application/song_import_service.dart'; // added for songRepositoryProvider

final _songProvider = StreamProvider.family<Song?, String>((ref, id) {
  return ref.watch(songRepositoryProvider).watchOne(id);
});

class SongDetailScreen extends ConsumerWidget {
  final String songId;
  const SongDetailScreen({super.key, required this.songId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songAsync = ref.watch(_songProvider(songId));
    return Scaffold(
      appBar: AppBar(title: const Text('Song Detail')),
      body: songAsync.when(
        data: (s) {
          if (s == null) return const Center(child: Text('Song not found'));
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(s.title, style: Theme.of(context).textTheme.headlineMedium),
              if (s.artist != null) Text('Artist: ${s.artist}'),
              if (s.album != null) Text('Album: ${s.album}'),
              if (s.key != null) Text('Key: ${s.key}'),
              if (s.tempo != null) Text('Tempo: ${s.tempo} BPM'),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/songs/${s.id}/edit');
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
