import 'dart:async';
import '../../../core/persistence/json_store.dart';
import '../domain/member.dart';

// Legacy (kept for reference)
// class InMemoryMemberRepository { ...existing code... }

abstract class MemberRepository {
  Stream<List<Member>> watchByBand(String bandId);
  Future<void> upsert(Member member);
}

class JsonMemberRepository implements MemberRepository {
  final JsonStore store;
  JsonMemberRepository(this.store);

  Member _map(Map<String, dynamic> r, List<String> tagIds) => Member(
        id: r['id'] as String,
        bandId: r['bandId'] as String,
        name: r['name'] as String,
        email: r['email'] as String,
        roles: (r['roles'] as List? ?? const <dynamic>[])
            .map((e) => e.toString())
            .toList(),
        tagIds: tagIds,
      );

  @override
  Stream<List<Member>> watchByBand(String bandId) async* {
    // Combine member rows with their taggings.
    yield* store.watchCollection('members').asyncMap((rows) async {
      final scoped = rows.where((r) => r['bandId'] == bandId).toList();
      final ids = scoped.map((e) => e['id'] as String).toList();
      final tagMap = await store.fetchTagIdsForEntities('member', ids);
      return scoped
          .map((r) => _map(r, tagMap[r['id']] ?? const []))
          .toList(growable: false);
    });
  }

  @override
  Future<void> upsert(Member member) async {
    await store.upsertItem('members', member.id, {
      'id': member.id,
      'bandId': member.bandId,
      'name': member.name,
      'email': member.email,
      'roles': member.roles,
    });
    await store.replaceTaggings('member', member.id, member.tagIds);
  }
}
