// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BandsTable extends Bands with TableInfo<$BandsTable, BandRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BandsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ownerMemberIdMeta =
      const VerificationMeta('ownerMemberId');
  @override
  late final GeneratedColumn<String> ownerMemberId = GeneratedColumn<String>(
      'owner_member_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, ownerMemberId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bands';
  @override
  VerificationContext validateIntegrity(Insertable<BandRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('owner_member_id')) {
      context.handle(
          _ownerMemberIdMeta,
          ownerMemberId.isAcceptableOrUnknown(
              data['owner_member_id']!, _ownerMemberIdMeta));
    } else if (isInserting) {
      context.missing(_ownerMemberIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BandRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BandRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      ownerMemberId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}owner_member_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $BandsTable createAlias(String alias) {
    return $BandsTable(attachedDatabase, alias);
  }
}

class BandRow extends DataClass implements Insertable<BandRow> {
  final String id;
  final String name;
  final String ownerMemberId;
  final String createdAt;
  const BandRow(
      {required this.id,
      required this.name,
      required this.ownerMemberId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['owner_member_id'] = Variable<String>(ownerMemberId);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  BandsCompanion toCompanion(bool nullToAbsent) {
    return BandsCompanion(
      id: Value(id),
      name: Value(name),
      ownerMemberId: Value(ownerMemberId),
      createdAt: Value(createdAt),
    );
  }

  factory BandRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BandRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      ownerMemberId: serializer.fromJson<String>(json['ownerMemberId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'ownerMemberId': serializer.toJson<String>(ownerMemberId),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  BandRow copyWith(
          {String? id,
          String? name,
          String? ownerMemberId,
          String? createdAt}) =>
      BandRow(
        id: id ?? this.id,
        name: name ?? this.name,
        ownerMemberId: ownerMemberId ?? this.ownerMemberId,
        createdAt: createdAt ?? this.createdAt,
      );
  BandRow copyWithCompanion(BandsCompanion data) {
    return BandRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      ownerMemberId: data.ownerMemberId.present
          ? data.ownerMemberId.value
          : this.ownerMemberId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BandRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ownerMemberId: $ownerMemberId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, ownerMemberId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BandRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.ownerMemberId == this.ownerMemberId &&
          other.createdAt == this.createdAt);
}

class BandsCompanion extends UpdateCompanion<BandRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> ownerMemberId;
  final Value<String> createdAt;
  final Value<int> rowid;
  const BandsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.ownerMemberId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BandsCompanion.insert({
    required String id,
    required String name,
    required String ownerMemberId,
    required String createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        ownerMemberId = Value(ownerMemberId),
        createdAt = Value(createdAt);
  static Insertable<BandRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? ownerMemberId,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (ownerMemberId != null) 'owner_member_id': ownerMemberId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BandsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? ownerMemberId,
      Value<String>? createdAt,
      Value<int>? rowid}) {
    return BandsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      ownerMemberId: ownerMemberId ?? this.ownerMemberId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (ownerMemberId.present) {
      map['owner_member_id'] = Variable<String>(ownerMemberId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BandsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ownerMemberId: $ownerMemberId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MembersTable extends Members with TableInfo<$MembersTable, MemberRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bandIdMeta = const VerificationMeta('bandId');
  @override
  late final GeneratedColumn<String> bandId = GeneratedColumn<String>(
      'band_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rolesJsonMeta =
      const VerificationMeta('rolesJson');
  @override
  late final GeneratedColumn<String> rolesJson = GeneratedColumn<String>(
      'roles_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, bandId, name, email, rolesJson, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'members';
  @override
  VerificationContext validateIntegrity(Insertable<MemberRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('band_id')) {
      context.handle(_bandIdMeta,
          bandId.isAcceptableOrUnknown(data['band_id']!, _bandIdMeta));
    } else if (isInserting) {
      context.missing(_bandIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('roles_json')) {
      context.handle(_rolesJsonMeta,
          rolesJson.isAcceptableOrUnknown(data['roles_json']!, _rolesJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemberRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemberRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      bandId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}band_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      rolesJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}roles_json'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MembersTable createAlias(String alias) {
    return $MembersTable(attachedDatabase, alias);
  }
}

class MemberRow extends DataClass implements Insertable<MemberRow> {
  final String id;
  final String bandId;
  final String name;
  final String email;
  final String rolesJson;
  final String createdAt;
  const MemberRow(
      {required this.id,
      required this.bandId,
      required this.name,
      required this.email,
      required this.rolesJson,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['band_id'] = Variable<String>(bandId);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['roles_json'] = Variable<String>(rolesJson);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  MembersCompanion toCompanion(bool nullToAbsent) {
    return MembersCompanion(
      id: Value(id),
      bandId: Value(bandId),
      name: Value(name),
      email: Value(email),
      rolesJson: Value(rolesJson),
      createdAt: Value(createdAt),
    );
  }

  factory MemberRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemberRow(
      id: serializer.fromJson<String>(json['id']),
      bandId: serializer.fromJson<String>(json['bandId']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      rolesJson: serializer.fromJson<String>(json['rolesJson']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bandId': serializer.toJson<String>(bandId),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'rolesJson': serializer.toJson<String>(rolesJson),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  MemberRow copyWith(
          {String? id,
          String? bandId,
          String? name,
          String? email,
          String? rolesJson,
          String? createdAt}) =>
      MemberRow(
        id: id ?? this.id,
        bandId: bandId ?? this.bandId,
        name: name ?? this.name,
        email: email ?? this.email,
        rolesJson: rolesJson ?? this.rolesJson,
        createdAt: createdAt ?? this.createdAt,
      );
  MemberRow copyWithCompanion(MembersCompanion data) {
    return MemberRow(
      id: data.id.present ? data.id.value : this.id,
      bandId: data.bandId.present ? data.bandId.value : this.bandId,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      rolesJson: data.rolesJson.present ? data.rolesJson.value : this.rolesJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MemberRow(')
          ..write('id: $id, ')
          ..write('bandId: $bandId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('rolesJson: $rolesJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, bandId, name, email, rolesJson, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemberRow &&
          other.id == this.id &&
          other.bandId == this.bandId &&
          other.name == this.name &&
          other.email == this.email &&
          other.rolesJson == this.rolesJson &&
          other.createdAt == this.createdAt);
}

class MembersCompanion extends UpdateCompanion<MemberRow> {
  final Value<String> id;
  final Value<String> bandId;
  final Value<String> name;
  final Value<String> email;
  final Value<String> rolesJson;
  final Value<String> createdAt;
  final Value<int> rowid;
  const MembersCompanion({
    this.id = const Value.absent(),
    this.bandId = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.rolesJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MembersCompanion.insert({
    required String id,
    required String bandId,
    required String name,
    required String email,
    this.rolesJson = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        bandId = Value(bandId),
        name = Value(name),
        email = Value(email),
        createdAt = Value(createdAt);
  static Insertable<MemberRow> custom({
    Expression<String>? id,
    Expression<String>? bandId,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? rolesJson,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bandId != null) 'band_id': bandId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (rolesJson != null) 'roles_json': rolesJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MembersCompanion copyWith(
      {Value<String>? id,
      Value<String>? bandId,
      Value<String>? name,
      Value<String>? email,
      Value<String>? rolesJson,
      Value<String>? createdAt,
      Value<int>? rowid}) {
    return MembersCompanion(
      id: id ?? this.id,
      bandId: bandId ?? this.bandId,
      name: name ?? this.name,
      email: email ?? this.email,
      rolesJson: rolesJson ?? this.rolesJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bandId.present) {
      map['band_id'] = Variable<String>(bandId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (rolesJson.present) {
      map['roles_json'] = Variable<String>(rolesJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembersCompanion(')
          ..write('id: $id, ')
          ..write('bandId: $bandId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('rolesJson: $rolesJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SongsTable extends Songs with TableInfo<$SongsTable, SongRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SongsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bandIdMeta = const VerificationMeta('bandId');
  @override
  late final GeneratedColumn<String> bandId = GeneratedColumn<String>(
      'band_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _albumMeta = const VerificationMeta('album');
  @override
  late final GeneratedColumn<String> album = GeneratedColumn<String>(
      'album', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tempoMeta = const VerificationMeta('tempo');
  @override
  late final GeneratedColumn<int> tempo = GeneratedColumn<int>(
      'tempo', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _externalJsonMeta =
      const VerificationMeta('externalJson');
  @override
  late final GeneratedColumn<String> externalJson = GeneratedColumn<String>(
      'external_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, bandId, title, artist, album, key, tempo, externalJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'songs';
  @override
  VerificationContext validateIntegrity(Insertable<SongRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('band_id')) {
      context.handle(_bandIdMeta,
          bandId.isAcceptableOrUnknown(data['band_id']!, _bandIdMeta));
    } else if (isInserting) {
      context.missing(_bandIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    }
    if (data.containsKey('album')) {
      context.handle(
          _albumMeta, album.isAcceptableOrUnknown(data['album']!, _albumMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    }
    if (data.containsKey('tempo')) {
      context.handle(
          _tempoMeta, tempo.isAcceptableOrUnknown(data['tempo']!, _tempoMeta));
    }
    if (data.containsKey('external_json')) {
      context.handle(
          _externalJsonMeta,
          externalJson.isAcceptableOrUnknown(
              data['external_json']!, _externalJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SongRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SongRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      bandId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}band_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist']),
      album: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}album']),
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key']),
      tempo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tempo']),
      externalJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}external_json'])!,
    );
  }

  @override
  $SongsTable createAlias(String alias) {
    return $SongsTable(attachedDatabase, alias);
  }
}

class SongRow extends DataClass implements Insertable<SongRow> {
  final String id;
  final String bandId;
  final String title;
  final String? artist;
  final String? album;
  final String? key;
  final int? tempo;
  final String externalJson;
  const SongRow(
      {required this.id,
      required this.bandId,
      required this.title,
      this.artist,
      this.album,
      this.key,
      this.tempo,
      required this.externalJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['band_id'] = Variable<String>(bandId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || artist != null) {
      map['artist'] = Variable<String>(artist);
    }
    if (!nullToAbsent || album != null) {
      map['album'] = Variable<String>(album);
    }
    if (!nullToAbsent || key != null) {
      map['key'] = Variable<String>(key);
    }
    if (!nullToAbsent || tempo != null) {
      map['tempo'] = Variable<int>(tempo);
    }
    map['external_json'] = Variable<String>(externalJson);
    return map;
  }

  SongsCompanion toCompanion(bool nullToAbsent) {
    return SongsCompanion(
      id: Value(id),
      bandId: Value(bandId),
      title: Value(title),
      artist:
          artist == null && nullToAbsent ? const Value.absent() : Value(artist),
      album:
          album == null && nullToAbsent ? const Value.absent() : Value(album),
      key: key == null && nullToAbsent ? const Value.absent() : Value(key),
      tempo:
          tempo == null && nullToAbsent ? const Value.absent() : Value(tempo),
      externalJson: Value(externalJson),
    );
  }

  factory SongRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SongRow(
      id: serializer.fromJson<String>(json['id']),
      bandId: serializer.fromJson<String>(json['bandId']),
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String?>(json['artist']),
      album: serializer.fromJson<String?>(json['album']),
      key: serializer.fromJson<String?>(json['key']),
      tempo: serializer.fromJson<int?>(json['tempo']),
      externalJson: serializer.fromJson<String>(json['externalJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bandId': serializer.toJson<String>(bandId),
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String?>(artist),
      'album': serializer.toJson<String?>(album),
      'key': serializer.toJson<String?>(key),
      'tempo': serializer.toJson<int?>(tempo),
      'externalJson': serializer.toJson<String>(externalJson),
    };
  }

  SongRow copyWith(
          {String? id,
          String? bandId,
          String? title,
          Value<String?> artist = const Value.absent(),
          Value<String?> album = const Value.absent(),
          Value<String?> key = const Value.absent(),
          Value<int?> tempo = const Value.absent(),
          String? externalJson}) =>
      SongRow(
        id: id ?? this.id,
        bandId: bandId ?? this.bandId,
        title: title ?? this.title,
        artist: artist.present ? artist.value : this.artist,
        album: album.present ? album.value : this.album,
        key: key.present ? key.value : this.key,
        tempo: tempo.present ? tempo.value : this.tempo,
        externalJson: externalJson ?? this.externalJson,
      );
  SongRow copyWithCompanion(SongsCompanion data) {
    return SongRow(
      id: data.id.present ? data.id.value : this.id,
      bandId: data.bandId.present ? data.bandId.value : this.bandId,
      title: data.title.present ? data.title.value : this.title,
      artist: data.artist.present ? data.artist.value : this.artist,
      album: data.album.present ? data.album.value : this.album,
      key: data.key.present ? data.key.value : this.key,
      tempo: data.tempo.present ? data.tempo.value : this.tempo,
      externalJson: data.externalJson.present
          ? data.externalJson.value
          : this.externalJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SongRow(')
          ..write('id: $id, ')
          ..write('bandId: $bandId, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('key: $key, ')
          ..write('tempo: $tempo, ')
          ..write('externalJson: $externalJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, bandId, title, artist, album, key, tempo, externalJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SongRow &&
          other.id == this.id &&
          other.bandId == this.bandId &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.album == this.album &&
          other.key == this.key &&
          other.tempo == this.tempo &&
          other.externalJson == this.externalJson);
}

class SongsCompanion extends UpdateCompanion<SongRow> {
  final Value<String> id;
  final Value<String> bandId;
  final Value<String> title;
  final Value<String?> artist;
  final Value<String?> album;
  final Value<String?> key;
  final Value<int?> tempo;
  final Value<String> externalJson;
  final Value<int> rowid;
  const SongsCompanion({
    this.id = const Value.absent(),
    this.bandId = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.key = const Value.absent(),
    this.tempo = const Value.absent(),
    this.externalJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SongsCompanion.insert({
    required String id,
    required String bandId,
    required String title,
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.key = const Value.absent(),
    this.tempo = const Value.absent(),
    this.externalJson = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        bandId = Value(bandId),
        title = Value(title);
  static Insertable<SongRow> custom({
    Expression<String>? id,
    Expression<String>? bandId,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<String>? album,
    Expression<String>? key,
    Expression<int>? tempo,
    Expression<String>? externalJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bandId != null) 'band_id': bandId,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (album != null) 'album': album,
      if (key != null) 'key': key,
      if (tempo != null) 'tempo': tempo,
      if (externalJson != null) 'external_json': externalJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SongsCompanion copyWith(
      {Value<String>? id,
      Value<String>? bandId,
      Value<String>? title,
      Value<String?>? artist,
      Value<String?>? album,
      Value<String?>? key,
      Value<int?>? tempo,
      Value<String>? externalJson,
      Value<int>? rowid}) {
    return SongsCompanion(
      id: id ?? this.id,
      bandId: bandId ?? this.bandId,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      key: key ?? this.key,
      tempo: tempo ?? this.tempo,
      externalJson: externalJson ?? this.externalJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bandId.present) {
      map['band_id'] = Variable<String>(bandId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (album.present) {
      map['album'] = Variable<String>(album.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (tempo.present) {
      map['tempo'] = Variable<int>(tempo.value);
    }
    if (externalJson.present) {
      map['external_json'] = Variable<String>(externalJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SongsCompanion(')
          ..write('id: $id, ')
          ..write('bandId: $bandId, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('key: $key, ')
          ..write('tempo: $tempo, ')
          ..write('externalJson: $externalJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SetlistsTable extends Setlists with TableInfo<$SetlistsTable, Setlist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SetlistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bandIdMeta = const VerificationMeta('bandId');
  @override
  late final GeneratedColumn<String> bandId = GeneratedColumn<String>(
      'band_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, bandId, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'setlists';
  @override
  VerificationContext validateIntegrity(Insertable<Setlist> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('band_id')) {
      context.handle(_bandIdMeta,
          bandId.isAcceptableOrUnknown(data['band_id']!, _bandIdMeta));
    } else if (isInserting) {
      context.missing(_bandIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Setlist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setlist(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      bandId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}band_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $SetlistsTable createAlias(String alias) {
    return $SetlistsTable(attachedDatabase, alias);
  }
}

class Setlist extends DataClass implements Insertable<Setlist> {
  final String id;
  final String bandId;
  final String name;
  const Setlist({required this.id, required this.bandId, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['band_id'] = Variable<String>(bandId);
    map['name'] = Variable<String>(name);
    return map;
  }

  SetlistsCompanion toCompanion(bool nullToAbsent) {
    return SetlistsCompanion(
      id: Value(id),
      bandId: Value(bandId),
      name: Value(name),
    );
  }

  factory Setlist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setlist(
      id: serializer.fromJson<String>(json['id']),
      bandId: serializer.fromJson<String>(json['bandId']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bandId': serializer.toJson<String>(bandId),
      'name': serializer.toJson<String>(name),
    };
  }

  Setlist copyWith({String? id, String? bandId, String? name}) => Setlist(
        id: id ?? this.id,
        bandId: bandId ?? this.bandId,
        name: name ?? this.name,
      );
  Setlist copyWithCompanion(SetlistsCompanion data) {
    return Setlist(
      id: data.id.present ? data.id.value : this.id,
      bandId: data.bandId.present ? data.bandId.value : this.bandId,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setlist(')
          ..write('id: $id, ')
          ..write('bandId: $bandId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bandId, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setlist &&
          other.id == this.id &&
          other.bandId == this.bandId &&
          other.name == this.name);
}

class SetlistsCompanion extends UpdateCompanion<Setlist> {
  final Value<String> id;
  final Value<String> bandId;
  final Value<String> name;
  final Value<int> rowid;
  const SetlistsCompanion({
    this.id = const Value.absent(),
    this.bandId = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SetlistsCompanion.insert({
    required String id,
    required String bandId,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        bandId = Value(bandId),
        name = Value(name);
  static Insertable<Setlist> custom({
    Expression<String>? id,
    Expression<String>? bandId,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bandId != null) 'band_id': bandId,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SetlistsCompanion copyWith(
      {Value<String>? id,
      Value<String>? bandId,
      Value<String>? name,
      Value<int>? rowid}) {
    return SetlistsCompanion(
      id: id ?? this.id,
      bandId: bandId ?? this.bandId,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bandId.present) {
      map['band_id'] = Variable<String>(bandId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SetlistsCompanion(')
          ..write('id: $id, ')
          ..write('bandId: $bandId, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SetlistSongsTable extends SetlistSongs
    with TableInfo<$SetlistSongsTable, SetlistSong> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SetlistSongsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _setlistIdMeta =
      const VerificationMeta('setlistId');
  @override
  late final GeneratedColumn<String> setlistId = GeneratedColumn<String>(
      'setlist_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<String> songId = GeneratedColumn<String>(
      'song_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, setlistId, songId, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'setlist_songs';
  @override
  VerificationContext validateIntegrity(Insertable<SetlistSong> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('setlist_id')) {
      context.handle(_setlistIdMeta,
          setlistId.isAcceptableOrUnknown(data['setlist_id']!, _setlistIdMeta));
    } else if (isInserting) {
      context.missing(_setlistIdMeta);
    }
    if (data.containsKey('song_id')) {
      context.handle(_songIdMeta,
          songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta));
    } else if (isInserting) {
      context.missing(_songIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SetlistSong map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SetlistSong(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      setlistId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}setlist_id'])!,
      songId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}song_id'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
    );
  }

  @override
  $SetlistSongsTable createAlias(String alias) {
    return $SetlistSongsTable(attachedDatabase, alias);
  }
}

class SetlistSong extends DataClass implements Insertable<SetlistSong> {
  final String id;
  final String setlistId;
  final String songId;
  final int position;
  const SetlistSong(
      {required this.id,
      required this.setlistId,
      required this.songId,
      required this.position});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['setlist_id'] = Variable<String>(setlistId);
    map['song_id'] = Variable<String>(songId);
    map['position'] = Variable<int>(position);
    return map;
  }

  SetlistSongsCompanion toCompanion(bool nullToAbsent) {
    return SetlistSongsCompanion(
      id: Value(id),
      setlistId: Value(setlistId),
      songId: Value(songId),
      position: Value(position),
    );
  }

  factory SetlistSong.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SetlistSong(
      id: serializer.fromJson<String>(json['id']),
      setlistId: serializer.fromJson<String>(json['setlistId']),
      songId: serializer.fromJson<String>(json['songId']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'setlistId': serializer.toJson<String>(setlistId),
      'songId': serializer.toJson<String>(songId),
      'position': serializer.toJson<int>(position),
    };
  }

  SetlistSong copyWith(
          {String? id, String? setlistId, String? songId, int? position}) =>
      SetlistSong(
        id: id ?? this.id,
        setlistId: setlistId ?? this.setlistId,
        songId: songId ?? this.songId,
        position: position ?? this.position,
      );
  SetlistSong copyWithCompanion(SetlistSongsCompanion data) {
    return SetlistSong(
      id: data.id.present ? data.id.value : this.id,
      setlistId: data.setlistId.present ? data.setlistId.value : this.setlistId,
      songId: data.songId.present ? data.songId.value : this.songId,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SetlistSong(')
          ..write('id: $id, ')
          ..write('setlistId: $setlistId, ')
          ..write('songId: $songId, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, setlistId, songId, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SetlistSong &&
          other.id == this.id &&
          other.setlistId == this.setlistId &&
          other.songId == this.songId &&
          other.position == this.position);
}

class SetlistSongsCompanion extends UpdateCompanion<SetlistSong> {
  final Value<String> id;
  final Value<String> setlistId;
  final Value<String> songId;
  final Value<int> position;
  final Value<int> rowid;
  const SetlistSongsCompanion({
    this.id = const Value.absent(),
    this.setlistId = const Value.absent(),
    this.songId = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SetlistSongsCompanion.insert({
    required String id,
    required String setlistId,
    required String songId,
    required int position,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        setlistId = Value(setlistId),
        songId = Value(songId),
        position = Value(position);
  static Insertable<SetlistSong> custom({
    Expression<String>? id,
    Expression<String>? setlistId,
    Expression<String>? songId,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (setlistId != null) 'setlist_id': setlistId,
      if (songId != null) 'song_id': songId,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SetlistSongsCompanion copyWith(
      {Value<String>? id,
      Value<String>? setlistId,
      Value<String>? songId,
      Value<int>? position,
      Value<int>? rowid}) {
    return SetlistSongsCompanion(
      id: id ?? this.id,
      setlistId: setlistId ?? this.setlistId,
      songId: songId ?? this.songId,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (setlistId.present) {
      map['setlist_id'] = Variable<String>(setlistId.value);
    }
    if (songId.present) {
      map['song_id'] = Variable<String>(songId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SetlistSongsCompanion(')
          ..write('id: $id, ')
          ..write('setlistId: $setlistId, ')
          ..write('songId: $songId, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bandIdMeta = const VerificationMeta('bandId');
  @override
  late final GeneratedColumn<String> bandId = GeneratedColumn<String>(
      'band_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateIsoMeta =
      const VerificationMeta('dateIso');
  @override
  late final GeneratedColumn<String> dateIso = GeneratedColumn<String>(
      'date_iso', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, bandId, name, dateIso, location, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(Insertable<Event> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('band_id')) {
      context.handle(_bandIdMeta,
          bandId.isAcceptableOrUnknown(data['band_id']!, _bandIdMeta));
    } else if (isInserting) {
      context.missing(_bandIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('date_iso')) {
      context.handle(_dateIsoMeta,
          dateIso.isAcceptableOrUnknown(data['date_iso']!, _dateIsoMeta));
    } else if (isInserting) {
      context.missing(_dateIsoMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      bandId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}band_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      dateIso: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date_iso'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class Event extends DataClass implements Insertable<Event> {
  final String id;
  final String bandId;
  final String name;
  final String dateIso;
  final String? location;
  final String? notes;
  const Event(
      {required this.id,
      required this.bandId,
      required this.name,
      required this.dateIso,
      this.location,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['band_id'] = Variable<String>(bandId);
    map['name'] = Variable<String>(name);
    map['date_iso'] = Variable<String>(dateIso);
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      bandId: Value(bandId),
      name: Value(name),
      dateIso: Value(dateIso),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory Event.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<String>(json['id']),
      bandId: serializer.fromJson<String>(json['bandId']),
      name: serializer.fromJson<String>(json['name']),
      dateIso: serializer.fromJson<String>(json['dateIso']),
      location: serializer.fromJson<String?>(json['location']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bandId': serializer.toJson<String>(bandId),
      'name': serializer.toJson<String>(name),
      'dateIso': serializer.toJson<String>(dateIso),
      'location': serializer.toJson<String?>(location),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Event copyWith(
          {String? id,
          String? bandId,
          String? name,
          String? dateIso,
          Value<String?> location = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      Event(
        id: id ?? this.id,
        bandId: bandId ?? this.bandId,
        name: name ?? this.name,
        dateIso: dateIso ?? this.dateIso,
        location: location.present ? location.value : this.location,
        notes: notes.present ? notes.value : this.notes,
      );
  Event copyWithCompanion(EventsCompanion data) {
    return Event(
      id: data.id.present ? data.id.value : this.id,
      bandId: data.bandId.present ? data.bandId.value : this.bandId,
      name: data.name.present ? data.name.value : this.name,
      dateIso: data.dateIso.present ? data.dateIso.value : this.dateIso,
      location: data.location.present ? data.location.value : this.location,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('bandId: $bandId, ')
          ..write('name: $name, ')
          ..write('dateIso: $dateIso, ')
          ..write('location: $location, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bandId, name, dateIso, location, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.bandId == this.bandId &&
          other.name == this.name &&
          other.dateIso == this.dateIso &&
          other.location == this.location &&
          other.notes == this.notes);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<String> id;
  final Value<String> bandId;
  final Value<String> name;
  final Value<String> dateIso;
  final Value<String?> location;
  final Value<String?> notes;
  final Value<int> rowid;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.bandId = const Value.absent(),
    this.name = const Value.absent(),
    this.dateIso = const Value.absent(),
    this.location = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventsCompanion.insert({
    required String id,
    required String bandId,
    required String name,
    required String dateIso,
    this.location = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        bandId = Value(bandId),
        name = Value(name),
        dateIso = Value(dateIso);
  static Insertable<Event> custom({
    Expression<String>? id,
    Expression<String>? bandId,
    Expression<String>? name,
    Expression<String>? dateIso,
    Expression<String>? location,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bandId != null) 'band_id': bandId,
      if (name != null) 'name': name,
      if (dateIso != null) 'date_iso': dateIso,
      if (location != null) 'location': location,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventsCompanion copyWith(
      {Value<String>? id,
      Value<String>? bandId,
      Value<String>? name,
      Value<String>? dateIso,
      Value<String?>? location,
      Value<String?>? notes,
      Value<int>? rowid}) {
    return EventsCompanion(
      id: id ?? this.id,
      bandId: bandId ?? this.bandId,
      name: name ?? this.name,
      dateIso: dateIso ?? this.dateIso,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bandId.present) {
      map['band_id'] = Variable<String>(bandId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dateIso.present) {
      map['date_iso'] = Variable<String>(dateIso.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('bandId: $bandId, ')
          ..write('name: $name, ')
          ..write('dateIso: $dateIso, ')
          ..write('location: $location, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EquipmentTable extends Equipment
    with TableInfo<$EquipmentTable, EquipmentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EquipmentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bandIdMeta = const VerificationMeta('bandId');
  @override
  late final GeneratedColumn<String> bandId = GeneratedColumn<String>(
      'band_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _specMeta = const VerificationMeta('spec');
  @override
  late final GeneratedColumn<String> spec = GeneratedColumn<String>(
      'spec', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, bandId, name, spec];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'equipment';
  @override
  VerificationContext validateIntegrity(Insertable<EquipmentData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('band_id')) {
      context.handle(_bandIdMeta,
          bandId.isAcceptableOrUnknown(data['band_id']!, _bandIdMeta));
    } else if (isInserting) {
      context.missing(_bandIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('spec')) {
      context.handle(
          _specMeta, spec.isAcceptableOrUnknown(data['spec']!, _specMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EquipmentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EquipmentData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      bandId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}band_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      spec: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}spec']),
    );
  }

  @override
  $EquipmentTable createAlias(String alias) {
    return $EquipmentTable(attachedDatabase, alias);
  }
}

class EquipmentData extends DataClass implements Insertable<EquipmentData> {
  final String id;
  final String bandId;
  final String name;
  final String? spec;
  const EquipmentData(
      {required this.id, required this.bandId, required this.name, this.spec});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['band_id'] = Variable<String>(bandId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || spec != null) {
      map['spec'] = Variable<String>(spec);
    }
    return map;
  }

  EquipmentCompanion toCompanion(bool nullToAbsent) {
    return EquipmentCompanion(
      id: Value(id),
      bandId: Value(bandId),
      name: Value(name),
      spec: spec == null && nullToAbsent ? const Value.absent() : Value(spec),
    );
  }

  factory EquipmentData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EquipmentData(
      id: serializer.fromJson<String>(json['id']),
      bandId: serializer.fromJson<String>(json['bandId']),
      name: serializer.fromJson<String>(json['name']),
      spec: serializer.fromJson<String?>(json['spec']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bandId': serializer.toJson<String>(bandId),
      'name': serializer.toJson<String>(name),
      'spec': serializer.toJson<String?>(spec),
    };
  }

  EquipmentData copyWith(
          {String? id,
          String? bandId,
          String? name,
          Value<String?> spec = const Value.absent()}) =>
      EquipmentData(
        id: id ?? this.id,
        bandId: bandId ?? this.bandId,
        name: name ?? this.name,
        spec: spec.present ? spec.value : this.spec,
      );
  EquipmentData copyWithCompanion(EquipmentCompanion data) {
    return EquipmentData(
      id: data.id.present ? data.id.value : this.id,
      bandId: data.bandId.present ? data.bandId.value : this.bandId,
      name: data.name.present ? data.name.value : this.name,
      spec: data.spec.present ? data.spec.value : this.spec,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentData(')
          ..write('id: $id, ')
          ..write('bandId: $bandId, ')
          ..write('name: $name, ')
          ..write('spec: $spec')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bandId, name, spec);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EquipmentData &&
          other.id == this.id &&
          other.bandId == this.bandId &&
          other.name == this.name &&
          other.spec == this.spec);
}

class EquipmentCompanion extends UpdateCompanion<EquipmentData> {
  final Value<String> id;
  final Value<String> bandId;
  final Value<String> name;
  final Value<String?> spec;
  final Value<int> rowid;
  const EquipmentCompanion({
    this.id = const Value.absent(),
    this.bandId = const Value.absent(),
    this.name = const Value.absent(),
    this.spec = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EquipmentCompanion.insert({
    required String id,
    required String bandId,
    required String name,
    this.spec = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        bandId = Value(bandId),
        name = Value(name);
  static Insertable<EquipmentData> custom({
    Expression<String>? id,
    Expression<String>? bandId,
    Expression<String>? name,
    Expression<String>? spec,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bandId != null) 'band_id': bandId,
      if (name != null) 'name': name,
      if (spec != null) 'spec': spec,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EquipmentCompanion copyWith(
      {Value<String>? id,
      Value<String>? bandId,
      Value<String>? name,
      Value<String?>? spec,
      Value<int>? rowid}) {
    return EquipmentCompanion(
      id: id ?? this.id,
      bandId: bandId ?? this.bandId,
      name: name ?? this.name,
      spec: spec ?? this.spec,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bandId.present) {
      map['band_id'] = Variable<String>(bandId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (spec.present) {
      map['spec'] = Variable<String>(spec.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentCompanion(')
          ..write('id: $id, ')
          ..write('bandId: $bandId, ')
          ..write('name: $name, ')
          ..write('spec: $spec, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
      'color_hex', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, label, colorHex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<Tag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_hex']),
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final String id;
  final String label;
  final String? colorHex;
  const Tag({required this.id, required this.label, this.colorHex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['label'] = Variable<String>(label);
    if (!nullToAbsent || colorHex != null) {
      map['color_hex'] = Variable<String>(colorHex);
    }
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      label: Value(label),
      colorHex: colorHex == null && nullToAbsent
          ? const Value.absent()
          : Value(colorHex),
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<String>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      colorHex: serializer.fromJson<String?>(json['colorHex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'label': serializer.toJson<String>(label),
      'colorHex': serializer.toJson<String?>(colorHex),
    };
  }

  Tag copyWith(
          {String? id,
          String? label,
          Value<String?> colorHex = const Value.absent()}) =>
      Tag(
        id: id ?? this.id,
        label: label ?? this.label,
        colorHex: colorHex.present ? colorHex.value : this.colorHex,
      );
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('colorHex: $colorHex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, label, colorHex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.label == this.label &&
          other.colorHex == this.colorHex);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<String> id;
  final Value<String> label;
  final Value<String?> colorHex;
  final Value<int> rowid;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagsCompanion.insert({
    required String id,
    required String label,
    this.colorHex = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        label = Value(label);
  static Insertable<Tag> custom({
    Expression<String>? id,
    Expression<String>? label,
    Expression<String>? colorHex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (colorHex != null) 'color_hex': colorHex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagsCompanion copyWith(
      {Value<String>? id,
      Value<String>? label,
      Value<String?>? colorHex,
      Value<int>? rowid}) {
    return TagsCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      colorHex: colorHex ?? this.colorHex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('colorHex: $colorHex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TaggingsTable extends Taggings with TableInfo<$TaggingsTable, Tagging> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaggingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, tagId, entityType, entityId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'taggings';
  @override
  VerificationContext validateIntegrity(Insertable<Tagging> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tagging map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tagging(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag_id'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
    );
  }

  @override
  $TaggingsTable createAlias(String alias) {
    return $TaggingsTable(attachedDatabase, alias);
  }
}

class Tagging extends DataClass implements Insertable<Tagging> {
  final String id;
  final String tagId;
  final String entityType;
  final String entityId;
  const Tagging(
      {required this.id,
      required this.tagId,
      required this.entityType,
      required this.entityId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tag_id'] = Variable<String>(tagId);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    return map;
  }

  TaggingsCompanion toCompanion(bool nullToAbsent) {
    return TaggingsCompanion(
      id: Value(id),
      tagId: Value(tagId),
      entityType: Value(entityType),
      entityId: Value(entityId),
    );
  }

  factory Tagging.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tagging(
      id: serializer.fromJson<String>(json['id']),
      tagId: serializer.fromJson<String>(json['tagId']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tagId': serializer.toJson<String>(tagId),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
    };
  }

  Tagging copyWith(
          {String? id, String? tagId, String? entityType, String? entityId}) =>
      Tagging(
        id: id ?? this.id,
        tagId: tagId ?? this.tagId,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
      );
  Tagging copyWithCompanion(TaggingsCompanion data) {
    return Tagging(
      id: data.id.present ? data.id.value : this.id,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tagging(')
          ..write('id: $id, ')
          ..write('tagId: $tagId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tagId, entityType, entityId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tagging &&
          other.id == this.id &&
          other.tagId == this.tagId &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId);
}

class TaggingsCompanion extends UpdateCompanion<Tagging> {
  final Value<String> id;
  final Value<String> tagId;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<int> rowid;
  const TaggingsCompanion({
    this.id = const Value.absent(),
    this.tagId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaggingsCompanion.insert({
    required String id,
    required String tagId,
    required String entityType,
    required String entityId,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tagId = Value(tagId),
        entityType = Value(entityType),
        entityId = Value(entityId);
  static Insertable<Tagging> custom({
    Expression<String>? id,
    Expression<String>? tagId,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tagId != null) 'tag_id': tagId,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaggingsCompanion copyWith(
      {Value<String>? id,
      Value<String>? tagId,
      Value<String>? entityType,
      Value<String>? entityId,
      Value<int>? rowid}) {
    return TaggingsCompanion(
      id: id ?? this.id,
      tagId: tagId ?? this.tagId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaggingsCompanion(')
          ..write('id: $id, ')
          ..write('tagId: $tagId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BandsTable bands = $BandsTable(this);
  late final $MembersTable members = $MembersTable(this);
  late final $SongsTable songs = $SongsTable(this);
  late final $SetlistsTable setlists = $SetlistsTable(this);
  late final $SetlistSongsTable setlistSongs = $SetlistSongsTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $EquipmentTable equipment = $EquipmentTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $TaggingsTable taggings = $TaggingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        bands,
        members,
        songs,
        setlists,
        setlistSongs,
        events,
        equipment,
        tags,
        taggings
      ];
}

typedef $$BandsTableCreateCompanionBuilder = BandsCompanion Function({
  required String id,
  required String name,
  required String ownerMemberId,
  required String createdAt,
  Value<int> rowid,
});
typedef $$BandsTableUpdateCompanionBuilder = BandsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> ownerMemberId,
  Value<String> createdAt,
  Value<int> rowid,
});

class $$BandsTableFilterComposer extends Composer<_$AppDatabase, $BandsTable> {
  $$BandsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ownerMemberId => $composableBuilder(
      column: $table.ownerMemberId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$BandsTableOrderingComposer
    extends Composer<_$AppDatabase, $BandsTable> {
  $$BandsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ownerMemberId => $composableBuilder(
      column: $table.ownerMemberId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$BandsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BandsTable> {
  $$BandsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get ownerMemberId => $composableBuilder(
      column: $table.ownerMemberId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BandsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BandsTable,
    BandRow,
    $$BandsTableFilterComposer,
    $$BandsTableOrderingComposer,
    $$BandsTableAnnotationComposer,
    $$BandsTableCreateCompanionBuilder,
    $$BandsTableUpdateCompanionBuilder,
    (BandRow, BaseReferences<_$AppDatabase, $BandsTable, BandRow>),
    BandRow,
    PrefetchHooks Function()> {
  $$BandsTableTableManager(_$AppDatabase db, $BandsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BandsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BandsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BandsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> ownerMemberId = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BandsCompanion(
            id: id,
            name: name,
            ownerMemberId: ownerMemberId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String ownerMemberId,
            required String createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              BandsCompanion.insert(
            id: id,
            name: name,
            ownerMemberId: ownerMemberId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BandsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BandsTable,
    BandRow,
    $$BandsTableFilterComposer,
    $$BandsTableOrderingComposer,
    $$BandsTableAnnotationComposer,
    $$BandsTableCreateCompanionBuilder,
    $$BandsTableUpdateCompanionBuilder,
    (BandRow, BaseReferences<_$AppDatabase, $BandsTable, BandRow>),
    BandRow,
    PrefetchHooks Function()>;
typedef $$MembersTableCreateCompanionBuilder = MembersCompanion Function({
  required String id,
  required String bandId,
  required String name,
  required String email,
  Value<String> rolesJson,
  required String createdAt,
  Value<int> rowid,
});
typedef $$MembersTableUpdateCompanionBuilder = MembersCompanion Function({
  Value<String> id,
  Value<String> bandId,
  Value<String> name,
  Value<String> email,
  Value<String> rolesJson,
  Value<String> createdAt,
  Value<int> rowid,
});

class $$MembersTableFilterComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bandId => $composableBuilder(
      column: $table.bandId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rolesJson => $composableBuilder(
      column: $table.rolesJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$MembersTableOrderingComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bandId => $composableBuilder(
      column: $table.bandId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rolesJson => $composableBuilder(
      column: $table.rolesJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$MembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bandId =>
      $composableBuilder(column: $table.bandId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get rolesJson =>
      $composableBuilder(column: $table.rolesJson, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MembersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MembersTable,
    MemberRow,
    $$MembersTableFilterComposer,
    $$MembersTableOrderingComposer,
    $$MembersTableAnnotationComposer,
    $$MembersTableCreateCompanionBuilder,
    $$MembersTableUpdateCompanionBuilder,
    (MemberRow, BaseReferences<_$AppDatabase, $MembersTable, MemberRow>),
    MemberRow,
    PrefetchHooks Function()> {
  $$MembersTableTableManager(_$AppDatabase db, $MembersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> bandId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> rolesJson = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MembersCompanion(
            id: id,
            bandId: bandId,
            name: name,
            email: email,
            rolesJson: rolesJson,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String bandId,
            required String name,
            required String email,
            Value<String> rolesJson = const Value.absent(),
            required String createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              MembersCompanion.insert(
            id: id,
            bandId: bandId,
            name: name,
            email: email,
            rolesJson: rolesJson,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MembersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MembersTable,
    MemberRow,
    $$MembersTableFilterComposer,
    $$MembersTableOrderingComposer,
    $$MembersTableAnnotationComposer,
    $$MembersTableCreateCompanionBuilder,
    $$MembersTableUpdateCompanionBuilder,
    (MemberRow, BaseReferences<_$AppDatabase, $MembersTable, MemberRow>),
    MemberRow,
    PrefetchHooks Function()>;
typedef $$SongsTableCreateCompanionBuilder = SongsCompanion Function({
  required String id,
  required String bandId,
  required String title,
  Value<String?> artist,
  Value<String?> album,
  Value<String?> key,
  Value<int?> tempo,
  Value<String> externalJson,
  Value<int> rowid,
});
typedef $$SongsTableUpdateCompanionBuilder = SongsCompanion Function({
  Value<String> id,
  Value<String> bandId,
  Value<String> title,
  Value<String?> artist,
  Value<String?> album,
  Value<String?> key,
  Value<int?> tempo,
  Value<String> externalJson,
  Value<int> rowid,
});

class $$SongsTableFilterComposer extends Composer<_$AppDatabase, $SongsTable> {
  $$SongsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bandId => $composableBuilder(
      column: $table.bandId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get artist => $composableBuilder(
      column: $table.artist, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get album => $composableBuilder(
      column: $table.album, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tempo => $composableBuilder(
      column: $table.tempo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get externalJson => $composableBuilder(
      column: $table.externalJson, builder: (column) => ColumnFilters(column));
}

class $$SongsTableOrderingComposer
    extends Composer<_$AppDatabase, $SongsTable> {
  $$SongsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bandId => $composableBuilder(
      column: $table.bandId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get artist => $composableBuilder(
      column: $table.artist, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get album => $composableBuilder(
      column: $table.album, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tempo => $composableBuilder(
      column: $table.tempo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get externalJson => $composableBuilder(
      column: $table.externalJson,
      builder: (column) => ColumnOrderings(column));
}

class $$SongsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SongsTable> {
  $$SongsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bandId =>
      $composableBuilder(column: $table.bandId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get artist =>
      $composableBuilder(column: $table.artist, builder: (column) => column);

  GeneratedColumn<String> get album =>
      $composableBuilder(column: $table.album, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<int> get tempo =>
      $composableBuilder(column: $table.tempo, builder: (column) => column);

  GeneratedColumn<String> get externalJson => $composableBuilder(
      column: $table.externalJson, builder: (column) => column);
}

class $$SongsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SongsTable,
    SongRow,
    $$SongsTableFilterComposer,
    $$SongsTableOrderingComposer,
    $$SongsTableAnnotationComposer,
    $$SongsTableCreateCompanionBuilder,
    $$SongsTableUpdateCompanionBuilder,
    (SongRow, BaseReferences<_$AppDatabase, $SongsTable, SongRow>),
    SongRow,
    PrefetchHooks Function()> {
  $$SongsTableTableManager(_$AppDatabase db, $SongsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SongsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SongsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SongsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> bandId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> artist = const Value.absent(),
            Value<String?> album = const Value.absent(),
            Value<String?> key = const Value.absent(),
            Value<int?> tempo = const Value.absent(),
            Value<String> externalJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SongsCompanion(
            id: id,
            bandId: bandId,
            title: title,
            artist: artist,
            album: album,
            key: key,
            tempo: tempo,
            externalJson: externalJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String bandId,
            required String title,
            Value<String?> artist = const Value.absent(),
            Value<String?> album = const Value.absent(),
            Value<String?> key = const Value.absent(),
            Value<int?> tempo = const Value.absent(),
            Value<String> externalJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SongsCompanion.insert(
            id: id,
            bandId: bandId,
            title: title,
            artist: artist,
            album: album,
            key: key,
            tempo: tempo,
            externalJson: externalJson,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SongsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SongsTable,
    SongRow,
    $$SongsTableFilterComposer,
    $$SongsTableOrderingComposer,
    $$SongsTableAnnotationComposer,
    $$SongsTableCreateCompanionBuilder,
    $$SongsTableUpdateCompanionBuilder,
    (SongRow, BaseReferences<_$AppDatabase, $SongsTable, SongRow>),
    SongRow,
    PrefetchHooks Function()>;
typedef $$SetlistsTableCreateCompanionBuilder = SetlistsCompanion Function({
  required String id,
  required String bandId,
  required String name,
  Value<int> rowid,
});
typedef $$SetlistsTableUpdateCompanionBuilder = SetlistsCompanion Function({
  Value<String> id,
  Value<String> bandId,
  Value<String> name,
  Value<int> rowid,
});

class $$SetlistsTableFilterComposer
    extends Composer<_$AppDatabase, $SetlistsTable> {
  $$SetlistsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bandId => $composableBuilder(
      column: $table.bandId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));
}

class $$SetlistsTableOrderingComposer
    extends Composer<_$AppDatabase, $SetlistsTable> {
  $$SetlistsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bandId => $composableBuilder(
      column: $table.bandId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$SetlistsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SetlistsTable> {
  $$SetlistsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bandId =>
      $composableBuilder(column: $table.bandId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$SetlistsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SetlistsTable,
    Setlist,
    $$SetlistsTableFilterComposer,
    $$SetlistsTableOrderingComposer,
    $$SetlistsTableAnnotationComposer,
    $$SetlistsTableCreateCompanionBuilder,
    $$SetlistsTableUpdateCompanionBuilder,
    (Setlist, BaseReferences<_$AppDatabase, $SetlistsTable, Setlist>),
    Setlist,
    PrefetchHooks Function()> {
  $$SetlistsTableTableManager(_$AppDatabase db, $SetlistsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SetlistsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SetlistsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SetlistsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> bandId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SetlistsCompanion(
            id: id,
            bandId: bandId,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String bandId,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              SetlistsCompanion.insert(
            id: id,
            bandId: bandId,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SetlistsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SetlistsTable,
    Setlist,
    $$SetlistsTableFilterComposer,
    $$SetlistsTableOrderingComposer,
    $$SetlistsTableAnnotationComposer,
    $$SetlistsTableCreateCompanionBuilder,
    $$SetlistsTableUpdateCompanionBuilder,
    (Setlist, BaseReferences<_$AppDatabase, $SetlistsTable, Setlist>),
    Setlist,
    PrefetchHooks Function()>;
typedef $$SetlistSongsTableCreateCompanionBuilder = SetlistSongsCompanion
    Function({
  required String id,
  required String setlistId,
  required String songId,
  required int position,
  Value<int> rowid,
});
typedef $$SetlistSongsTableUpdateCompanionBuilder = SetlistSongsCompanion
    Function({
  Value<String> id,
  Value<String> setlistId,
  Value<String> songId,
  Value<int> position,
  Value<int> rowid,
});

class $$SetlistSongsTableFilterComposer
    extends Composer<_$AppDatabase, $SetlistSongsTable> {
  $$SetlistSongsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get setlistId => $composableBuilder(
      column: $table.setlistId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get songId => $composableBuilder(
      column: $table.songId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));
}

class $$SetlistSongsTableOrderingComposer
    extends Composer<_$AppDatabase, $SetlistSongsTable> {
  $$SetlistSongsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get setlistId => $composableBuilder(
      column: $table.setlistId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get songId => $composableBuilder(
      column: $table.songId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));
}

class $$SetlistSongsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SetlistSongsTable> {
  $$SetlistSongsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get setlistId =>
      $composableBuilder(column: $table.setlistId, builder: (column) => column);

  GeneratedColumn<String> get songId =>
      $composableBuilder(column: $table.songId, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);
}

class $$SetlistSongsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SetlistSongsTable,
    SetlistSong,
    $$SetlistSongsTableFilterComposer,
    $$SetlistSongsTableOrderingComposer,
    $$SetlistSongsTableAnnotationComposer,
    $$SetlistSongsTableCreateCompanionBuilder,
    $$SetlistSongsTableUpdateCompanionBuilder,
    (
      SetlistSong,
      BaseReferences<_$AppDatabase, $SetlistSongsTable, SetlistSong>
    ),
    SetlistSong,
    PrefetchHooks Function()> {
  $$SetlistSongsTableTableManager(_$AppDatabase db, $SetlistSongsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SetlistSongsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SetlistSongsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SetlistSongsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> setlistId = const Value.absent(),
            Value<String> songId = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SetlistSongsCompanion(
            id: id,
            setlistId: setlistId,
            songId: songId,
            position: position,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String setlistId,
            required String songId,
            required int position,
            Value<int> rowid = const Value.absent(),
          }) =>
              SetlistSongsCompanion.insert(
            id: id,
            setlistId: setlistId,
            songId: songId,
            position: position,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SetlistSongsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SetlistSongsTable,
    SetlistSong,
    $$SetlistSongsTableFilterComposer,
    $$SetlistSongsTableOrderingComposer,
    $$SetlistSongsTableAnnotationComposer,
    $$SetlistSongsTableCreateCompanionBuilder,
    $$SetlistSongsTableUpdateCompanionBuilder,
    (
      SetlistSong,
      BaseReferences<_$AppDatabase, $SetlistSongsTable, SetlistSong>
    ),
    SetlistSong,
    PrefetchHooks Function()>;
typedef $$EventsTableCreateCompanionBuilder = EventsCompanion Function({
  required String id,
  required String bandId,
  required String name,
  required String dateIso,
  Value<String?> location,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$EventsTableUpdateCompanionBuilder = EventsCompanion Function({
  Value<String> id,
  Value<String> bandId,
  Value<String> name,
  Value<String> dateIso,
  Value<String?> location,
  Value<String?> notes,
  Value<int> rowid,
});

class $$EventsTableFilterComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bandId => $composableBuilder(
      column: $table.bandId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dateIso => $composableBuilder(
      column: $table.dateIso, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));
}

class $$EventsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bandId => $composableBuilder(
      column: $table.bandId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dateIso => $composableBuilder(
      column: $table.dateIso, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$EventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bandId =>
      $composableBuilder(column: $table.bandId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get dateIso =>
      $composableBuilder(column: $table.dateIso, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$EventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EventsTable,
    Event,
    $$EventsTableFilterComposer,
    $$EventsTableOrderingComposer,
    $$EventsTableAnnotationComposer,
    $$EventsTableCreateCompanionBuilder,
    $$EventsTableUpdateCompanionBuilder,
    (Event, BaseReferences<_$AppDatabase, $EventsTable, Event>),
    Event,
    PrefetchHooks Function()> {
  $$EventsTableTableManager(_$AppDatabase db, $EventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> bandId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> dateIso = const Value.absent(),
            Value<String?> location = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EventsCompanion(
            id: id,
            bandId: bandId,
            name: name,
            dateIso: dateIso,
            location: location,
            notes: notes,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String bandId,
            required String name,
            required String dateIso,
            Value<String?> location = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EventsCompanion.insert(
            id: id,
            bandId: bandId,
            name: name,
            dateIso: dateIso,
            location: location,
            notes: notes,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EventsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EventsTable,
    Event,
    $$EventsTableFilterComposer,
    $$EventsTableOrderingComposer,
    $$EventsTableAnnotationComposer,
    $$EventsTableCreateCompanionBuilder,
    $$EventsTableUpdateCompanionBuilder,
    (Event, BaseReferences<_$AppDatabase, $EventsTable, Event>),
    Event,
    PrefetchHooks Function()>;
typedef $$EquipmentTableCreateCompanionBuilder = EquipmentCompanion Function({
  required String id,
  required String bandId,
  required String name,
  Value<String?> spec,
  Value<int> rowid,
});
typedef $$EquipmentTableUpdateCompanionBuilder = EquipmentCompanion Function({
  Value<String> id,
  Value<String> bandId,
  Value<String> name,
  Value<String?> spec,
  Value<int> rowid,
});

class $$EquipmentTableFilterComposer
    extends Composer<_$AppDatabase, $EquipmentTable> {
  $$EquipmentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bandId => $composableBuilder(
      column: $table.bandId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get spec => $composableBuilder(
      column: $table.spec, builder: (column) => ColumnFilters(column));
}

class $$EquipmentTableOrderingComposer
    extends Composer<_$AppDatabase, $EquipmentTable> {
  $$EquipmentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bandId => $composableBuilder(
      column: $table.bandId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get spec => $composableBuilder(
      column: $table.spec, builder: (column) => ColumnOrderings(column));
}

class $$EquipmentTableAnnotationComposer
    extends Composer<_$AppDatabase, $EquipmentTable> {
  $$EquipmentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bandId =>
      $composableBuilder(column: $table.bandId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get spec =>
      $composableBuilder(column: $table.spec, builder: (column) => column);
}

class $$EquipmentTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EquipmentTable,
    EquipmentData,
    $$EquipmentTableFilterComposer,
    $$EquipmentTableOrderingComposer,
    $$EquipmentTableAnnotationComposer,
    $$EquipmentTableCreateCompanionBuilder,
    $$EquipmentTableUpdateCompanionBuilder,
    (
      EquipmentData,
      BaseReferences<_$AppDatabase, $EquipmentTable, EquipmentData>
    ),
    EquipmentData,
    PrefetchHooks Function()> {
  $$EquipmentTableTableManager(_$AppDatabase db, $EquipmentTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EquipmentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EquipmentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EquipmentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> bandId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> spec = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EquipmentCompanion(
            id: id,
            bandId: bandId,
            name: name,
            spec: spec,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String bandId,
            required String name,
            Value<String?> spec = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EquipmentCompanion.insert(
            id: id,
            bandId: bandId,
            name: name,
            spec: spec,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EquipmentTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EquipmentTable,
    EquipmentData,
    $$EquipmentTableFilterComposer,
    $$EquipmentTableOrderingComposer,
    $$EquipmentTableAnnotationComposer,
    $$EquipmentTableCreateCompanionBuilder,
    $$EquipmentTableUpdateCompanionBuilder,
    (
      EquipmentData,
      BaseReferences<_$AppDatabase, $EquipmentTable, EquipmentData>
    ),
    EquipmentData,
    PrefetchHooks Function()>;
typedef $$TagsTableCreateCompanionBuilder = TagsCompanion Function({
  required String id,
  required String label,
  Value<String?> colorHex,
  Value<int> rowid,
});
typedef $$TagsTableUpdateCompanionBuilder = TagsCompanion Function({
  Value<String> id,
  Value<String> label,
  Value<String?> colorHex,
  Value<int> rowid,
});

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnFilters(column));
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnOrderings(column));
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);
}

class $$TagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TagsTable,
    Tag,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableAnnotationComposer,
    $$TagsTableCreateCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder,
    (Tag, BaseReferences<_$AppDatabase, $TagsTable, Tag>),
    Tag,
    PrefetchHooks Function()> {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<String?> colorHex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TagsCompanion(
            id: id,
            label: label,
            colorHex: colorHex,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String label,
            Value<String?> colorHex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TagsCompanion.insert(
            id: id,
            label: label,
            colorHex: colorHex,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TagsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TagsTable,
    Tag,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableAnnotationComposer,
    $$TagsTableCreateCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder,
    (Tag, BaseReferences<_$AppDatabase, $TagsTable, Tag>),
    Tag,
    PrefetchHooks Function()>;
typedef $$TaggingsTableCreateCompanionBuilder = TaggingsCompanion Function({
  required String id,
  required String tagId,
  required String entityType,
  required String entityId,
  Value<int> rowid,
});
typedef $$TaggingsTableUpdateCompanionBuilder = TaggingsCompanion Function({
  Value<String> id,
  Value<String> tagId,
  Value<String> entityType,
  Value<String> entityId,
  Value<int> rowid,
});

class $$TaggingsTableFilterComposer
    extends Composer<_$AppDatabase, $TaggingsTable> {
  $$TaggingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tagId => $composableBuilder(
      column: $table.tagId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));
}

class $$TaggingsTableOrderingComposer
    extends Composer<_$AppDatabase, $TaggingsTable> {
  $$TaggingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tagId => $composableBuilder(
      column: $table.tagId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));
}

class $$TaggingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaggingsTable> {
  $$TaggingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tagId =>
      $composableBuilder(column: $table.tagId, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);
}

class $$TaggingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TaggingsTable,
    Tagging,
    $$TaggingsTableFilterComposer,
    $$TaggingsTableOrderingComposer,
    $$TaggingsTableAnnotationComposer,
    $$TaggingsTableCreateCompanionBuilder,
    $$TaggingsTableUpdateCompanionBuilder,
    (Tagging, BaseReferences<_$AppDatabase, $TaggingsTable, Tagging>),
    Tagging,
    PrefetchHooks Function()> {
  $$TaggingsTableTableManager(_$AppDatabase db, $TaggingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaggingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaggingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaggingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tagId = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaggingsCompanion(
            id: id,
            tagId: tagId,
            entityType: entityType,
            entityId: entityId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tagId,
            required String entityType,
            required String entityId,
            Value<int> rowid = const Value.absent(),
          }) =>
              TaggingsCompanion.insert(
            id: id,
            tagId: tagId,
            entityType: entityType,
            entityId: entityId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TaggingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TaggingsTable,
    Tagging,
    $$TaggingsTableFilterComposer,
    $$TaggingsTableOrderingComposer,
    $$TaggingsTableAnnotationComposer,
    $$TaggingsTableCreateCompanionBuilder,
    $$TaggingsTableUpdateCompanionBuilder,
    (Tagging, BaseReferences<_$AppDatabase, $TaggingsTable, Tagging>),
    Tagging,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BandsTableTableManager get bands =>
      $$BandsTableTableManager(_db, _db.bands);
  $$MembersTableTableManager get members =>
      $$MembersTableTableManager(_db, _db.members);
  $$SongsTableTableManager get songs =>
      $$SongsTableTableManager(_db, _db.songs);
  $$SetlistsTableTableManager get setlists =>
      $$SetlistsTableTableManager(_db, _db.setlists);
  $$SetlistSongsTableTableManager get setlistSongs =>
      $$SetlistSongsTableTableManager(_db, _db.setlistSongs);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$EquipmentTableTableManager get equipment =>
      $$EquipmentTableTableManager(_db, _db.equipment);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$TaggingsTableTableManager get taggings =>
      $$TaggingsTableTableManager(_db, _db.taggings);
}
