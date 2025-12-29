import 'package:flutter_test/flutter_test.dart';
import 'package:bandmgr/main.dart';

void main() {
  testWidgets('App builds and shows home title', (tester) async {
    await tester.pumpWidget(const BandMgrApp());
    expect(find.text('BandMgr'), findsOneWidget);
  });
}
