import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/band/current_band_provider.dart';
import '../application/song_import_service.dart';
import '../application/song_sort_provider.dart';
import '../infrastructure/song_repository.dart';
import '../domain/song.dart';
import 'song_detail_screen.dart';

final songsStreamProvider =
    StreamProvider.family<List<Song>, String>((ref, bandId) {
  // (legacy) keep for compatibility; now superseded by songsSortedProvider
  return ref.watch(songRepositoryProvider).watchAll(bandId);
});

class SongListScreen extends ConsumerWidget {
  const SongListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bandId = ref.watch(currentBandIdProvider);
    final sortState = ref.watch(songSortProvider);
    final sortedSongs = ref.watch(songsSortedProvider(bandId));
    final mq = MediaQuery.of(context);
    final bool showExtended =
        mq.size.width >= 600 || mq.orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Songs'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (v) {
              final notifier = ref.read(songSortProvider.notifier);
              if (v == 'toggle') {
                notifier.toggleOrder();
              } else {
                notifier.setField(
                    SongSortField.values.firstWhere((e) => e.name == v));
              }
            },
            itemBuilder: (c) => [
              PopupMenuItem(
                value: 'toggle',
                child: Text(
                    'Order: ${sortState.order == SortOrder.asc ? 'ASC' : 'DESC'}'),
              ),
              const PopupMenuDivider(),
              ...SongSortField.values.map(
                (f) => PopupMenuItem(
                  value: f.name,
                  child: Row(
                    children: [
                      if (f == sortState.field)
                        const Icon(Icons.check, size: 16)
                      else
                        const SizedBox(width: 16),
                      const SizedBox(width: 8),
                      Text(f.name),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: showExtended
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Artist')),
                  DataColumn(label: Text('Key')),
                  DataColumn(label: Text('Tempo')),
                  DataColumn(label: Text('Streaming')),
                ],
                rows: sortedSongs
                    .map(
                      (s) => DataRow(
                        cells: [
                          DataCell(Text(s.title), onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => SongDetailScreen(songId: s.id),
                              ),
                            );
                          }),
                          DataCell(Text(s.artist ?? '')),
                          DataCell(Text(s.key ?? '')),
                          DataCell(Text(s.tempo?.toString() ?? '')),
                          DataCell(
                            s.streamingUrl != null
                                ? const Icon(Icons.link,
                                    size: 18, color: Colors.indigo)
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
          : ListView.builder(
              itemCount: sortedSongs.length,
              itemBuilder: (_, i) {
                final s = sortedSongs[i];
                return ListTile(
                  title: Text(s.title),
                  subtitle: s.artist == null ? null : Text(s.artist!),
                  trailing: (s.key != null ||
                          s.tempo != null ||
                          s.streamingUrl != null)
                      ? Wrap(
                          spacing: 8,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            if (s.key != null)
                              Text(s.key!,
                                  style: const TextStyle(fontSize: 12)),
                            if (s.tempo != null)
                              Text('${s.tempo} BPM',
                                  style: const TextStyle(fontSize: 12)),
                            if (s.streamingUrl != null)
                              const Icon(Icons.link,
                                  size: 16, color: Colors.indigo),
                          ],
                        )
                      : null,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SongDetailScreen(songId: s.id),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openImport(context, ref),
        label: const Text('Import'),
        icon: const Icon(Icons.file_upload),
      ),
    );
  }

  void _openImport(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    SongImportFormat format = SongImportFormat.plainText;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Import Songs',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButton<SongImportFormat>(
                value: format,
                onChanged: (v) => setState(() => format = v!),
                items: const [
                  DropdownMenuItem(
                      value: SongImportFormat.plainText,
                      child: Text('Plain Text')),
                  DropdownMenuItem(
                      value: SongImportFormat.markdown,
                      child: Text('Markdown List')),
                  DropdownMenuItem(
                      value: SongImportFormat.csv, child: Text('CSV')),
                ],
              ),
              TextField(
                controller: controller,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: 'Text: Song Name - Artist Name (one per line)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () async {
                  final service = ref.read(songImportServiceProvider);
                  final res = await service.import(controller.text, format);
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Imported ${res.added} songs'
                          '${res.skippedDuplicates > 0 ? ', ${res.skippedDuplicates} duplicates skipped' : ''}'
                          '${res.errors.isNotEmpty ? ' (errors: ${res.errors.length})' : ''}',
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Import'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
