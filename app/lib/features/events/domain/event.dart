class Event {
  final String id;
  final String name;
  final DateTime date;
  final String location;
  final List<String> memberIds;
  const Event({
    required this.id,
    required this.name,
    required this.date,
    required this.location,
    required this.memberIds,
  });
}
