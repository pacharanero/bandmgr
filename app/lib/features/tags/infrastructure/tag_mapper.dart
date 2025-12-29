import 'dart:convert';

class TagMapper {
  static String encodeList(List<String> list) => jsonEncode(list);
  static List<dynamic> decodeList(String json) =>
      json.isEmpty ? <dynamic>[] : jsonDecode(json) as List<dynamic>;
}
