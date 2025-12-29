class Song {
  final String id;
  final String bandId;
  final String title;
  final String? artist;
  final String? album;
  final String? key;
  final int? tempo; // BPM
  final Duration? length;
  final Map<String, dynamic> external; // links, etc.
  final String? streamingUrl; // NEW: primary streaming link
  const Song({
    required this.id,
    required this.bandId,
    required this.title,
    this.artist,
    this.album,
    this.key,
    this.tempo,
    this.length,
    this.external = const {},
    this.streamingUrl,
  });

  Song copyWith({
    String? title,
    String? artist,
    String? album,
    String? key,
    int? tempo,
    Duration? length,
    Map<String, dynamic>? external,
    String? streamingUrl,
  }) =>
      Song(
        id: id,
        bandId: bandId,
        title: title ?? this.title,
        artist: artist ?? this.artist,
        album: album ?? this.album,
        key: key ?? this.key,
        tempo: tempo ?? this.tempo,
        length: length ?? this.length,
        external: external ?? this.external,
        streamingUrl: streamingUrl ?? this.streamingUrl,
      );
}
