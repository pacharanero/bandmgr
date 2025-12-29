import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:bandmgr/core/persistence/json_store.dart';

void main() {
  test('json store initializes and reads collections', () async {
    final dir = Directory.systemTemp.createTempSync('bandmgr-test');
    final file = File(p.join(dir.path, 'bandmgr.json'));
    final store = JsonStore.withFile(file);
    final members = await store.readCollection('members');
    expect(members, isA<List>());
  });
}
