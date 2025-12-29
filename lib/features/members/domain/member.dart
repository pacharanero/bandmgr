class Member {
  final String id;
  final String bandId;
  final String name;
  final String email;
  final List<String> roles; // admin, editor, viewer, instrument roles, etc.
  final List<String> tagIds; // associated Tag ids
  const Member({
    required this.id,
    required this.bandId,
    required this.name,
    required this.email,
    required this.roles,
    required this.tagIds,
  });

  Member copyWith({
    String? name,
    String? email,
    List<String>? roles,
    List<String>? tagIds,
  }) =>
      Member(
        id: id,
        bandId: bandId,
        name: name ?? this.name,
        email: email ?? this.email,
        roles: roles ?? this.roles,
        tagIds: tagIds ?? this.tagIds,
      );
}
