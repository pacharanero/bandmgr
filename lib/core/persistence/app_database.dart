import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

const _uuid = Uuid();

String _newId() => _uuid.v4();

@DataClassName('BandRow')
class Bands extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get ownerMemberId => text()();
  TextColumn get createdAt => text()(); // ISO8601
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MemberRow')
class Members extends Table {
  TextColumn get id => text()();
  TextColumn get bandId => text()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get rolesJson => text().withDefault(const Constant('[]'))();
  TextColumn get createdAt => text()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SongRow')
class Songs extends Table {
  TextColumn get id => text()();
  TextColumn get bandId => text()();
  TextColumn get title => text()();
  TextColumn get artist => text().nullable()();
  TextColumn get album => text().nullable()();
  TextColumn get key => text().nullable()();
  IntColumn get tempo => integer().nullable()();
  TextColumn get externalJson => text().withDefault(const Constant('{}'))();
  @override
  Set<Column> get primaryKey => {id};
}

class Setlists extends Table {
  TextColumn get id => text()();
  TextColumn get bandId => text()();
  TextColumn get name => text()();
  @override
  Set<Column> get primaryKey => {id};
}

class SetlistSongs extends Table {
  TextColumn get id => text()();
  TextColumn get setlistId => text()();
  TextColumn get songId => text()();
  IntColumn get position => integer()();
  @override
  Set<Column> get primaryKey => {id};
}

class Events extends Table {
  TextColumn get id => text()();
  TextColumn get bandId => text()();
  TextColumn get name => text()();
  TextColumn get dateIso => text()(); // DateTime serialized
  TextColumn get location => text().nullable()();
  TextColumn get notes => text().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

class Equipment extends Table {
  TextColumn get id => text()();
  TextColumn get bandId => text()();
  TextColumn get name => text()();
  TextColumn get spec => text().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

class Tags extends Table {
  TextColumn get id => text()();
  TextColumn get label => text()();
  TextColumn get colorHex => text().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

class Taggings extends Table {
  TextColumn get id => text()();
  TextColumn get tagId => text()();
  TextColumn get entityType => text()(); // e.g. 'song', 'member'
  TextColumn get entityId => text()();
  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Bands,
    Members,
    Songs,
    Setlists,
    SetlistSongs,
    Events,
    Equipment,
    Tags,
    Taggings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal() : super(_open());
  static final AppDatabase _singleton = AppDatabase._internal();
  factory AppDatabase() => _singleton;

  @override
  int get schemaVersion => 1;

  // Simple id helper
  String uuid() => _newId();

  // Watches
  Stream<List<MemberRow>> watchMembersByBand(String bandId) =>
      (select(members)..where((m) => m.bandId.equals(bandId))).watch();
  Stream<List<SongRow>> watchSongsByBand(String bandId) =>
      (select(songs)..where((s) => s.bandId.equals(bandId))).watch();

  Future<Map<String, List<String>>> fetchTagIdsForEntities(
      String entityType, List<String> entityIds) async {
    if (entityIds.isEmpty) return {};
    final q = select(taggings)
      ..where(
          (t) => t.entityType.equals(entityType) & t.entityId.isIn(entityIds));
    final rows = await q.get();
    final map = <String, List<String>>{};
    for (final r in rows) {
      map.putIfAbsent(r.entityId, () => []).add(r.tagId);
    }
    return map;
  }

  Future<void> deleteTaggingsForEntity(String entityType, String entityId) =>
      (delete(taggings)
            ..where((t) =>
                t.entityType.equals(entityType) & t.entityId.equals(entityId)))
          .go();
}

LazyDatabase _open() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'bandmgr.db'));
    return NativeDatabase.createInBackground(file);
  });
}
