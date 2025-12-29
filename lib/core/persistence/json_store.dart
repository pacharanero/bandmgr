import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

Map<String, dynamic> _emptyData() => {
      'version': 1,
      'bands': <Map<String, dynamic>>[],
      'members': <Map<String, dynamic>>[],
      'songs': <Map<String, dynamic>>[],
      'setlists': <Map<String, dynamic>>[],
      'setlistSongs': <Map<String, dynamic>>[],
      'events': <Map<String, dynamic>>[],
      'equipment': <Map<String, dynamic>>[],
      'tags': <Map<String, dynamic>>[],
      'taggings': <Map<String, dynamic>>[],
    };

class JsonStore {
  JsonStore._internal();
  static final JsonStore _singleton = JsonStore._internal();
  factory JsonStore() => _singleton;

  JsonStore.withFile(File file) {
    _file = file;
    _hasFile = true;
  }

  final _changes = StreamController<void>.broadcast();
  late File _file;
  bool _hasFile = false;
  bool _loaded = false;
  Map<String, dynamic> _data = _emptyData();

  String uuid() => _uuid.v4();

  Stream<void> watchChanges() => _changes.stream;

  Stream<List<Map<String, dynamic>>> watchCollection(String key) async* {
    await _ensureLoaded();
    yield _readCollection(key);
    yield* _changes.stream.map((_) => _readCollection(key));
  }

  Future<List<Map<String, dynamic>>> readCollection(String key) async {
    await _ensureLoaded();
    return _readCollection(key);
  }

  Future<void> upsertItem(
    String key,
    String id,
    Map<String, dynamic> item,
  ) async {
    await _ensureLoaded();
    final items = _readCollection(key);
    final index = items.indexWhere((e) => e['id'] == id);
    if (index >= 0) {
      items[index] = Map<String, dynamic>.from(item);
    } else {
      items.add(Map<String, dynamic>.from(item));
    }
    _data[key] = items;
    await _save();
    _changes.add(null);
  }

  Future<void> upsertAll(
    String key,
    List<Map<String, dynamic>> items,
  ) async {
    if (items.isEmpty) return;
    await _ensureLoaded();
    final existing = _readCollection(key);
    final byId = <String, Map<String, dynamic>>{
      for (final item in existing) item['id'] as String: item,
    };
    for (final item in items) {
      final id = item['id'] as String;
      byId[id] = Map<String, dynamic>.from(item);
    }
    _data[key] = byId.values.toList();
    await _save();
    _changes.add(null);
  }

  Future<Map<String, List<String>>> fetchTagIdsForEntities(
    String entityType,
    List<String> entityIds,
  ) async {
    await _ensureLoaded();
    if (entityIds.isEmpty) return {};
    final taggings = _readCollection('taggings');
    final map = <String, List<String>>{};
    for (final tag in taggings) {
      if (tag['entityType'] != entityType) continue;
      final entityId = tag['entityId'] as String;
      if (!entityIds.contains(entityId)) continue;
      map.putIfAbsent(entityId, () => []).add(tag['tagId'] as String);
    }
    return map;
  }

  Future<void> replaceTaggings(
    String entityType,
    String entityId,
    List<String> tagIds,
  ) async {
    await _ensureLoaded();
    final taggings = _readCollection('taggings');
    taggings.removeWhere((t) =>
        t['entityType'] == entityType && t['entityId'] == entityId);
    for (final tagId in tagIds) {
      taggings.add({
        'id': uuid(),
        'tagId': tagId,
        'entityType': entityType,
        'entityId': entityId,
      });
    }
    _data['taggings'] = taggings;
    await _save();
    _changes.add(null);
  }

  Future<void> _ensureLoaded() async {
    if (_loaded) return;
    if (!_hasFile) {
      final dir = await getApplicationDocumentsDirectory();
      _file = File(p.join(dir.path, 'bandmgr.json'));
      _hasFile = true;
    }
    if (await _file.exists()) {
      final raw = await _file.readAsString();
      if (raw.trim().isNotEmpty) {
        _data = jsonDecode(raw) as Map<String, dynamic>;
      }
    } else {
      await _save();
    }
    _loaded = true;
  }

  List<Map<String, dynamic>> _readCollection(String key) {
    final raw = _data[key];
    if (raw is! List) return [];
    return raw
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList(growable: false);
  }

  Future<void> _save() async {
    final json = const JsonEncoder.withIndent('  ').convert(_data);
    final dir = _file.parent;
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    final temp = File('${_file.path}.tmp');
    await temp.writeAsString(json);
    await temp.rename(_file.path);
  }
}
