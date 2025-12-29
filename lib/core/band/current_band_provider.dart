import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentBandIdProvider = Provider<String>((ref) {
  // TODO: Replace with persisted / user-selected band id.
  return 'default-band';
});
