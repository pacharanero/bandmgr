import 'package:flutter_test/flutter_test.dart';
import 'package:bandmgr/core/persistence/app_database.dart';

void main() {
  test('database initializes singleton', () async {
    final db1 = AppDatabase();
    final db2 = AppDatabase();
    expect(db1, same(db2));
    // just ensure tables accessible
    final count = await db1.select(db1.members).get();
    expect(count, isA<List>());
  });
}
