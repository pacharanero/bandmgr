import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../songs/infrastructure/song_repository.dart';
import '../../songs/application/song_import_service.dart'; // for songRepositoryProvider
import '../../songs/domain/song.dart' as domain;

final _editSongProvider =
    StreamProvider.family<domain.Song?, String>((ref, id) {
  return ref.watch(songRepositoryProvider).watchOne(id);
});

class SongEditScreen extends ConsumerStatefulWidget {
  final String songId;
  const SongEditScreen({super.key, required this.songId});

  @override
  ConsumerState<SongEditScreen> createState() => _SongEditScreenState();
}

class _SongEditScreenState extends ConsumerState<SongEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _title;
  late TextEditingController _artist;
  late TextEditingController _album;
  late TextEditingController _keyCtrl;
  late TextEditingController _tempo;
  late TextEditingController _streamingUrl; // added
  bool _initialized = false;
  domain.Song? _original;

  void _initControllers(domain.Song s) {
    _original = s;
    _title = TextEditingController(text: s.title);
    _artist = TextEditingController(text: s.artist ?? '');
    _album = TextEditingController(text: s.album ?? '');
    _keyCtrl = TextEditingController(text: s.key ?? '');
    _tempo = TextEditingController(text: s.tempo?.toString() ?? '');
    _streamingUrl = TextEditingController(text: s.streamingUrl ?? ''); // added
    _initialized = true;
  }

  @override
  void dispose() {
    if (_initialized) {
      _title.dispose();
      _artist.dispose();
      _album.dispose();
      _keyCtrl.dispose();
      _tempo.dispose();
      _streamingUrl.dispose(); // added
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate() || _original == null) return;
    final repo = ref.read(songRepositoryProvider);
    final updated = _original!.copyWith(
      title: _title.text.trim(),
      artist: _artist.text.trim().isEmpty ? null : _artist.text.trim(),
      album: _album.text.trim().isEmpty ? null : _album.text.trim(),
      key: _keyCtrl.text.trim().isEmpty ? null : _keyCtrl.text.trim(),
      tempo:
          _tempo.text.trim().isEmpty ? null : int.tryParse(_tempo.text.trim()),
      streamingUrl: _streamingUrl.text.trim().isEmpty
          ? null
          : _streamingUrl.text.trim(), // added
    );
    await repo.upsert(updated);
    if (mounted) {
      Navigator.of(context).pop(); // Return to detail
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Song saved')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final songAsync = ref.watch(_editSongProvider(widget.songId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Song'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _save,
            tooltip: 'Save',
          ),
        ],
      ),
      body: songAsync.when(
        data: (song) {
          if (song == null) {
            return const Center(child: Text('Song not found'));
          }
          if (!_initialized) _initControllers(song);
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: _title,
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Title required' : null,
                ),
                TextFormField(
                  controller: _artist,
                  decoration: const InputDecoration(labelText: 'Artist'),
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  controller: _album,
                  decoration: const InputDecoration(labelText: 'Album'),
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  controller: _keyCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Key (e.g. C, Gm)'),
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  controller: _tempo,
                  decoration: const InputDecoration(labelText: 'Tempo (BPM)'),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  validator: (v) {
                    if (v == null || v.isEmpty) return null;
                    final parsed = int.tryParse(v);
                    if (parsed == null || parsed <= 0) return 'Invalid BPM';
                    return null;
                  },
                ),
                TextFormField(
                  controller: _streamingUrl,
                  decoration: const InputDecoration(labelText: 'Streaming URL'),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
