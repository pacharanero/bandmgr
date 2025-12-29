import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'json_store.dart';

final jsonStoreProvider = Provider<JsonStore>((ref) {
  return JsonStore();
});
