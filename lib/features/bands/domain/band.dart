class Band {
  final String id;
  final String name;
  final String ownerMemberId;
  final List<String> tagIds;
  const Band({
    required this.id,
    required this.name,
    required this.ownerMemberId,
    required this.tagIds,
  });
}
