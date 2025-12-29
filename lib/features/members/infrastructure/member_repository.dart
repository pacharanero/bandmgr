import 'dart:async';
import '../../../core/persistence/app_database.dart';
import '../../tags/infrastructure/tag_mapper.dart';
import '../domain/member.dart';

// Legacy (kept for reference)
// class InMemoryMemberRepository { ...existing code... }

abstract class MemberRepository {
  Stream<List<Member>> watchByBand(String bandId);
  Future<void> upsert(Member member);
}

class DriftMemberRepository implements MemberRepository {
  final AppDatabase db;
  DriftMemberRepository(this.db);

  Member _map(MemberRow r, List<String> tagIds) => Member(
        id: r.id,
        bandId: r.bandId,
        name: r.name,
        email: r.email,
        roles: (r.rolesJson.isEmpty
                ? <String>[]
                : (TagMapper.decodeList(r.rolesJson)))
            .cast<String>(),
        tagIds: tagIds,
      );

  @override
  Stream<List<Member>> watchByBand(String bandId) async* {
    // Combine member rows with their taggings.
    yield* db.watchMembersByBand(bandId).asyncMap((rows) async {
      final ids = rows.map((e) => e.id).toList();
      final tagMap = await db.fetchTagIdsForEntities('member', ids);
      return rows
          .map((r) => _map(r, tagMap[r.id] ?? const []))
          .toList(growable: false);
    });
  }

  @override
  Future<void> upsert(Member member) async {
    return db.transaction(() async {
      await db.into(db.members).insertOnConflictUpdate(MembersCompanion.insert(
            id: member.id,
            bandId: member.bandId,
            name: member.name,
            email: member.email,
            rolesJson: TagMapper.encodeList(member.roles),
          ));
      // Clear existing taggings then re-add
      await db.deleteTaggingsForEntity('member', member.id);
      if (member.tagIds.isNotEmpty) {
        await db.batch((b) {
          b.insertAll(
            db.taggings,
            member.tagIds
                .map((t) => TaggingsCompanion.insert(
                      id: db.uuid(),
                      tagId: t,
                      entityType: 'member',
                      entityId: member.id,
                    ))
                .toList(),
          );
        });
      }
    });
  }
}
