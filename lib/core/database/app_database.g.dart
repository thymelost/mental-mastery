// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserStateTableTable extends UserStateTable
    with TableInfo<$UserStateTableTable, UserStateTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserStateTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _onboardingCompleteMeta =
      const VerificationMeta('onboardingComplete');
  @override
  late final GeneratedColumn<bool> onboardingComplete = GeneratedColumn<bool>(
      'onboarding_complete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("onboarding_complete" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _currentPhaseMeta =
      const VerificationMeta('currentPhase');
  @override
  late final GeneratedColumn<int> currentPhase = GeneratedColumn<int>(
      'current_phase', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _trackEmotionalLiteracyMeta =
      const VerificationMeta('trackEmotionalLiteracy');
  @override
  late final GeneratedColumn<String> trackEmotionalLiteracy =
      GeneratedColumn<String>('track_emotional_literacy', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _trackSomaticMeta =
      const VerificationMeta('trackSomatic');
  @override
  late final GeneratedColumn<String> trackSomatic = GeneratedColumn<String>(
      'track_somatic', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _trackVocabularyMeta =
      const VerificationMeta('trackVocabulary');
  @override
  late final GeneratedColumn<String> trackVocabulary = GeneratedColumn<String>(
      'track_vocabulary', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tas20ScoreMeta =
      const VerificationMeta('tas20Score');
  @override
  late final GeneratedColumn<int> tas20Score = GeneratedColumn<int>(
      'tas20_score', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _valuesDocumentMeta =
      const VerificationMeta('valuesDocument');
  @override
  late final GeneratedColumn<String> valuesDocument = GeneratedColumn<String>(
      'values_document', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _selfDescriptionMeta =
      const VerificationMeta('selfDescription');
  @override
  late final GeneratedColumn<String> selfDescription = GeneratedColumn<String>(
      'self_description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statsOptInMeta =
      const VerificationMeta('statsOptIn');
  @override
  late final GeneratedColumn<bool> statsOptIn = GeneratedColumn<bool>(
      'stats_opt_in', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("stats_opt_in" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _statsTokenMeta =
      const VerificationMeta('statsToken');
  @override
  late final GeneratedColumn<String> statsToken = GeneratedColumn<String>(
      'stats_token', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        onboardingComplete,
        currentPhase,
        trackEmotionalLiteracy,
        trackSomatic,
        trackVocabulary,
        tas20Score,
        valuesDocument,
        selfDescription,
        statsOptIn,
        statsToken,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_state';
  @override
  VerificationContext validateIntegrity(Insertable<UserStateTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('onboarding_complete')) {
      context.handle(
          _onboardingCompleteMeta,
          onboardingComplete.isAcceptableOrUnknown(
              data['onboarding_complete']!, _onboardingCompleteMeta));
    }
    if (data.containsKey('current_phase')) {
      context.handle(
          _currentPhaseMeta,
          currentPhase.isAcceptableOrUnknown(
              data['current_phase']!, _currentPhaseMeta));
    }
    if (data.containsKey('track_emotional_literacy')) {
      context.handle(
          _trackEmotionalLiteracyMeta,
          trackEmotionalLiteracy.isAcceptableOrUnknown(
              data['track_emotional_literacy']!, _trackEmotionalLiteracyMeta));
    }
    if (data.containsKey('track_somatic')) {
      context.handle(
          _trackSomaticMeta,
          trackSomatic.isAcceptableOrUnknown(
              data['track_somatic']!, _trackSomaticMeta));
    }
    if (data.containsKey('track_vocabulary')) {
      context.handle(
          _trackVocabularyMeta,
          trackVocabulary.isAcceptableOrUnknown(
              data['track_vocabulary']!, _trackVocabularyMeta));
    }
    if (data.containsKey('tas20_score')) {
      context.handle(
          _tas20ScoreMeta,
          tas20Score.isAcceptableOrUnknown(
              data['tas20_score']!, _tas20ScoreMeta));
    }
    if (data.containsKey('values_document')) {
      context.handle(
          _valuesDocumentMeta,
          valuesDocument.isAcceptableOrUnknown(
              data['values_document']!, _valuesDocumentMeta));
    }
    if (data.containsKey('self_description')) {
      context.handle(
          _selfDescriptionMeta,
          selfDescription.isAcceptableOrUnknown(
              data['self_description']!, _selfDescriptionMeta));
    }
    if (data.containsKey('stats_opt_in')) {
      context.handle(
          _statsOptInMeta,
          statsOptIn.isAcceptableOrUnknown(
              data['stats_opt_in']!, _statsOptInMeta));
    }
    if (data.containsKey('stats_token')) {
      context.handle(
          _statsTokenMeta,
          statsToken.isAcceptableOrUnknown(
              data['stats_token']!, _statsTokenMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserStateTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserStateTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      onboardingComplete: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}onboarding_complete'])!,
      currentPhase: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_phase'])!,
      trackEmotionalLiteracy: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}track_emotional_literacy']),
      trackSomatic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}track_somatic']),
      trackVocabulary: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}track_vocabulary']),
      tas20Score: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tas20_score']),
      valuesDocument: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}values_document']),
      selfDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}self_description']),
      statsOptIn: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}stats_opt_in'])!,
      statsToken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stats_token']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UserStateTableTable createAlias(String alias) {
    return $UserStateTableTable(attachedDatabase, alias);
  }
}

class UserStateTableData extends DataClass
    implements Insertable<UserStateTableData> {
  final int id;
  final bool onboardingComplete;
  final int currentPhase;
  final String? trackEmotionalLiteracy;
  final String? trackSomatic;
  final String? trackVocabulary;
  final int? tas20Score;
  final String? valuesDocument;
  final String? selfDescription;
  final bool statsOptIn;
  final String? statsToken;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserStateTableData(
      {required this.id,
      required this.onboardingComplete,
      required this.currentPhase,
      this.trackEmotionalLiteracy,
      this.trackSomatic,
      this.trackVocabulary,
      this.tas20Score,
      this.valuesDocument,
      this.selfDescription,
      required this.statsOptIn,
      this.statsToken,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['onboarding_complete'] = Variable<bool>(onboardingComplete);
    map['current_phase'] = Variable<int>(currentPhase);
    if (!nullToAbsent || trackEmotionalLiteracy != null) {
      map['track_emotional_literacy'] =
          Variable<String>(trackEmotionalLiteracy);
    }
    if (!nullToAbsent || trackSomatic != null) {
      map['track_somatic'] = Variable<String>(trackSomatic);
    }
    if (!nullToAbsent || trackVocabulary != null) {
      map['track_vocabulary'] = Variable<String>(trackVocabulary);
    }
    if (!nullToAbsent || tas20Score != null) {
      map['tas20_score'] = Variable<int>(tas20Score);
    }
    if (!nullToAbsent || valuesDocument != null) {
      map['values_document'] = Variable<String>(valuesDocument);
    }
    if (!nullToAbsent || selfDescription != null) {
      map['self_description'] = Variable<String>(selfDescription);
    }
    map['stats_opt_in'] = Variable<bool>(statsOptIn);
    if (!nullToAbsent || statsToken != null) {
      map['stats_token'] = Variable<String>(statsToken);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserStateTableCompanion toCompanion(bool nullToAbsent) {
    return UserStateTableCompanion(
      id: Value(id),
      onboardingComplete: Value(onboardingComplete),
      currentPhase: Value(currentPhase),
      trackEmotionalLiteracy: trackEmotionalLiteracy == null && nullToAbsent
          ? const Value.absent()
          : Value(trackEmotionalLiteracy),
      trackSomatic: trackSomatic == null && nullToAbsent
          ? const Value.absent()
          : Value(trackSomatic),
      trackVocabulary: trackVocabulary == null && nullToAbsent
          ? const Value.absent()
          : Value(trackVocabulary),
      tas20Score: tas20Score == null && nullToAbsent
          ? const Value.absent()
          : Value(tas20Score),
      valuesDocument: valuesDocument == null && nullToAbsent
          ? const Value.absent()
          : Value(valuesDocument),
      selfDescription: selfDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(selfDescription),
      statsOptIn: Value(statsOptIn),
      statsToken: statsToken == null && nullToAbsent
          ? const Value.absent()
          : Value(statsToken),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserStateTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserStateTableData(
      id: serializer.fromJson<int>(json['id']),
      onboardingComplete: serializer.fromJson<bool>(json['onboardingComplete']),
      currentPhase: serializer.fromJson<int>(json['currentPhase']),
      trackEmotionalLiteracy:
          serializer.fromJson<String?>(json['trackEmotionalLiteracy']),
      trackSomatic: serializer.fromJson<String?>(json['trackSomatic']),
      trackVocabulary: serializer.fromJson<String?>(json['trackVocabulary']),
      tas20Score: serializer.fromJson<int?>(json['tas20Score']),
      valuesDocument: serializer.fromJson<String?>(json['valuesDocument']),
      selfDescription: serializer.fromJson<String?>(json['selfDescription']),
      statsOptIn: serializer.fromJson<bool>(json['statsOptIn']),
      statsToken: serializer.fromJson<String?>(json['statsToken']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'onboardingComplete': serializer.toJson<bool>(onboardingComplete),
      'currentPhase': serializer.toJson<int>(currentPhase),
      'trackEmotionalLiteracy':
          serializer.toJson<String?>(trackEmotionalLiteracy),
      'trackSomatic': serializer.toJson<String?>(trackSomatic),
      'trackVocabulary': serializer.toJson<String?>(trackVocabulary),
      'tas20Score': serializer.toJson<int?>(tas20Score),
      'valuesDocument': serializer.toJson<String?>(valuesDocument),
      'selfDescription': serializer.toJson<String?>(selfDescription),
      'statsOptIn': serializer.toJson<bool>(statsOptIn),
      'statsToken': serializer.toJson<String?>(statsToken),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserStateTableData copyWith(
          {int? id,
          bool? onboardingComplete,
          int? currentPhase,
          Value<String?> trackEmotionalLiteracy = const Value.absent(),
          Value<String?> trackSomatic = const Value.absent(),
          Value<String?> trackVocabulary = const Value.absent(),
          Value<int?> tas20Score = const Value.absent(),
          Value<String?> valuesDocument = const Value.absent(),
          Value<String?> selfDescription = const Value.absent(),
          bool? statsOptIn,
          Value<String?> statsToken = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      UserStateTableData(
        id: id ?? this.id,
        onboardingComplete: onboardingComplete ?? this.onboardingComplete,
        currentPhase: currentPhase ?? this.currentPhase,
        trackEmotionalLiteracy: trackEmotionalLiteracy.present
            ? trackEmotionalLiteracy.value
            : this.trackEmotionalLiteracy,
        trackSomatic:
            trackSomatic.present ? trackSomatic.value : this.trackSomatic,
        trackVocabulary: trackVocabulary.present
            ? trackVocabulary.value
            : this.trackVocabulary,
        tas20Score: tas20Score.present ? tas20Score.value : this.tas20Score,
        valuesDocument:
            valuesDocument.present ? valuesDocument.value : this.valuesDocument,
        selfDescription: selfDescription.present
            ? selfDescription.value
            : this.selfDescription,
        statsOptIn: statsOptIn ?? this.statsOptIn,
        statsToken: statsToken.present ? statsToken.value : this.statsToken,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  UserStateTableData copyWithCompanion(UserStateTableCompanion data) {
    return UserStateTableData(
      id: data.id.present ? data.id.value : this.id,
      onboardingComplete: data.onboardingComplete.present
          ? data.onboardingComplete.value
          : this.onboardingComplete,
      currentPhase: data.currentPhase.present
          ? data.currentPhase.value
          : this.currentPhase,
      trackEmotionalLiteracy: data.trackEmotionalLiteracy.present
          ? data.trackEmotionalLiteracy.value
          : this.trackEmotionalLiteracy,
      trackSomatic: data.trackSomatic.present
          ? data.trackSomatic.value
          : this.trackSomatic,
      trackVocabulary: data.trackVocabulary.present
          ? data.trackVocabulary.value
          : this.trackVocabulary,
      tas20Score:
          data.tas20Score.present ? data.tas20Score.value : this.tas20Score,
      valuesDocument: data.valuesDocument.present
          ? data.valuesDocument.value
          : this.valuesDocument,
      selfDescription: data.selfDescription.present
          ? data.selfDescription.value
          : this.selfDescription,
      statsOptIn:
          data.statsOptIn.present ? data.statsOptIn.value : this.statsOptIn,
      statsToken:
          data.statsToken.present ? data.statsToken.value : this.statsToken,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserStateTableData(')
          ..write('id: $id, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('currentPhase: $currentPhase, ')
          ..write('trackEmotionalLiteracy: $trackEmotionalLiteracy, ')
          ..write('trackSomatic: $trackSomatic, ')
          ..write('trackVocabulary: $trackVocabulary, ')
          ..write('tas20Score: $tas20Score, ')
          ..write('valuesDocument: $valuesDocument, ')
          ..write('selfDescription: $selfDescription, ')
          ..write('statsOptIn: $statsOptIn, ')
          ..write('statsToken: $statsToken, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      onboardingComplete,
      currentPhase,
      trackEmotionalLiteracy,
      trackSomatic,
      trackVocabulary,
      tas20Score,
      valuesDocument,
      selfDescription,
      statsOptIn,
      statsToken,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserStateTableData &&
          other.id == this.id &&
          other.onboardingComplete == this.onboardingComplete &&
          other.currentPhase == this.currentPhase &&
          other.trackEmotionalLiteracy == this.trackEmotionalLiteracy &&
          other.trackSomatic == this.trackSomatic &&
          other.trackVocabulary == this.trackVocabulary &&
          other.tas20Score == this.tas20Score &&
          other.valuesDocument == this.valuesDocument &&
          other.selfDescription == this.selfDescription &&
          other.statsOptIn == this.statsOptIn &&
          other.statsToken == this.statsToken &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserStateTableCompanion extends UpdateCompanion<UserStateTableData> {
  final Value<int> id;
  final Value<bool> onboardingComplete;
  final Value<int> currentPhase;
  final Value<String?> trackEmotionalLiteracy;
  final Value<String?> trackSomatic;
  final Value<String?> trackVocabulary;
  final Value<int?> tas20Score;
  final Value<String?> valuesDocument;
  final Value<String?> selfDescription;
  final Value<bool> statsOptIn;
  final Value<String?> statsToken;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserStateTableCompanion({
    this.id = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.currentPhase = const Value.absent(),
    this.trackEmotionalLiteracy = const Value.absent(),
    this.trackSomatic = const Value.absent(),
    this.trackVocabulary = const Value.absent(),
    this.tas20Score = const Value.absent(),
    this.valuesDocument = const Value.absent(),
    this.selfDescription = const Value.absent(),
    this.statsOptIn = const Value.absent(),
    this.statsToken = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserStateTableCompanion.insert({
    this.id = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.currentPhase = const Value.absent(),
    this.trackEmotionalLiteracy = const Value.absent(),
    this.trackSomatic = const Value.absent(),
    this.trackVocabulary = const Value.absent(),
    this.tas20Score = const Value.absent(),
    this.valuesDocument = const Value.absent(),
    this.selfDescription = const Value.absent(),
    this.statsOptIn = const Value.absent(),
    this.statsToken = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<UserStateTableData> custom({
    Expression<int>? id,
    Expression<bool>? onboardingComplete,
    Expression<int>? currentPhase,
    Expression<String>? trackEmotionalLiteracy,
    Expression<String>? trackSomatic,
    Expression<String>? trackVocabulary,
    Expression<int>? tas20Score,
    Expression<String>? valuesDocument,
    Expression<String>? selfDescription,
    Expression<bool>? statsOptIn,
    Expression<String>? statsToken,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (onboardingComplete != null) 'onboarding_complete': onboardingComplete,
      if (currentPhase != null) 'current_phase': currentPhase,
      if (trackEmotionalLiteracy != null)
        'track_emotional_literacy': trackEmotionalLiteracy,
      if (trackSomatic != null) 'track_somatic': trackSomatic,
      if (trackVocabulary != null) 'track_vocabulary': trackVocabulary,
      if (tas20Score != null) 'tas20_score': tas20Score,
      if (valuesDocument != null) 'values_document': valuesDocument,
      if (selfDescription != null) 'self_description': selfDescription,
      if (statsOptIn != null) 'stats_opt_in': statsOptIn,
      if (statsToken != null) 'stats_token': statsToken,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserStateTableCompanion copyWith(
      {Value<int>? id,
      Value<bool>? onboardingComplete,
      Value<int>? currentPhase,
      Value<String?>? trackEmotionalLiteracy,
      Value<String?>? trackSomatic,
      Value<String?>? trackVocabulary,
      Value<int?>? tas20Score,
      Value<String?>? valuesDocument,
      Value<String?>? selfDescription,
      Value<bool>? statsOptIn,
      Value<String?>? statsToken,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return UserStateTableCompanion(
      id: id ?? this.id,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      currentPhase: currentPhase ?? this.currentPhase,
      trackEmotionalLiteracy:
          trackEmotionalLiteracy ?? this.trackEmotionalLiteracy,
      trackSomatic: trackSomatic ?? this.trackSomatic,
      trackVocabulary: trackVocabulary ?? this.trackVocabulary,
      tas20Score: tas20Score ?? this.tas20Score,
      valuesDocument: valuesDocument ?? this.valuesDocument,
      selfDescription: selfDescription ?? this.selfDescription,
      statsOptIn: statsOptIn ?? this.statsOptIn,
      statsToken: statsToken ?? this.statsToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (onboardingComplete.present) {
      map['onboarding_complete'] = Variable<bool>(onboardingComplete.value);
    }
    if (currentPhase.present) {
      map['current_phase'] = Variable<int>(currentPhase.value);
    }
    if (trackEmotionalLiteracy.present) {
      map['track_emotional_literacy'] =
          Variable<String>(trackEmotionalLiteracy.value);
    }
    if (trackSomatic.present) {
      map['track_somatic'] = Variable<String>(trackSomatic.value);
    }
    if (trackVocabulary.present) {
      map['track_vocabulary'] = Variable<String>(trackVocabulary.value);
    }
    if (tas20Score.present) {
      map['tas20_score'] = Variable<int>(tas20Score.value);
    }
    if (valuesDocument.present) {
      map['values_document'] = Variable<String>(valuesDocument.value);
    }
    if (selfDescription.present) {
      map['self_description'] = Variable<String>(selfDescription.value);
    }
    if (statsOptIn.present) {
      map['stats_opt_in'] = Variable<bool>(statsOptIn.value);
    }
    if (statsToken.present) {
      map['stats_token'] = Variable<String>(statsToken.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserStateTableCompanion(')
          ..write('id: $id, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('currentPhase: $currentPhase, ')
          ..write('trackEmotionalLiteracy: $trackEmotionalLiteracy, ')
          ..write('trackSomatic: $trackSomatic, ')
          ..write('trackVocabulary: $trackVocabulary, ')
          ..write('tas20Score: $tas20Score, ')
          ..write('valuesDocument: $valuesDocument, ')
          ..write('selfDescription: $selfDescription, ')
          ..write('statsOptIn: $statsOptIn, ')
          ..write('statsToken: $statsToken, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PhaseProgressTableTable extends PhaseProgressTable
    with TableInfo<$PhaseProgressTableTable, PhaseProgressTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhaseProgressTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _phaseNumberMeta =
      const VerificationMeta('phaseNumber');
  @override
  late final GeneratedColumn<int> phaseNumber = GeneratedColumn<int>(
      'phase_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _weekNumberMeta =
      const VerificationMeta('weekNumber');
  @override
  late final GeneratedColumn<int> weekNumber = GeneratedColumn<int>(
      'week_number', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _extensionsJsonMeta =
      const VerificationMeta('extensionsJson');
  @override
  late final GeneratedColumn<String> extensionsJson = GeneratedColumn<String>(
      'extensions_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        phaseNumber,
        status,
        startedAt,
        completedAt,
        weekNumber,
        extensionsJson
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'phase_progress';
  @override
  VerificationContext validateIntegrity(
      Insertable<PhaseProgressTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('phase_number')) {
      context.handle(
          _phaseNumberMeta,
          phaseNumber.isAcceptableOrUnknown(
              data['phase_number']!, _phaseNumberMeta));
    } else if (isInserting) {
      context.missing(_phaseNumberMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('week_number')) {
      context.handle(
          _weekNumberMeta,
          weekNumber.isAcceptableOrUnknown(
              data['week_number']!, _weekNumberMeta));
    }
    if (data.containsKey('extensions_json')) {
      context.handle(
          _extensionsJsonMeta,
          extensionsJson.isAcceptableOrUnknown(
              data['extensions_json']!, _extensionsJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PhaseProgressTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhaseProgressTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      phaseNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}phase_number'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
      weekNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}week_number'])!,
      extensionsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}extensions_json']),
    );
  }

  @override
  $PhaseProgressTableTable createAlias(String alias) {
    return $PhaseProgressTableTable(attachedDatabase, alias);
  }
}

class PhaseProgressTableData extends DataClass
    implements Insertable<PhaseProgressTableData> {
  final int id;
  final int phaseNumber;
  final String status;
  final DateTime startedAt;
  final DateTime? completedAt;
  final int weekNumber;
  final String? extensionsJson;
  const PhaseProgressTableData(
      {required this.id,
      required this.phaseNumber,
      required this.status,
      required this.startedAt,
      this.completedAt,
      required this.weekNumber,
      this.extensionsJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['phase_number'] = Variable<int>(phaseNumber);
    map['status'] = Variable<String>(status);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['week_number'] = Variable<int>(weekNumber);
    if (!nullToAbsent || extensionsJson != null) {
      map['extensions_json'] = Variable<String>(extensionsJson);
    }
    return map;
  }

  PhaseProgressTableCompanion toCompanion(bool nullToAbsent) {
    return PhaseProgressTableCompanion(
      id: Value(id),
      phaseNumber: Value(phaseNumber),
      status: Value(status),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      weekNumber: Value(weekNumber),
      extensionsJson: extensionsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(extensionsJson),
    );
  }

  factory PhaseProgressTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhaseProgressTableData(
      id: serializer.fromJson<int>(json['id']),
      phaseNumber: serializer.fromJson<int>(json['phaseNumber']),
      status: serializer.fromJson<String>(json['status']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      weekNumber: serializer.fromJson<int>(json['weekNumber']),
      extensionsJson: serializer.fromJson<String?>(json['extensionsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'phaseNumber': serializer.toJson<int>(phaseNumber),
      'status': serializer.toJson<String>(status),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'weekNumber': serializer.toJson<int>(weekNumber),
      'extensionsJson': serializer.toJson<String?>(extensionsJson),
    };
  }

  PhaseProgressTableData copyWith(
          {int? id,
          int? phaseNumber,
          String? status,
          DateTime? startedAt,
          Value<DateTime?> completedAt = const Value.absent(),
          int? weekNumber,
          Value<String?> extensionsJson = const Value.absent()}) =>
      PhaseProgressTableData(
        id: id ?? this.id,
        phaseNumber: phaseNumber ?? this.phaseNumber,
        status: status ?? this.status,
        startedAt: startedAt ?? this.startedAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        weekNumber: weekNumber ?? this.weekNumber,
        extensionsJson:
            extensionsJson.present ? extensionsJson.value : this.extensionsJson,
      );
  PhaseProgressTableData copyWithCompanion(PhaseProgressTableCompanion data) {
    return PhaseProgressTableData(
      id: data.id.present ? data.id.value : this.id,
      phaseNumber:
          data.phaseNumber.present ? data.phaseNumber.value : this.phaseNumber,
      status: data.status.present ? data.status.value : this.status,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      weekNumber:
          data.weekNumber.present ? data.weekNumber.value : this.weekNumber,
      extensionsJson: data.extensionsJson.present
          ? data.extensionsJson.value
          : this.extensionsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhaseProgressTableData(')
          ..write('id: $id, ')
          ..write('phaseNumber: $phaseNumber, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('weekNumber: $weekNumber, ')
          ..write('extensionsJson: $extensionsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, phaseNumber, status, startedAt,
      completedAt, weekNumber, extensionsJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhaseProgressTableData &&
          other.id == this.id &&
          other.phaseNumber == this.phaseNumber &&
          other.status == this.status &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.weekNumber == this.weekNumber &&
          other.extensionsJson == this.extensionsJson);
}

class PhaseProgressTableCompanion
    extends UpdateCompanion<PhaseProgressTableData> {
  final Value<int> id;
  final Value<int> phaseNumber;
  final Value<String> status;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<int> weekNumber;
  final Value<String?> extensionsJson;
  const PhaseProgressTableCompanion({
    this.id = const Value.absent(),
    this.phaseNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.weekNumber = const Value.absent(),
    this.extensionsJson = const Value.absent(),
  });
  PhaseProgressTableCompanion.insert({
    this.id = const Value.absent(),
    required int phaseNumber,
    this.status = const Value.absent(),
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
    this.weekNumber = const Value.absent(),
    this.extensionsJson = const Value.absent(),
  })  : phaseNumber = Value(phaseNumber),
        startedAt = Value(startedAt);
  static Insertable<PhaseProgressTableData> custom({
    Expression<int>? id,
    Expression<int>? phaseNumber,
    Expression<String>? status,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? weekNumber,
    Expression<String>? extensionsJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phaseNumber != null) 'phase_number': phaseNumber,
      if (status != null) 'status': status,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (weekNumber != null) 'week_number': weekNumber,
      if (extensionsJson != null) 'extensions_json': extensionsJson,
    });
  }

  PhaseProgressTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? phaseNumber,
      Value<String>? status,
      Value<DateTime>? startedAt,
      Value<DateTime?>? completedAt,
      Value<int>? weekNumber,
      Value<String?>? extensionsJson}) {
    return PhaseProgressTableCompanion(
      id: id ?? this.id,
      phaseNumber: phaseNumber ?? this.phaseNumber,
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      weekNumber: weekNumber ?? this.weekNumber,
      extensionsJson: extensionsJson ?? this.extensionsJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (phaseNumber.present) {
      map['phase_number'] = Variable<int>(phaseNumber.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (weekNumber.present) {
      map['week_number'] = Variable<int>(weekNumber.value);
    }
    if (extensionsJson.present) {
      map['extensions_json'] = Variable<String>(extensionsJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhaseProgressTableCompanion(')
          ..write('id: $id, ')
          ..write('phaseNumber: $phaseNumber, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('weekNumber: $weekNumber, ')
          ..write('extensionsJson: $extensionsJson')
          ..write(')'))
        .toString();
  }
}

class $PracticeSessionsTableTable extends PracticeSessionsTable
    with TableInfo<$PracticeSessionsTableTable, PracticeSessionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PracticeSessionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _practiceIdMeta =
      const VerificationMeta('practiceId');
  @override
  late final GeneratedColumn<String> practiceId = GeneratedColumn<String>(
      'practice_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phaseNumberMeta =
      const VerificationMeta('phaseNumber');
  @override
  late final GeneratedColumn<int> phaseNumber = GeneratedColumn<int>(
      'phase_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endedAtMeta =
      const VerificationMeta('endedAt');
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
      'ended_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _durationSecondsMeta =
      const VerificationMeta('durationSeconds');
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
      'duration_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _driftCountMeta =
      const VerificationMeta('driftCount');
  @override
  late final GeneratedColumn<int> driftCount = GeneratedColumn<int>(
      'drift_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _driftTapLogMeta =
      const VerificationMeta('driftTapLog');
  @override
  late final GeneratedColumn<String> driftTapLog = GeneratedColumn<String>(
      'drift_tap_log', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _arousalBeforeMeta =
      const VerificationMeta('arousalBefore');
  @override
  late final GeneratedColumn<double> arousalBefore = GeneratedColumn<double>(
      'arousal_before', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _arousalAfterMeta =
      const VerificationMeta('arousalAfter');
  @override
  late final GeneratedColumn<double> arousalAfter = GeneratedColumn<double>(
      'arousal_after', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _hrBeforeMeta =
      const VerificationMeta('hrBefore');
  @override
  late final GeneratedColumn<double> hrBefore = GeneratedColumn<double>(
      'hr_before', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _hrAfterMeta =
      const VerificationMeta('hrAfter');
  @override
  late final GeneratedColumn<double> hrAfter = GeneratedColumn<double>(
      'hr_after', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _qualityScoreMeta =
      const VerificationMeta('qualityScore');
  @override
  late final GeneratedColumn<double> qualityScore = GeneratedColumn<double>(
      'quality_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _notesTextMeta =
      const VerificationMeta('notesText');
  @override
  late final GeneratedColumn<String> notesText = GeneratedColumn<String>(
      'notes_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _voiceTranscriptMeta =
      const VerificationMeta('voiceTranscript');
  @override
  late final GeneratedColumn<String> voiceTranscript = GeneratedColumn<String>(
      'voice_transcript', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _safetyAcknowledgedMeta =
      const VerificationMeta('safetyAcknowledged');
  @override
  late final GeneratedColumn<bool> safetyAcknowledged = GeneratedColumn<bool>(
      'safety_acknowledged', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("safety_acknowledged" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        practiceId,
        phaseNumber,
        startedAt,
        endedAt,
        durationSeconds,
        driftCount,
        driftTapLog,
        arousalBefore,
        arousalAfter,
        hrBefore,
        hrAfter,
        qualityScore,
        notesText,
        voiceTranscript,
        safetyAcknowledged
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'practice_sessions';
  @override
  VerificationContext validateIntegrity(
      Insertable<PracticeSessionsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('practice_id')) {
      context.handle(
          _practiceIdMeta,
          practiceId.isAcceptableOrUnknown(
              data['practice_id']!, _practiceIdMeta));
    } else if (isInserting) {
      context.missing(_practiceIdMeta);
    }
    if (data.containsKey('phase_number')) {
      context.handle(
          _phaseNumberMeta,
          phaseNumber.isAcceptableOrUnknown(
              data['phase_number']!, _phaseNumberMeta));
    } else if (isInserting) {
      context.missing(_phaseNumberMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(_endedAtMeta,
          endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta));
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
          _durationSecondsMeta,
          durationSeconds.isAcceptableOrUnknown(
              data['duration_seconds']!, _durationSecondsMeta));
    }
    if (data.containsKey('drift_count')) {
      context.handle(
          _driftCountMeta,
          driftCount.isAcceptableOrUnknown(
              data['drift_count']!, _driftCountMeta));
    }
    if (data.containsKey('drift_tap_log')) {
      context.handle(
          _driftTapLogMeta,
          driftTapLog.isAcceptableOrUnknown(
              data['drift_tap_log']!, _driftTapLogMeta));
    }
    if (data.containsKey('arousal_before')) {
      context.handle(
          _arousalBeforeMeta,
          arousalBefore.isAcceptableOrUnknown(
              data['arousal_before']!, _arousalBeforeMeta));
    }
    if (data.containsKey('arousal_after')) {
      context.handle(
          _arousalAfterMeta,
          arousalAfter.isAcceptableOrUnknown(
              data['arousal_after']!, _arousalAfterMeta));
    }
    if (data.containsKey('hr_before')) {
      context.handle(_hrBeforeMeta,
          hrBefore.isAcceptableOrUnknown(data['hr_before']!, _hrBeforeMeta));
    }
    if (data.containsKey('hr_after')) {
      context.handle(_hrAfterMeta,
          hrAfter.isAcceptableOrUnknown(data['hr_after']!, _hrAfterMeta));
    }
    if (data.containsKey('quality_score')) {
      context.handle(
          _qualityScoreMeta,
          qualityScore.isAcceptableOrUnknown(
              data['quality_score']!, _qualityScoreMeta));
    }
    if (data.containsKey('notes_text')) {
      context.handle(_notesTextMeta,
          notesText.isAcceptableOrUnknown(data['notes_text']!, _notesTextMeta));
    }
    if (data.containsKey('voice_transcript')) {
      context.handle(
          _voiceTranscriptMeta,
          voiceTranscript.isAcceptableOrUnknown(
              data['voice_transcript']!, _voiceTranscriptMeta));
    }
    if (data.containsKey('safety_acknowledged')) {
      context.handle(
          _safetyAcknowledgedMeta,
          safetyAcknowledged.isAcceptableOrUnknown(
              data['safety_acknowledged']!, _safetyAcknowledgedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PracticeSessionsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PracticeSessionsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      practiceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}practice_id'])!,
      phaseNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}phase_number'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
      endedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}ended_at']),
      durationSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_seconds']),
      driftCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}drift_count'])!,
      driftTapLog: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}drift_tap_log']),
      arousalBefore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}arousal_before']),
      arousalAfter: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}arousal_after']),
      hrBefore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}hr_before']),
      hrAfter: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}hr_after']),
      qualityScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quality_score']),
      notesText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes_text']),
      voiceTranscript: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}voice_transcript']),
      safetyAcknowledged: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}safety_acknowledged'])!,
    );
  }

  @override
  $PracticeSessionsTableTable createAlias(String alias) {
    return $PracticeSessionsTableTable(attachedDatabase, alias);
  }
}

class PracticeSessionsTableData extends DataClass
    implements Insertable<PracticeSessionsTableData> {
  final int id;
  final String practiceId;
  final int phaseNumber;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int? durationSeconds;
  final int driftCount;
  final String? driftTapLog;
  final double? arousalBefore;
  final double? arousalAfter;
  final double? hrBefore;
  final double? hrAfter;
  final double? qualityScore;
  final String? notesText;
  final String? voiceTranscript;
  final bool safetyAcknowledged;
  const PracticeSessionsTableData(
      {required this.id,
      required this.practiceId,
      required this.phaseNumber,
      required this.startedAt,
      this.endedAt,
      this.durationSeconds,
      required this.driftCount,
      this.driftTapLog,
      this.arousalBefore,
      this.arousalAfter,
      this.hrBefore,
      this.hrAfter,
      this.qualityScore,
      this.notesText,
      this.voiceTranscript,
      required this.safetyAcknowledged});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['practice_id'] = Variable<String>(practiceId);
    map['phase_number'] = Variable<int>(phaseNumber);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    map['drift_count'] = Variable<int>(driftCount);
    if (!nullToAbsent || driftTapLog != null) {
      map['drift_tap_log'] = Variable<String>(driftTapLog);
    }
    if (!nullToAbsent || arousalBefore != null) {
      map['arousal_before'] = Variable<double>(arousalBefore);
    }
    if (!nullToAbsent || arousalAfter != null) {
      map['arousal_after'] = Variable<double>(arousalAfter);
    }
    if (!nullToAbsent || hrBefore != null) {
      map['hr_before'] = Variable<double>(hrBefore);
    }
    if (!nullToAbsent || hrAfter != null) {
      map['hr_after'] = Variable<double>(hrAfter);
    }
    if (!nullToAbsent || qualityScore != null) {
      map['quality_score'] = Variable<double>(qualityScore);
    }
    if (!nullToAbsent || notesText != null) {
      map['notes_text'] = Variable<String>(notesText);
    }
    if (!nullToAbsent || voiceTranscript != null) {
      map['voice_transcript'] = Variable<String>(voiceTranscript);
    }
    map['safety_acknowledged'] = Variable<bool>(safetyAcknowledged);
    return map;
  }

  PracticeSessionsTableCompanion toCompanion(bool nullToAbsent) {
    return PracticeSessionsTableCompanion(
      id: Value(id),
      practiceId: Value(practiceId),
      phaseNumber: Value(phaseNumber),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      durationSeconds: durationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSeconds),
      driftCount: Value(driftCount),
      driftTapLog: driftTapLog == null && nullToAbsent
          ? const Value.absent()
          : Value(driftTapLog),
      arousalBefore: arousalBefore == null && nullToAbsent
          ? const Value.absent()
          : Value(arousalBefore),
      arousalAfter: arousalAfter == null && nullToAbsent
          ? const Value.absent()
          : Value(arousalAfter),
      hrBefore: hrBefore == null && nullToAbsent
          ? const Value.absent()
          : Value(hrBefore),
      hrAfter: hrAfter == null && nullToAbsent
          ? const Value.absent()
          : Value(hrAfter),
      qualityScore: qualityScore == null && nullToAbsent
          ? const Value.absent()
          : Value(qualityScore),
      notesText: notesText == null && nullToAbsent
          ? const Value.absent()
          : Value(notesText),
      voiceTranscript: voiceTranscript == null && nullToAbsent
          ? const Value.absent()
          : Value(voiceTranscript),
      safetyAcknowledged: Value(safetyAcknowledged),
    );
  }

  factory PracticeSessionsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PracticeSessionsTableData(
      id: serializer.fromJson<int>(json['id']),
      practiceId: serializer.fromJson<String>(json['practiceId']),
      phaseNumber: serializer.fromJson<int>(json['phaseNumber']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      durationSeconds: serializer.fromJson<int?>(json['durationSeconds']),
      driftCount: serializer.fromJson<int>(json['driftCount']),
      driftTapLog: serializer.fromJson<String?>(json['driftTapLog']),
      arousalBefore: serializer.fromJson<double?>(json['arousalBefore']),
      arousalAfter: serializer.fromJson<double?>(json['arousalAfter']),
      hrBefore: serializer.fromJson<double?>(json['hrBefore']),
      hrAfter: serializer.fromJson<double?>(json['hrAfter']),
      qualityScore: serializer.fromJson<double?>(json['qualityScore']),
      notesText: serializer.fromJson<String?>(json['notesText']),
      voiceTranscript: serializer.fromJson<String?>(json['voiceTranscript']),
      safetyAcknowledged: serializer.fromJson<bool>(json['safetyAcknowledged']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'practiceId': serializer.toJson<String>(practiceId),
      'phaseNumber': serializer.toJson<int>(phaseNumber),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'durationSeconds': serializer.toJson<int?>(durationSeconds),
      'driftCount': serializer.toJson<int>(driftCount),
      'driftTapLog': serializer.toJson<String?>(driftTapLog),
      'arousalBefore': serializer.toJson<double?>(arousalBefore),
      'arousalAfter': serializer.toJson<double?>(arousalAfter),
      'hrBefore': serializer.toJson<double?>(hrBefore),
      'hrAfter': serializer.toJson<double?>(hrAfter),
      'qualityScore': serializer.toJson<double?>(qualityScore),
      'notesText': serializer.toJson<String?>(notesText),
      'voiceTranscript': serializer.toJson<String?>(voiceTranscript),
      'safetyAcknowledged': serializer.toJson<bool>(safetyAcknowledged),
    };
  }

  PracticeSessionsTableData copyWith(
          {int? id,
          String? practiceId,
          int? phaseNumber,
          DateTime? startedAt,
          Value<DateTime?> endedAt = const Value.absent(),
          Value<int?> durationSeconds = const Value.absent(),
          int? driftCount,
          Value<String?> driftTapLog = const Value.absent(),
          Value<double?> arousalBefore = const Value.absent(),
          Value<double?> arousalAfter = const Value.absent(),
          Value<double?> hrBefore = const Value.absent(),
          Value<double?> hrAfter = const Value.absent(),
          Value<double?> qualityScore = const Value.absent(),
          Value<String?> notesText = const Value.absent(),
          Value<String?> voiceTranscript = const Value.absent(),
          bool? safetyAcknowledged}) =>
      PracticeSessionsTableData(
        id: id ?? this.id,
        practiceId: practiceId ?? this.practiceId,
        phaseNumber: phaseNumber ?? this.phaseNumber,
        startedAt: startedAt ?? this.startedAt,
        endedAt: endedAt.present ? endedAt.value : this.endedAt,
        durationSeconds: durationSeconds.present
            ? durationSeconds.value
            : this.durationSeconds,
        driftCount: driftCount ?? this.driftCount,
        driftTapLog: driftTapLog.present ? driftTapLog.value : this.driftTapLog,
        arousalBefore:
            arousalBefore.present ? arousalBefore.value : this.arousalBefore,
        arousalAfter:
            arousalAfter.present ? arousalAfter.value : this.arousalAfter,
        hrBefore: hrBefore.present ? hrBefore.value : this.hrBefore,
        hrAfter: hrAfter.present ? hrAfter.value : this.hrAfter,
        qualityScore:
            qualityScore.present ? qualityScore.value : this.qualityScore,
        notesText: notesText.present ? notesText.value : this.notesText,
        voiceTranscript: voiceTranscript.present
            ? voiceTranscript.value
            : this.voiceTranscript,
        safetyAcknowledged: safetyAcknowledged ?? this.safetyAcknowledged,
      );
  PracticeSessionsTableData copyWithCompanion(
      PracticeSessionsTableCompanion data) {
    return PracticeSessionsTableData(
      id: data.id.present ? data.id.value : this.id,
      practiceId:
          data.practiceId.present ? data.practiceId.value : this.practiceId,
      phaseNumber:
          data.phaseNumber.present ? data.phaseNumber.value : this.phaseNumber,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      driftCount:
          data.driftCount.present ? data.driftCount.value : this.driftCount,
      driftTapLog:
          data.driftTapLog.present ? data.driftTapLog.value : this.driftTapLog,
      arousalBefore: data.arousalBefore.present
          ? data.arousalBefore.value
          : this.arousalBefore,
      arousalAfter: data.arousalAfter.present
          ? data.arousalAfter.value
          : this.arousalAfter,
      hrBefore: data.hrBefore.present ? data.hrBefore.value : this.hrBefore,
      hrAfter: data.hrAfter.present ? data.hrAfter.value : this.hrAfter,
      qualityScore: data.qualityScore.present
          ? data.qualityScore.value
          : this.qualityScore,
      notesText: data.notesText.present ? data.notesText.value : this.notesText,
      voiceTranscript: data.voiceTranscript.present
          ? data.voiceTranscript.value
          : this.voiceTranscript,
      safetyAcknowledged: data.safetyAcknowledged.present
          ? data.safetyAcknowledged.value
          : this.safetyAcknowledged,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PracticeSessionsTableData(')
          ..write('id: $id, ')
          ..write('practiceId: $practiceId, ')
          ..write('phaseNumber: $phaseNumber, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('driftCount: $driftCount, ')
          ..write('driftTapLog: $driftTapLog, ')
          ..write('arousalBefore: $arousalBefore, ')
          ..write('arousalAfter: $arousalAfter, ')
          ..write('hrBefore: $hrBefore, ')
          ..write('hrAfter: $hrAfter, ')
          ..write('qualityScore: $qualityScore, ')
          ..write('notesText: $notesText, ')
          ..write('voiceTranscript: $voiceTranscript, ')
          ..write('safetyAcknowledged: $safetyAcknowledged')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      practiceId,
      phaseNumber,
      startedAt,
      endedAt,
      durationSeconds,
      driftCount,
      driftTapLog,
      arousalBefore,
      arousalAfter,
      hrBefore,
      hrAfter,
      qualityScore,
      notesText,
      voiceTranscript,
      safetyAcknowledged);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PracticeSessionsTableData &&
          other.id == this.id &&
          other.practiceId == this.practiceId &&
          other.phaseNumber == this.phaseNumber &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.durationSeconds == this.durationSeconds &&
          other.driftCount == this.driftCount &&
          other.driftTapLog == this.driftTapLog &&
          other.arousalBefore == this.arousalBefore &&
          other.arousalAfter == this.arousalAfter &&
          other.hrBefore == this.hrBefore &&
          other.hrAfter == this.hrAfter &&
          other.qualityScore == this.qualityScore &&
          other.notesText == this.notesText &&
          other.voiceTranscript == this.voiceTranscript &&
          other.safetyAcknowledged == this.safetyAcknowledged);
}

class PracticeSessionsTableCompanion
    extends UpdateCompanion<PracticeSessionsTableData> {
  final Value<int> id;
  final Value<String> practiceId;
  final Value<int> phaseNumber;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<int?> durationSeconds;
  final Value<int> driftCount;
  final Value<String?> driftTapLog;
  final Value<double?> arousalBefore;
  final Value<double?> arousalAfter;
  final Value<double?> hrBefore;
  final Value<double?> hrAfter;
  final Value<double?> qualityScore;
  final Value<String?> notesText;
  final Value<String?> voiceTranscript;
  final Value<bool> safetyAcknowledged;
  const PracticeSessionsTableCompanion({
    this.id = const Value.absent(),
    this.practiceId = const Value.absent(),
    this.phaseNumber = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.driftCount = const Value.absent(),
    this.driftTapLog = const Value.absent(),
    this.arousalBefore = const Value.absent(),
    this.arousalAfter = const Value.absent(),
    this.hrBefore = const Value.absent(),
    this.hrAfter = const Value.absent(),
    this.qualityScore = const Value.absent(),
    this.notesText = const Value.absent(),
    this.voiceTranscript = const Value.absent(),
    this.safetyAcknowledged = const Value.absent(),
  });
  PracticeSessionsTableCompanion.insert({
    this.id = const Value.absent(),
    required String practiceId,
    required int phaseNumber,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.driftCount = const Value.absent(),
    this.driftTapLog = const Value.absent(),
    this.arousalBefore = const Value.absent(),
    this.arousalAfter = const Value.absent(),
    this.hrBefore = const Value.absent(),
    this.hrAfter = const Value.absent(),
    this.qualityScore = const Value.absent(),
    this.notesText = const Value.absent(),
    this.voiceTranscript = const Value.absent(),
    this.safetyAcknowledged = const Value.absent(),
  })  : practiceId = Value(practiceId),
        phaseNumber = Value(phaseNumber),
        startedAt = Value(startedAt);
  static Insertable<PracticeSessionsTableData> custom({
    Expression<int>? id,
    Expression<String>? practiceId,
    Expression<int>? phaseNumber,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? durationSeconds,
    Expression<int>? driftCount,
    Expression<String>? driftTapLog,
    Expression<double>? arousalBefore,
    Expression<double>? arousalAfter,
    Expression<double>? hrBefore,
    Expression<double>? hrAfter,
    Expression<double>? qualityScore,
    Expression<String>? notesText,
    Expression<String>? voiceTranscript,
    Expression<bool>? safetyAcknowledged,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (practiceId != null) 'practice_id': practiceId,
      if (phaseNumber != null) 'phase_number': phaseNumber,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (driftCount != null) 'drift_count': driftCount,
      if (driftTapLog != null) 'drift_tap_log': driftTapLog,
      if (arousalBefore != null) 'arousal_before': arousalBefore,
      if (arousalAfter != null) 'arousal_after': arousalAfter,
      if (hrBefore != null) 'hr_before': hrBefore,
      if (hrAfter != null) 'hr_after': hrAfter,
      if (qualityScore != null) 'quality_score': qualityScore,
      if (notesText != null) 'notes_text': notesText,
      if (voiceTranscript != null) 'voice_transcript': voiceTranscript,
      if (safetyAcknowledged != null) 'safety_acknowledged': safetyAcknowledged,
    });
  }

  PracticeSessionsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? practiceId,
      Value<int>? phaseNumber,
      Value<DateTime>? startedAt,
      Value<DateTime?>? endedAt,
      Value<int?>? durationSeconds,
      Value<int>? driftCount,
      Value<String?>? driftTapLog,
      Value<double?>? arousalBefore,
      Value<double?>? arousalAfter,
      Value<double?>? hrBefore,
      Value<double?>? hrAfter,
      Value<double?>? qualityScore,
      Value<String?>? notesText,
      Value<String?>? voiceTranscript,
      Value<bool>? safetyAcknowledged}) {
    return PracticeSessionsTableCompanion(
      id: id ?? this.id,
      practiceId: practiceId ?? this.practiceId,
      phaseNumber: phaseNumber ?? this.phaseNumber,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      driftCount: driftCount ?? this.driftCount,
      driftTapLog: driftTapLog ?? this.driftTapLog,
      arousalBefore: arousalBefore ?? this.arousalBefore,
      arousalAfter: arousalAfter ?? this.arousalAfter,
      hrBefore: hrBefore ?? this.hrBefore,
      hrAfter: hrAfter ?? this.hrAfter,
      qualityScore: qualityScore ?? this.qualityScore,
      notesText: notesText ?? this.notesText,
      voiceTranscript: voiceTranscript ?? this.voiceTranscript,
      safetyAcknowledged: safetyAcknowledged ?? this.safetyAcknowledged,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (practiceId.present) {
      map['practice_id'] = Variable<String>(practiceId.value);
    }
    if (phaseNumber.present) {
      map['phase_number'] = Variable<int>(phaseNumber.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (driftCount.present) {
      map['drift_count'] = Variable<int>(driftCount.value);
    }
    if (driftTapLog.present) {
      map['drift_tap_log'] = Variable<String>(driftTapLog.value);
    }
    if (arousalBefore.present) {
      map['arousal_before'] = Variable<double>(arousalBefore.value);
    }
    if (arousalAfter.present) {
      map['arousal_after'] = Variable<double>(arousalAfter.value);
    }
    if (hrBefore.present) {
      map['hr_before'] = Variable<double>(hrBefore.value);
    }
    if (hrAfter.present) {
      map['hr_after'] = Variable<double>(hrAfter.value);
    }
    if (qualityScore.present) {
      map['quality_score'] = Variable<double>(qualityScore.value);
    }
    if (notesText.present) {
      map['notes_text'] = Variable<String>(notesText.value);
    }
    if (voiceTranscript.present) {
      map['voice_transcript'] = Variable<String>(voiceTranscript.value);
    }
    if (safetyAcknowledged.present) {
      map['safety_acknowledged'] = Variable<bool>(safetyAcknowledged.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PracticeSessionsTableCompanion(')
          ..write('id: $id, ')
          ..write('practiceId: $practiceId, ')
          ..write('phaseNumber: $phaseNumber, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('driftCount: $driftCount, ')
          ..write('driftTapLog: $driftTapLog, ')
          ..write('arousalBefore: $arousalBefore, ')
          ..write('arousalAfter: $arousalAfter, ')
          ..write('hrBefore: $hrBefore, ')
          ..write('hrAfter: $hrAfter, ')
          ..write('qualityScore: $qualityScore, ')
          ..write('notesText: $notesText, ')
          ..write('voiceTranscript: $voiceTranscript, ')
          ..write('safetyAcknowledged: $safetyAcknowledged')
          ..write(')'))
        .toString();
  }
}

class $AssessmentResultsTableTable extends AssessmentResultsTable
    with TableInfo<$AssessmentResultsTableTable, AssessmentResultsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssessmentResultsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _assessmentIdMeta =
      const VerificationMeta('assessmentId');
  @override
  late final GeneratedColumn<String> assessmentId = GeneratedColumn<String>(
      'assessment_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phaseNumberMeta =
      const VerificationMeta('phaseNumber');
  @override
  late final GeneratedColumn<int> phaseNumber = GeneratedColumn<int>(
      'phase_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _administeredAtMeta =
      const VerificationMeta('administeredAt');
  @override
  late final GeneratedColumn<DateTime> administeredAt =
      GeneratedColumn<DateTime>('administered_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _rawScoresMeta =
      const VerificationMeta('rawScores');
  @override
  late final GeneratedColumn<String> rawScores = GeneratedColumn<String>(
      'raw_scores', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalScoreMeta =
      const VerificationMeta('totalScore');
  @override
  late final GeneratedColumn<double> totalScore = GeneratedColumn<double>(
      'total_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _subscaleScoresMeta =
      const VerificationMeta('subscaleScores');
  @override
  late final GeneratedColumn<String> subscaleScores = GeneratedColumn<String>(
      'subscale_scores', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _environmentTypeMeta =
      const VerificationMeta('environmentType');
  @override
  late final GeneratedColumn<String> environmentType = GeneratedColumn<String>(
      'environment_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _loadTypeMeta =
      const VerificationMeta('loadType');
  @override
  late final GeneratedColumn<String> loadType = GeneratedColumn<String>(
      'load_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _hrDeviceCountMeta =
      const VerificationMeta('hrDeviceCount');
  @override
  late final GeneratedColumn<double> hrDeviceCount = GeneratedColumn<double>(
      'hr_device_count', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _hrUserEstimateMeta =
      const VerificationMeta('hrUserEstimate');
  @override
  late final GeneratedColumn<double> hrUserEstimate = GeneratedColumn<double>(
      'hr_user_estimate', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        assessmentId,
        phaseNumber,
        administeredAt,
        rawScores,
        totalScore,
        subscaleScores,
        environmentType,
        loadType,
        hrDeviceCount,
        hrUserEstimate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assessment_results';
  @override
  VerificationContext validateIntegrity(
      Insertable<AssessmentResultsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('assessment_id')) {
      context.handle(
          _assessmentIdMeta,
          assessmentId.isAcceptableOrUnknown(
              data['assessment_id']!, _assessmentIdMeta));
    } else if (isInserting) {
      context.missing(_assessmentIdMeta);
    }
    if (data.containsKey('phase_number')) {
      context.handle(
          _phaseNumberMeta,
          phaseNumber.isAcceptableOrUnknown(
              data['phase_number']!, _phaseNumberMeta));
    } else if (isInserting) {
      context.missing(_phaseNumberMeta);
    }
    if (data.containsKey('administered_at')) {
      context.handle(
          _administeredAtMeta,
          administeredAt.isAcceptableOrUnknown(
              data['administered_at']!, _administeredAtMeta));
    } else if (isInserting) {
      context.missing(_administeredAtMeta);
    }
    if (data.containsKey('raw_scores')) {
      context.handle(_rawScoresMeta,
          rawScores.isAcceptableOrUnknown(data['raw_scores']!, _rawScoresMeta));
    } else if (isInserting) {
      context.missing(_rawScoresMeta);
    }
    if (data.containsKey('total_score')) {
      context.handle(
          _totalScoreMeta,
          totalScore.isAcceptableOrUnknown(
              data['total_score']!, _totalScoreMeta));
    }
    if (data.containsKey('subscale_scores')) {
      context.handle(
          _subscaleScoresMeta,
          subscaleScores.isAcceptableOrUnknown(
              data['subscale_scores']!, _subscaleScoresMeta));
    }
    if (data.containsKey('environment_type')) {
      context.handle(
          _environmentTypeMeta,
          environmentType.isAcceptableOrUnknown(
              data['environment_type']!, _environmentTypeMeta));
    }
    if (data.containsKey('load_type')) {
      context.handle(_loadTypeMeta,
          loadType.isAcceptableOrUnknown(data['load_type']!, _loadTypeMeta));
    }
    if (data.containsKey('hr_device_count')) {
      context.handle(
          _hrDeviceCountMeta,
          hrDeviceCount.isAcceptableOrUnknown(
              data['hr_device_count']!, _hrDeviceCountMeta));
    }
    if (data.containsKey('hr_user_estimate')) {
      context.handle(
          _hrUserEstimateMeta,
          hrUserEstimate.isAcceptableOrUnknown(
              data['hr_user_estimate']!, _hrUserEstimateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AssessmentResultsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssessmentResultsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      assessmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}assessment_id'])!,
      phaseNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}phase_number'])!,
      administeredAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}administered_at'])!,
      rawScores: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}raw_scores'])!,
      totalScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_score']),
      subscaleScores: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subscale_scores']),
      environmentType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}environment_type']),
      loadType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}load_type']),
      hrDeviceCount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}hr_device_count']),
      hrUserEstimate: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}hr_user_estimate']),
    );
  }

  @override
  $AssessmentResultsTableTable createAlias(String alias) {
    return $AssessmentResultsTableTable(attachedDatabase, alias);
  }
}

class AssessmentResultsTableData extends DataClass
    implements Insertable<AssessmentResultsTableData> {
  final int id;
  final String assessmentId;
  final int phaseNumber;
  final DateTime administeredAt;
  final String rawScores;
  final double? totalScore;
  final String? subscaleScores;
  final String? environmentType;
  final String? loadType;
  final double? hrDeviceCount;
  final double? hrUserEstimate;
  const AssessmentResultsTableData(
      {required this.id,
      required this.assessmentId,
      required this.phaseNumber,
      required this.administeredAt,
      required this.rawScores,
      this.totalScore,
      this.subscaleScores,
      this.environmentType,
      this.loadType,
      this.hrDeviceCount,
      this.hrUserEstimate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['assessment_id'] = Variable<String>(assessmentId);
    map['phase_number'] = Variable<int>(phaseNumber);
    map['administered_at'] = Variable<DateTime>(administeredAt);
    map['raw_scores'] = Variable<String>(rawScores);
    if (!nullToAbsent || totalScore != null) {
      map['total_score'] = Variable<double>(totalScore);
    }
    if (!nullToAbsent || subscaleScores != null) {
      map['subscale_scores'] = Variable<String>(subscaleScores);
    }
    if (!nullToAbsent || environmentType != null) {
      map['environment_type'] = Variable<String>(environmentType);
    }
    if (!nullToAbsent || loadType != null) {
      map['load_type'] = Variable<String>(loadType);
    }
    if (!nullToAbsent || hrDeviceCount != null) {
      map['hr_device_count'] = Variable<double>(hrDeviceCount);
    }
    if (!nullToAbsent || hrUserEstimate != null) {
      map['hr_user_estimate'] = Variable<double>(hrUserEstimate);
    }
    return map;
  }

  AssessmentResultsTableCompanion toCompanion(bool nullToAbsent) {
    return AssessmentResultsTableCompanion(
      id: Value(id),
      assessmentId: Value(assessmentId),
      phaseNumber: Value(phaseNumber),
      administeredAt: Value(administeredAt),
      rawScores: Value(rawScores),
      totalScore: totalScore == null && nullToAbsent
          ? const Value.absent()
          : Value(totalScore),
      subscaleScores: subscaleScores == null && nullToAbsent
          ? const Value.absent()
          : Value(subscaleScores),
      environmentType: environmentType == null && nullToAbsent
          ? const Value.absent()
          : Value(environmentType),
      loadType: loadType == null && nullToAbsent
          ? const Value.absent()
          : Value(loadType),
      hrDeviceCount: hrDeviceCount == null && nullToAbsent
          ? const Value.absent()
          : Value(hrDeviceCount),
      hrUserEstimate: hrUserEstimate == null && nullToAbsent
          ? const Value.absent()
          : Value(hrUserEstimate),
    );
  }

  factory AssessmentResultsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssessmentResultsTableData(
      id: serializer.fromJson<int>(json['id']),
      assessmentId: serializer.fromJson<String>(json['assessmentId']),
      phaseNumber: serializer.fromJson<int>(json['phaseNumber']),
      administeredAt: serializer.fromJson<DateTime>(json['administeredAt']),
      rawScores: serializer.fromJson<String>(json['rawScores']),
      totalScore: serializer.fromJson<double?>(json['totalScore']),
      subscaleScores: serializer.fromJson<String?>(json['subscaleScores']),
      environmentType: serializer.fromJson<String?>(json['environmentType']),
      loadType: serializer.fromJson<String?>(json['loadType']),
      hrDeviceCount: serializer.fromJson<double?>(json['hrDeviceCount']),
      hrUserEstimate: serializer.fromJson<double?>(json['hrUserEstimate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'assessmentId': serializer.toJson<String>(assessmentId),
      'phaseNumber': serializer.toJson<int>(phaseNumber),
      'administeredAt': serializer.toJson<DateTime>(administeredAt),
      'rawScores': serializer.toJson<String>(rawScores),
      'totalScore': serializer.toJson<double?>(totalScore),
      'subscaleScores': serializer.toJson<String?>(subscaleScores),
      'environmentType': serializer.toJson<String?>(environmentType),
      'loadType': serializer.toJson<String?>(loadType),
      'hrDeviceCount': serializer.toJson<double?>(hrDeviceCount),
      'hrUserEstimate': serializer.toJson<double?>(hrUserEstimate),
    };
  }

  AssessmentResultsTableData copyWith(
          {int? id,
          String? assessmentId,
          int? phaseNumber,
          DateTime? administeredAt,
          String? rawScores,
          Value<double?> totalScore = const Value.absent(),
          Value<String?> subscaleScores = const Value.absent(),
          Value<String?> environmentType = const Value.absent(),
          Value<String?> loadType = const Value.absent(),
          Value<double?> hrDeviceCount = const Value.absent(),
          Value<double?> hrUserEstimate = const Value.absent()}) =>
      AssessmentResultsTableData(
        id: id ?? this.id,
        assessmentId: assessmentId ?? this.assessmentId,
        phaseNumber: phaseNumber ?? this.phaseNumber,
        administeredAt: administeredAt ?? this.administeredAt,
        rawScores: rawScores ?? this.rawScores,
        totalScore: totalScore.present ? totalScore.value : this.totalScore,
        subscaleScores:
            subscaleScores.present ? subscaleScores.value : this.subscaleScores,
        environmentType: environmentType.present
            ? environmentType.value
            : this.environmentType,
        loadType: loadType.present ? loadType.value : this.loadType,
        hrDeviceCount:
            hrDeviceCount.present ? hrDeviceCount.value : this.hrDeviceCount,
        hrUserEstimate:
            hrUserEstimate.present ? hrUserEstimate.value : this.hrUserEstimate,
      );
  AssessmentResultsTableData copyWithCompanion(
      AssessmentResultsTableCompanion data) {
    return AssessmentResultsTableData(
      id: data.id.present ? data.id.value : this.id,
      assessmentId: data.assessmentId.present
          ? data.assessmentId.value
          : this.assessmentId,
      phaseNumber:
          data.phaseNumber.present ? data.phaseNumber.value : this.phaseNumber,
      administeredAt: data.administeredAt.present
          ? data.administeredAt.value
          : this.administeredAt,
      rawScores: data.rawScores.present ? data.rawScores.value : this.rawScores,
      totalScore:
          data.totalScore.present ? data.totalScore.value : this.totalScore,
      subscaleScores: data.subscaleScores.present
          ? data.subscaleScores.value
          : this.subscaleScores,
      environmentType: data.environmentType.present
          ? data.environmentType.value
          : this.environmentType,
      loadType: data.loadType.present ? data.loadType.value : this.loadType,
      hrDeviceCount: data.hrDeviceCount.present
          ? data.hrDeviceCount.value
          : this.hrDeviceCount,
      hrUserEstimate: data.hrUserEstimate.present
          ? data.hrUserEstimate.value
          : this.hrUserEstimate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AssessmentResultsTableData(')
          ..write('id: $id, ')
          ..write('assessmentId: $assessmentId, ')
          ..write('phaseNumber: $phaseNumber, ')
          ..write('administeredAt: $administeredAt, ')
          ..write('rawScores: $rawScores, ')
          ..write('totalScore: $totalScore, ')
          ..write('subscaleScores: $subscaleScores, ')
          ..write('environmentType: $environmentType, ')
          ..write('loadType: $loadType, ')
          ..write('hrDeviceCount: $hrDeviceCount, ')
          ..write('hrUserEstimate: $hrUserEstimate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      assessmentId,
      phaseNumber,
      administeredAt,
      rawScores,
      totalScore,
      subscaleScores,
      environmentType,
      loadType,
      hrDeviceCount,
      hrUserEstimate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssessmentResultsTableData &&
          other.id == this.id &&
          other.assessmentId == this.assessmentId &&
          other.phaseNumber == this.phaseNumber &&
          other.administeredAt == this.administeredAt &&
          other.rawScores == this.rawScores &&
          other.totalScore == this.totalScore &&
          other.subscaleScores == this.subscaleScores &&
          other.environmentType == this.environmentType &&
          other.loadType == this.loadType &&
          other.hrDeviceCount == this.hrDeviceCount &&
          other.hrUserEstimate == this.hrUserEstimate);
}

class AssessmentResultsTableCompanion
    extends UpdateCompanion<AssessmentResultsTableData> {
  final Value<int> id;
  final Value<String> assessmentId;
  final Value<int> phaseNumber;
  final Value<DateTime> administeredAt;
  final Value<String> rawScores;
  final Value<double?> totalScore;
  final Value<String?> subscaleScores;
  final Value<String?> environmentType;
  final Value<String?> loadType;
  final Value<double?> hrDeviceCount;
  final Value<double?> hrUserEstimate;
  const AssessmentResultsTableCompanion({
    this.id = const Value.absent(),
    this.assessmentId = const Value.absent(),
    this.phaseNumber = const Value.absent(),
    this.administeredAt = const Value.absent(),
    this.rawScores = const Value.absent(),
    this.totalScore = const Value.absent(),
    this.subscaleScores = const Value.absent(),
    this.environmentType = const Value.absent(),
    this.loadType = const Value.absent(),
    this.hrDeviceCount = const Value.absent(),
    this.hrUserEstimate = const Value.absent(),
  });
  AssessmentResultsTableCompanion.insert({
    this.id = const Value.absent(),
    required String assessmentId,
    required int phaseNumber,
    required DateTime administeredAt,
    required String rawScores,
    this.totalScore = const Value.absent(),
    this.subscaleScores = const Value.absent(),
    this.environmentType = const Value.absent(),
    this.loadType = const Value.absent(),
    this.hrDeviceCount = const Value.absent(),
    this.hrUserEstimate = const Value.absent(),
  })  : assessmentId = Value(assessmentId),
        phaseNumber = Value(phaseNumber),
        administeredAt = Value(administeredAt),
        rawScores = Value(rawScores);
  static Insertable<AssessmentResultsTableData> custom({
    Expression<int>? id,
    Expression<String>? assessmentId,
    Expression<int>? phaseNumber,
    Expression<DateTime>? administeredAt,
    Expression<String>? rawScores,
    Expression<double>? totalScore,
    Expression<String>? subscaleScores,
    Expression<String>? environmentType,
    Expression<String>? loadType,
    Expression<double>? hrDeviceCount,
    Expression<double>? hrUserEstimate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (assessmentId != null) 'assessment_id': assessmentId,
      if (phaseNumber != null) 'phase_number': phaseNumber,
      if (administeredAt != null) 'administered_at': administeredAt,
      if (rawScores != null) 'raw_scores': rawScores,
      if (totalScore != null) 'total_score': totalScore,
      if (subscaleScores != null) 'subscale_scores': subscaleScores,
      if (environmentType != null) 'environment_type': environmentType,
      if (loadType != null) 'load_type': loadType,
      if (hrDeviceCount != null) 'hr_device_count': hrDeviceCount,
      if (hrUserEstimate != null) 'hr_user_estimate': hrUserEstimate,
    });
  }

  AssessmentResultsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? assessmentId,
      Value<int>? phaseNumber,
      Value<DateTime>? administeredAt,
      Value<String>? rawScores,
      Value<double?>? totalScore,
      Value<String?>? subscaleScores,
      Value<String?>? environmentType,
      Value<String?>? loadType,
      Value<double?>? hrDeviceCount,
      Value<double?>? hrUserEstimate}) {
    return AssessmentResultsTableCompanion(
      id: id ?? this.id,
      assessmentId: assessmentId ?? this.assessmentId,
      phaseNumber: phaseNumber ?? this.phaseNumber,
      administeredAt: administeredAt ?? this.administeredAt,
      rawScores: rawScores ?? this.rawScores,
      totalScore: totalScore ?? this.totalScore,
      subscaleScores: subscaleScores ?? this.subscaleScores,
      environmentType: environmentType ?? this.environmentType,
      loadType: loadType ?? this.loadType,
      hrDeviceCount: hrDeviceCount ?? this.hrDeviceCount,
      hrUserEstimate: hrUserEstimate ?? this.hrUserEstimate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (assessmentId.present) {
      map['assessment_id'] = Variable<String>(assessmentId.value);
    }
    if (phaseNumber.present) {
      map['phase_number'] = Variable<int>(phaseNumber.value);
    }
    if (administeredAt.present) {
      map['administered_at'] = Variable<DateTime>(administeredAt.value);
    }
    if (rawScores.present) {
      map['raw_scores'] = Variable<String>(rawScores.value);
    }
    if (totalScore.present) {
      map['total_score'] = Variable<double>(totalScore.value);
    }
    if (subscaleScores.present) {
      map['subscale_scores'] = Variable<String>(subscaleScores.value);
    }
    if (environmentType.present) {
      map['environment_type'] = Variable<String>(environmentType.value);
    }
    if (loadType.present) {
      map['load_type'] = Variable<String>(loadType.value);
    }
    if (hrDeviceCount.present) {
      map['hr_device_count'] = Variable<double>(hrDeviceCount.value);
    }
    if (hrUserEstimate.present) {
      map['hr_user_estimate'] = Variable<double>(hrUserEstimate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssessmentResultsTableCompanion(')
          ..write('id: $id, ')
          ..write('assessmentId: $assessmentId, ')
          ..write('phaseNumber: $phaseNumber, ')
          ..write('administeredAt: $administeredAt, ')
          ..write('rawScores: $rawScores, ')
          ..write('totalScore: $totalScore, ')
          ..write('subscaleScores: $subscaleScores, ')
          ..write('environmentType: $environmentType, ')
          ..write('loadType: $loadType, ')
          ..write('hrDeviceCount: $hrDeviceCount, ')
          ..write('hrUserEstimate: $hrUserEstimate')
          ..write(')'))
        .toString();
  }
}

class $JournalEntriesTableTable extends JournalEntriesTable
    with TableInfo<$JournalEntriesTableTable, JournalEntriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _templateIdMeta =
      const VerificationMeta('templateId');
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
      'template_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phaseNumberMeta =
      const VerificationMeta('phaseNumber');
  @override
  late final GeneratedColumn<int> phaseNumber = GeneratedColumn<int>(
      'phase_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _practiceIdMeta =
      const VerificationMeta('practiceId');
  @override
  late final GeneratedColumn<String> practiceId = GeneratedColumn<String>(
      'practice_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _filePathMeta =
      const VerificationMeta('filePath');
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
      'file_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wordCountMeta =
      const VerificationMeta('wordCount');
  @override
  late final GeneratedColumn<int> wordCount = GeneratedColumn<int>(
      'word_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _transcriptionCompleteMeta =
      const VerificationMeta('transcriptionComplete');
  @override
  late final GeneratedColumn<bool> transcriptionComplete =
      GeneratedColumn<bool>('transcription_complete', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("transcription_complete" IN (0, 1))'),
          defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        templateId,
        phaseNumber,
        practiceId,
        createdAt,
        filePath,
        wordCount,
        transcriptionComplete
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entries';
  @override
  VerificationContext validateIntegrity(
      Insertable<JournalEntriesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('template_id')) {
      context.handle(
          _templateIdMeta,
          templateId.isAcceptableOrUnknown(
              data['template_id']!, _templateIdMeta));
    }
    if (data.containsKey('phase_number')) {
      context.handle(
          _phaseNumberMeta,
          phaseNumber.isAcceptableOrUnknown(
              data['phase_number']!, _phaseNumberMeta));
    } else if (isInserting) {
      context.missing(_phaseNumberMeta);
    }
    if (data.containsKey('practice_id')) {
      context.handle(
          _practiceIdMeta,
          practiceId.isAcceptableOrUnknown(
              data['practice_id']!, _practiceIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('file_path')) {
      context.handle(_filePathMeta,
          filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta));
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('word_count')) {
      context.handle(_wordCountMeta,
          wordCount.isAcceptableOrUnknown(data['word_count']!, _wordCountMeta));
    }
    if (data.containsKey('transcription_complete')) {
      context.handle(
          _transcriptionCompleteMeta,
          transcriptionComplete.isAcceptableOrUnknown(
              data['transcription_complete']!, _transcriptionCompleteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalEntriesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntriesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      templateId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}template_id']),
      phaseNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}phase_number'])!,
      practiceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}practice_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      filePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_path'])!,
      wordCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}word_count']),
      transcriptionComplete: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}transcription_complete'])!,
    );
  }

  @override
  $JournalEntriesTableTable createAlias(String alias) {
    return $JournalEntriesTableTable(attachedDatabase, alias);
  }
}

class JournalEntriesTableData extends DataClass
    implements Insertable<JournalEntriesTableData> {
  final int id;
  final String? templateId;
  final int phaseNumber;
  final String? practiceId;
  final DateTime createdAt;
  final String filePath;
  final int? wordCount;
  final bool transcriptionComplete;
  const JournalEntriesTableData(
      {required this.id,
      this.templateId,
      required this.phaseNumber,
      this.practiceId,
      required this.createdAt,
      required this.filePath,
      this.wordCount,
      required this.transcriptionComplete});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || templateId != null) {
      map['template_id'] = Variable<String>(templateId);
    }
    map['phase_number'] = Variable<int>(phaseNumber);
    if (!nullToAbsent || practiceId != null) {
      map['practice_id'] = Variable<String>(practiceId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['file_path'] = Variable<String>(filePath);
    if (!nullToAbsent || wordCount != null) {
      map['word_count'] = Variable<int>(wordCount);
    }
    map['transcription_complete'] = Variable<bool>(transcriptionComplete);
    return map;
  }

  JournalEntriesTableCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesTableCompanion(
      id: Value(id),
      templateId: templateId == null && nullToAbsent
          ? const Value.absent()
          : Value(templateId),
      phaseNumber: Value(phaseNumber),
      practiceId: practiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(practiceId),
      createdAt: Value(createdAt),
      filePath: Value(filePath),
      wordCount: wordCount == null && nullToAbsent
          ? const Value.absent()
          : Value(wordCount),
      transcriptionComplete: Value(transcriptionComplete),
    );
  }

  factory JournalEntriesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntriesTableData(
      id: serializer.fromJson<int>(json['id']),
      templateId: serializer.fromJson<String?>(json['templateId']),
      phaseNumber: serializer.fromJson<int>(json['phaseNumber']),
      practiceId: serializer.fromJson<String?>(json['practiceId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      filePath: serializer.fromJson<String>(json['filePath']),
      wordCount: serializer.fromJson<int?>(json['wordCount']),
      transcriptionComplete:
          serializer.fromJson<bool>(json['transcriptionComplete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'templateId': serializer.toJson<String?>(templateId),
      'phaseNumber': serializer.toJson<int>(phaseNumber),
      'practiceId': serializer.toJson<String?>(practiceId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'filePath': serializer.toJson<String>(filePath),
      'wordCount': serializer.toJson<int?>(wordCount),
      'transcriptionComplete': serializer.toJson<bool>(transcriptionComplete),
    };
  }

  JournalEntriesTableData copyWith(
          {int? id,
          Value<String?> templateId = const Value.absent(),
          int? phaseNumber,
          Value<String?> practiceId = const Value.absent(),
          DateTime? createdAt,
          String? filePath,
          Value<int?> wordCount = const Value.absent(),
          bool? transcriptionComplete}) =>
      JournalEntriesTableData(
        id: id ?? this.id,
        templateId: templateId.present ? templateId.value : this.templateId,
        phaseNumber: phaseNumber ?? this.phaseNumber,
        practiceId: practiceId.present ? practiceId.value : this.practiceId,
        createdAt: createdAt ?? this.createdAt,
        filePath: filePath ?? this.filePath,
        wordCount: wordCount.present ? wordCount.value : this.wordCount,
        transcriptionComplete:
            transcriptionComplete ?? this.transcriptionComplete,
      );
  JournalEntriesTableData copyWithCompanion(JournalEntriesTableCompanion data) {
    return JournalEntriesTableData(
      id: data.id.present ? data.id.value : this.id,
      templateId:
          data.templateId.present ? data.templateId.value : this.templateId,
      phaseNumber:
          data.phaseNumber.present ? data.phaseNumber.value : this.phaseNumber,
      practiceId:
          data.practiceId.present ? data.practiceId.value : this.practiceId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      wordCount: data.wordCount.present ? data.wordCount.value : this.wordCount,
      transcriptionComplete: data.transcriptionComplete.present
          ? data.transcriptionComplete.value
          : this.transcriptionComplete,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesTableData(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('phaseNumber: $phaseNumber, ')
          ..write('practiceId: $practiceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('filePath: $filePath, ')
          ..write('wordCount: $wordCount, ')
          ..write('transcriptionComplete: $transcriptionComplete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, templateId, phaseNumber, practiceId,
      createdAt, filePath, wordCount, transcriptionComplete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalEntriesTableData &&
          other.id == this.id &&
          other.templateId == this.templateId &&
          other.phaseNumber == this.phaseNumber &&
          other.practiceId == this.practiceId &&
          other.createdAt == this.createdAt &&
          other.filePath == this.filePath &&
          other.wordCount == this.wordCount &&
          other.transcriptionComplete == this.transcriptionComplete);
}

class JournalEntriesTableCompanion
    extends UpdateCompanion<JournalEntriesTableData> {
  final Value<int> id;
  final Value<String?> templateId;
  final Value<int> phaseNumber;
  final Value<String?> practiceId;
  final Value<DateTime> createdAt;
  final Value<String> filePath;
  final Value<int?> wordCount;
  final Value<bool> transcriptionComplete;
  const JournalEntriesTableCompanion({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    this.phaseNumber = const Value.absent(),
    this.practiceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.filePath = const Value.absent(),
    this.wordCount = const Value.absent(),
    this.transcriptionComplete = const Value.absent(),
  });
  JournalEntriesTableCompanion.insert({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    required int phaseNumber,
    this.practiceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    required String filePath,
    this.wordCount = const Value.absent(),
    this.transcriptionComplete = const Value.absent(),
  })  : phaseNumber = Value(phaseNumber),
        filePath = Value(filePath);
  static Insertable<JournalEntriesTableData> custom({
    Expression<int>? id,
    Expression<String>? templateId,
    Expression<int>? phaseNumber,
    Expression<String>? practiceId,
    Expression<DateTime>? createdAt,
    Expression<String>? filePath,
    Expression<int>? wordCount,
    Expression<bool>? transcriptionComplete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (templateId != null) 'template_id': templateId,
      if (phaseNumber != null) 'phase_number': phaseNumber,
      if (practiceId != null) 'practice_id': practiceId,
      if (createdAt != null) 'created_at': createdAt,
      if (filePath != null) 'file_path': filePath,
      if (wordCount != null) 'word_count': wordCount,
      if (transcriptionComplete != null)
        'transcription_complete': transcriptionComplete,
    });
  }

  JournalEntriesTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? templateId,
      Value<int>? phaseNumber,
      Value<String?>? practiceId,
      Value<DateTime>? createdAt,
      Value<String>? filePath,
      Value<int?>? wordCount,
      Value<bool>? transcriptionComplete}) {
    return JournalEntriesTableCompanion(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      phaseNumber: phaseNumber ?? this.phaseNumber,
      practiceId: practiceId ?? this.practiceId,
      createdAt: createdAt ?? this.createdAt,
      filePath: filePath ?? this.filePath,
      wordCount: wordCount ?? this.wordCount,
      transcriptionComplete:
          transcriptionComplete ?? this.transcriptionComplete,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (phaseNumber.present) {
      map['phase_number'] = Variable<int>(phaseNumber.value);
    }
    if (practiceId.present) {
      map['practice_id'] = Variable<String>(practiceId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (wordCount.present) {
      map['word_count'] = Variable<int>(wordCount.value);
    }
    if (transcriptionComplete.present) {
      map['transcription_complete'] =
          Variable<bool>(transcriptionComplete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesTableCompanion(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('phaseNumber: $phaseNumber, ')
          ..write('practiceId: $practiceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('filePath: $filePath, ')
          ..write('wordCount: $wordCount, ')
          ..write('transcriptionComplete: $transcriptionComplete')
          ..write(')'))
        .toString();
  }
}

class $GateStatesTableTable extends GateStatesTable
    with TableInfo<$GateStatesTableTable, GateStatesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GateStatesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _gateNumberMeta =
      const VerificationMeta('gateNumber');
  @override
  late final GeneratedColumn<int> gateNumber = GeneratedColumn<int>(
      'gate_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('not_started'));
  static const VerificationMeta _attemptCountMeta =
      const VerificationMeta('attemptCount');
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
      'attempt_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _phq9AtGateMeta =
      const VerificationMeta('phq9AtGate');
  @override
  late final GeneratedColumn<int> phq9AtGate = GeneratedColumn<int>(
      'phq9_at_gate', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _crisisIndicatorsClearMeta =
      const VerificationMeta('crisisIndicatorsClear');
  @override
  late final GeneratedColumn<bool> crisisIndicatorsClear =
      GeneratedColumn<bool>('crisis_indicators_clear', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("crisis_indicators_clear" IN (0, 1))'));
  static const VerificationMeta _selfAssessmentTextMeta =
      const VerificationMeta('selfAssessmentText');
  @override
  late final GeneratedColumn<String> selfAssessmentText =
      GeneratedColumn<String>('self_assessment_text', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _blockReasonMeta =
      const VerificationMeta('blockReason');
  @override
  late final GeneratedColumn<String> blockReason = GeneratedColumn<String>(
      'block_reason', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastAttemptedAtMeta =
      const VerificationMeta('lastAttemptedAt');
  @override
  late final GeneratedColumn<DateTime> lastAttemptedAt =
      GeneratedColumn<DateTime>('last_attempted_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _passedAtMeta =
      const VerificationMeta('passedAt');
  @override
  late final GeneratedColumn<DateTime> passedAt = GeneratedColumn<DateTime>(
      'passed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        gateNumber,
        status,
        attemptCount,
        phq9AtGate,
        crisisIndicatorsClear,
        selfAssessmentText,
        blockReason,
        lastAttemptedAt,
        passedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gate_states';
  @override
  VerificationContext validateIntegrity(
      Insertable<GateStatesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('gate_number')) {
      context.handle(
          _gateNumberMeta,
          gateNumber.isAcceptableOrUnknown(
              data['gate_number']!, _gateNumberMeta));
    } else if (isInserting) {
      context.missing(_gateNumberMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
          _attemptCountMeta,
          attemptCount.isAcceptableOrUnknown(
              data['attempt_count']!, _attemptCountMeta));
    }
    if (data.containsKey('phq9_at_gate')) {
      context.handle(
          _phq9AtGateMeta,
          phq9AtGate.isAcceptableOrUnknown(
              data['phq9_at_gate']!, _phq9AtGateMeta));
    }
    if (data.containsKey('crisis_indicators_clear')) {
      context.handle(
          _crisisIndicatorsClearMeta,
          crisisIndicatorsClear.isAcceptableOrUnknown(
              data['crisis_indicators_clear']!, _crisisIndicatorsClearMeta));
    }
    if (data.containsKey('self_assessment_text')) {
      context.handle(
          _selfAssessmentTextMeta,
          selfAssessmentText.isAcceptableOrUnknown(
              data['self_assessment_text']!, _selfAssessmentTextMeta));
    }
    if (data.containsKey('block_reason')) {
      context.handle(
          _blockReasonMeta,
          blockReason.isAcceptableOrUnknown(
              data['block_reason']!, _blockReasonMeta));
    }
    if (data.containsKey('last_attempted_at')) {
      context.handle(
          _lastAttemptedAtMeta,
          lastAttemptedAt.isAcceptableOrUnknown(
              data['last_attempted_at']!, _lastAttemptedAtMeta));
    }
    if (data.containsKey('passed_at')) {
      context.handle(_passedAtMeta,
          passedAt.isAcceptableOrUnknown(data['passed_at']!, _passedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GateStatesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GateStatesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      gateNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gate_number'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      attemptCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempt_count'])!,
      phq9AtGate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}phq9_at_gate']),
      crisisIndicatorsClear: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}crisis_indicators_clear']),
      selfAssessmentText: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}self_assessment_text']),
      blockReason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}block_reason']),
      lastAttemptedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_attempted_at']),
      passedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}passed_at']),
    );
  }

  @override
  $GateStatesTableTable createAlias(String alias) {
    return $GateStatesTableTable(attachedDatabase, alias);
  }
}

class GateStatesTableData extends DataClass
    implements Insertable<GateStatesTableData> {
  final int id;
  final int gateNumber;
  final String status;
  final int attemptCount;
  final int? phq9AtGate;
  final bool? crisisIndicatorsClear;
  final String? selfAssessmentText;
  final String? blockReason;
  final DateTime? lastAttemptedAt;
  final DateTime? passedAt;
  const GateStatesTableData(
      {required this.id,
      required this.gateNumber,
      required this.status,
      required this.attemptCount,
      this.phq9AtGate,
      this.crisisIndicatorsClear,
      this.selfAssessmentText,
      this.blockReason,
      this.lastAttemptedAt,
      this.passedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['gate_number'] = Variable<int>(gateNumber);
    map['status'] = Variable<String>(status);
    map['attempt_count'] = Variable<int>(attemptCount);
    if (!nullToAbsent || phq9AtGate != null) {
      map['phq9_at_gate'] = Variable<int>(phq9AtGate);
    }
    if (!nullToAbsent || crisisIndicatorsClear != null) {
      map['crisis_indicators_clear'] = Variable<bool>(crisisIndicatorsClear);
    }
    if (!nullToAbsent || selfAssessmentText != null) {
      map['self_assessment_text'] = Variable<String>(selfAssessmentText);
    }
    if (!nullToAbsent || blockReason != null) {
      map['block_reason'] = Variable<String>(blockReason);
    }
    if (!nullToAbsent || lastAttemptedAt != null) {
      map['last_attempted_at'] = Variable<DateTime>(lastAttemptedAt);
    }
    if (!nullToAbsent || passedAt != null) {
      map['passed_at'] = Variable<DateTime>(passedAt);
    }
    return map;
  }

  GateStatesTableCompanion toCompanion(bool nullToAbsent) {
    return GateStatesTableCompanion(
      id: Value(id),
      gateNumber: Value(gateNumber),
      status: Value(status),
      attemptCount: Value(attemptCount),
      phq9AtGate: phq9AtGate == null && nullToAbsent
          ? const Value.absent()
          : Value(phq9AtGate),
      crisisIndicatorsClear: crisisIndicatorsClear == null && nullToAbsent
          ? const Value.absent()
          : Value(crisisIndicatorsClear),
      selfAssessmentText: selfAssessmentText == null && nullToAbsent
          ? const Value.absent()
          : Value(selfAssessmentText),
      blockReason: blockReason == null && nullToAbsent
          ? const Value.absent()
          : Value(blockReason),
      lastAttemptedAt: lastAttemptedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptedAt),
      passedAt: passedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(passedAt),
    );
  }

  factory GateStatesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GateStatesTableData(
      id: serializer.fromJson<int>(json['id']),
      gateNumber: serializer.fromJson<int>(json['gateNumber']),
      status: serializer.fromJson<String>(json['status']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      phq9AtGate: serializer.fromJson<int?>(json['phq9AtGate']),
      crisisIndicatorsClear:
          serializer.fromJson<bool?>(json['crisisIndicatorsClear']),
      selfAssessmentText:
          serializer.fromJson<String?>(json['selfAssessmentText']),
      blockReason: serializer.fromJson<String?>(json['blockReason']),
      lastAttemptedAt: serializer.fromJson<DateTime?>(json['lastAttemptedAt']),
      passedAt: serializer.fromJson<DateTime?>(json['passedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gateNumber': serializer.toJson<int>(gateNumber),
      'status': serializer.toJson<String>(status),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'phq9AtGate': serializer.toJson<int?>(phq9AtGate),
      'crisisIndicatorsClear': serializer.toJson<bool?>(crisisIndicatorsClear),
      'selfAssessmentText': serializer.toJson<String?>(selfAssessmentText),
      'blockReason': serializer.toJson<String?>(blockReason),
      'lastAttemptedAt': serializer.toJson<DateTime?>(lastAttemptedAt),
      'passedAt': serializer.toJson<DateTime?>(passedAt),
    };
  }

  GateStatesTableData copyWith(
          {int? id,
          int? gateNumber,
          String? status,
          int? attemptCount,
          Value<int?> phq9AtGate = const Value.absent(),
          Value<bool?> crisisIndicatorsClear = const Value.absent(),
          Value<String?> selfAssessmentText = const Value.absent(),
          Value<String?> blockReason = const Value.absent(),
          Value<DateTime?> lastAttemptedAt = const Value.absent(),
          Value<DateTime?> passedAt = const Value.absent()}) =>
      GateStatesTableData(
        id: id ?? this.id,
        gateNumber: gateNumber ?? this.gateNumber,
        status: status ?? this.status,
        attemptCount: attemptCount ?? this.attemptCount,
        phq9AtGate: phq9AtGate.present ? phq9AtGate.value : this.phq9AtGate,
        crisisIndicatorsClear: crisisIndicatorsClear.present
            ? crisisIndicatorsClear.value
            : this.crisisIndicatorsClear,
        selfAssessmentText: selfAssessmentText.present
            ? selfAssessmentText.value
            : this.selfAssessmentText,
        blockReason: blockReason.present ? blockReason.value : this.blockReason,
        lastAttemptedAt: lastAttemptedAt.present
            ? lastAttemptedAt.value
            : this.lastAttemptedAt,
        passedAt: passedAt.present ? passedAt.value : this.passedAt,
      );
  GateStatesTableData copyWithCompanion(GateStatesTableCompanion data) {
    return GateStatesTableData(
      id: data.id.present ? data.id.value : this.id,
      gateNumber:
          data.gateNumber.present ? data.gateNumber.value : this.gateNumber,
      status: data.status.present ? data.status.value : this.status,
      attemptCount: data.attemptCount.present
          ? data.attemptCount.value
          : this.attemptCount,
      phq9AtGate:
          data.phq9AtGate.present ? data.phq9AtGate.value : this.phq9AtGate,
      crisisIndicatorsClear: data.crisisIndicatorsClear.present
          ? data.crisisIndicatorsClear.value
          : this.crisisIndicatorsClear,
      selfAssessmentText: data.selfAssessmentText.present
          ? data.selfAssessmentText.value
          : this.selfAssessmentText,
      blockReason:
          data.blockReason.present ? data.blockReason.value : this.blockReason,
      lastAttemptedAt: data.lastAttemptedAt.present
          ? data.lastAttemptedAt.value
          : this.lastAttemptedAt,
      passedAt: data.passedAt.present ? data.passedAt.value : this.passedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GateStatesTableData(')
          ..write('id: $id, ')
          ..write('gateNumber: $gateNumber, ')
          ..write('status: $status, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('phq9AtGate: $phq9AtGate, ')
          ..write('crisisIndicatorsClear: $crisisIndicatorsClear, ')
          ..write('selfAssessmentText: $selfAssessmentText, ')
          ..write('blockReason: $blockReason, ')
          ..write('lastAttemptedAt: $lastAttemptedAt, ')
          ..write('passedAt: $passedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      gateNumber,
      status,
      attemptCount,
      phq9AtGate,
      crisisIndicatorsClear,
      selfAssessmentText,
      blockReason,
      lastAttemptedAt,
      passedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GateStatesTableData &&
          other.id == this.id &&
          other.gateNumber == this.gateNumber &&
          other.status == this.status &&
          other.attemptCount == this.attemptCount &&
          other.phq9AtGate == this.phq9AtGate &&
          other.crisisIndicatorsClear == this.crisisIndicatorsClear &&
          other.selfAssessmentText == this.selfAssessmentText &&
          other.blockReason == this.blockReason &&
          other.lastAttemptedAt == this.lastAttemptedAt &&
          other.passedAt == this.passedAt);
}

class GateStatesTableCompanion extends UpdateCompanion<GateStatesTableData> {
  final Value<int> id;
  final Value<int> gateNumber;
  final Value<String> status;
  final Value<int> attemptCount;
  final Value<int?> phq9AtGate;
  final Value<bool?> crisisIndicatorsClear;
  final Value<String?> selfAssessmentText;
  final Value<String?> blockReason;
  final Value<DateTime?> lastAttemptedAt;
  final Value<DateTime?> passedAt;
  const GateStatesTableCompanion({
    this.id = const Value.absent(),
    this.gateNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.phq9AtGate = const Value.absent(),
    this.crisisIndicatorsClear = const Value.absent(),
    this.selfAssessmentText = const Value.absent(),
    this.blockReason = const Value.absent(),
    this.lastAttemptedAt = const Value.absent(),
    this.passedAt = const Value.absent(),
  });
  GateStatesTableCompanion.insert({
    this.id = const Value.absent(),
    required int gateNumber,
    this.status = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.phq9AtGate = const Value.absent(),
    this.crisisIndicatorsClear = const Value.absent(),
    this.selfAssessmentText = const Value.absent(),
    this.blockReason = const Value.absent(),
    this.lastAttemptedAt = const Value.absent(),
    this.passedAt = const Value.absent(),
  }) : gateNumber = Value(gateNumber);
  static Insertable<GateStatesTableData> custom({
    Expression<int>? id,
    Expression<int>? gateNumber,
    Expression<String>? status,
    Expression<int>? attemptCount,
    Expression<int>? phq9AtGate,
    Expression<bool>? crisisIndicatorsClear,
    Expression<String>? selfAssessmentText,
    Expression<String>? blockReason,
    Expression<DateTime>? lastAttemptedAt,
    Expression<DateTime>? passedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gateNumber != null) 'gate_number': gateNumber,
      if (status != null) 'status': status,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (phq9AtGate != null) 'phq9_at_gate': phq9AtGate,
      if (crisisIndicatorsClear != null)
        'crisis_indicators_clear': crisisIndicatorsClear,
      if (selfAssessmentText != null)
        'self_assessment_text': selfAssessmentText,
      if (blockReason != null) 'block_reason': blockReason,
      if (lastAttemptedAt != null) 'last_attempted_at': lastAttemptedAt,
      if (passedAt != null) 'passed_at': passedAt,
    });
  }

  GateStatesTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? gateNumber,
      Value<String>? status,
      Value<int>? attemptCount,
      Value<int?>? phq9AtGate,
      Value<bool?>? crisisIndicatorsClear,
      Value<String?>? selfAssessmentText,
      Value<String?>? blockReason,
      Value<DateTime?>? lastAttemptedAt,
      Value<DateTime?>? passedAt}) {
    return GateStatesTableCompanion(
      id: id ?? this.id,
      gateNumber: gateNumber ?? this.gateNumber,
      status: status ?? this.status,
      attemptCount: attemptCount ?? this.attemptCount,
      phq9AtGate: phq9AtGate ?? this.phq9AtGate,
      crisisIndicatorsClear:
          crisisIndicatorsClear ?? this.crisisIndicatorsClear,
      selfAssessmentText: selfAssessmentText ?? this.selfAssessmentText,
      blockReason: blockReason ?? this.blockReason,
      lastAttemptedAt: lastAttemptedAt ?? this.lastAttemptedAt,
      passedAt: passedAt ?? this.passedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gateNumber.present) {
      map['gate_number'] = Variable<int>(gateNumber.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (phq9AtGate.present) {
      map['phq9_at_gate'] = Variable<int>(phq9AtGate.value);
    }
    if (crisisIndicatorsClear.present) {
      map['crisis_indicators_clear'] =
          Variable<bool>(crisisIndicatorsClear.value);
    }
    if (selfAssessmentText.present) {
      map['self_assessment_text'] = Variable<String>(selfAssessmentText.value);
    }
    if (blockReason.present) {
      map['block_reason'] = Variable<String>(blockReason.value);
    }
    if (lastAttemptedAt.present) {
      map['last_attempted_at'] = Variable<DateTime>(lastAttemptedAt.value);
    }
    if (passedAt.present) {
      map['passed_at'] = Variable<DateTime>(passedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GateStatesTableCompanion(')
          ..write('id: $id, ')
          ..write('gateNumber: $gateNumber, ')
          ..write('status: $status, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('phq9AtGate: $phq9AtGate, ')
          ..write('crisisIndicatorsClear: $crisisIndicatorsClear, ')
          ..write('selfAssessmentText: $selfAssessmentText, ')
          ..write('blockReason: $blockReason, ')
          ..write('lastAttemptedAt: $lastAttemptedAt, ')
          ..write('passedAt: $passedAt')
          ..write(')'))
        .toString();
  }
}

class $GateCriteriaStatesTableTable extends GateCriteriaStatesTable
    with TableInfo<$GateCriteriaStatesTableTable, GateCriteriaStatesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GateCriteriaStatesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _gateNumberMeta =
      const VerificationMeta('gateNumber');
  @override
  late final GeneratedColumn<int> gateNumber = GeneratedColumn<int>(
      'gate_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _criterionIdMeta =
      const VerificationMeta('criterionId');
  @override
  late final GeneratedColumn<String> criterionId = GeneratedColumn<String>(
      'criterion_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _trackMeta = const VerificationMeta('track');
  @override
  late final GeneratedColumn<String> track = GeneratedColumn<String>(
      'track', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _domainMeta = const VerificationMeta('domain');
  @override
  late final GeneratedColumn<String> domain = GeneratedColumn<String>(
      'domain', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _evaluatedAtMeta =
      const VerificationMeta('evaluatedAt');
  @override
  late final GeneratedColumn<DateTime> evaluatedAt = GeneratedColumn<DateTime>(
      'evaluated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _attemptNumberMeta =
      const VerificationMeta('attemptNumber');
  @override
  late final GeneratedColumn<int> attemptNumber = GeneratedColumn<int>(
      'attempt_number', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        gateNumber,
        criterionId,
        track,
        domain,
        status,
        value,
        evaluatedAt,
        attemptNumber
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gate_criteria_states';
  @override
  VerificationContext validateIntegrity(
      Insertable<GateCriteriaStatesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('gate_number')) {
      context.handle(
          _gateNumberMeta,
          gateNumber.isAcceptableOrUnknown(
              data['gate_number']!, _gateNumberMeta));
    } else if (isInserting) {
      context.missing(_gateNumberMeta);
    }
    if (data.containsKey('criterion_id')) {
      context.handle(
          _criterionIdMeta,
          criterionId.isAcceptableOrUnknown(
              data['criterion_id']!, _criterionIdMeta));
    } else if (isInserting) {
      context.missing(_criterionIdMeta);
    }
    if (data.containsKey('track')) {
      context.handle(
          _trackMeta, track.isAcceptableOrUnknown(data['track']!, _trackMeta));
    } else if (isInserting) {
      context.missing(_trackMeta);
    }
    if (data.containsKey('domain')) {
      context.handle(_domainMeta,
          domain.isAcceptableOrUnknown(data['domain']!, _domainMeta));
    } else if (isInserting) {
      context.missing(_domainMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    }
    if (data.containsKey('evaluated_at')) {
      context.handle(
          _evaluatedAtMeta,
          evaluatedAt.isAcceptableOrUnknown(
              data['evaluated_at']!, _evaluatedAtMeta));
    }
    if (data.containsKey('attempt_number')) {
      context.handle(
          _attemptNumberMeta,
          attemptNumber.isAcceptableOrUnknown(
              data['attempt_number']!, _attemptNumberMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GateCriteriaStatesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GateCriteriaStatesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      gateNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gate_number'])!,
      criterionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}criterion_id'])!,
      track: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}track'])!,
      domain: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}domain'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value']),
      evaluatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}evaluated_at']),
      attemptNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempt_number'])!,
    );
  }

  @override
  $GateCriteriaStatesTableTable createAlias(String alias) {
    return $GateCriteriaStatesTableTable(attachedDatabase, alias);
  }
}

class GateCriteriaStatesTableData extends DataClass
    implements Insertable<GateCriteriaStatesTableData> {
  final int id;
  final int gateNumber;
  final String criterionId;
  final String track;
  final String domain;
  final String status;
  final String? value;
  final DateTime? evaluatedAt;
  final int attemptNumber;
  const GateCriteriaStatesTableData(
      {required this.id,
      required this.gateNumber,
      required this.criterionId,
      required this.track,
      required this.domain,
      required this.status,
      this.value,
      this.evaluatedAt,
      required this.attemptNumber});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['gate_number'] = Variable<int>(gateNumber);
    map['criterion_id'] = Variable<String>(criterionId);
    map['track'] = Variable<String>(track);
    map['domain'] = Variable<String>(domain);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    if (!nullToAbsent || evaluatedAt != null) {
      map['evaluated_at'] = Variable<DateTime>(evaluatedAt);
    }
    map['attempt_number'] = Variable<int>(attemptNumber);
    return map;
  }

  GateCriteriaStatesTableCompanion toCompanion(bool nullToAbsent) {
    return GateCriteriaStatesTableCompanion(
      id: Value(id),
      gateNumber: Value(gateNumber),
      criterionId: Value(criterionId),
      track: Value(track),
      domain: Value(domain),
      status: Value(status),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      evaluatedAt: evaluatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(evaluatedAt),
      attemptNumber: Value(attemptNumber),
    );
  }

  factory GateCriteriaStatesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GateCriteriaStatesTableData(
      id: serializer.fromJson<int>(json['id']),
      gateNumber: serializer.fromJson<int>(json['gateNumber']),
      criterionId: serializer.fromJson<String>(json['criterionId']),
      track: serializer.fromJson<String>(json['track']),
      domain: serializer.fromJson<String>(json['domain']),
      status: serializer.fromJson<String>(json['status']),
      value: serializer.fromJson<String?>(json['value']),
      evaluatedAt: serializer.fromJson<DateTime?>(json['evaluatedAt']),
      attemptNumber: serializer.fromJson<int>(json['attemptNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gateNumber': serializer.toJson<int>(gateNumber),
      'criterionId': serializer.toJson<String>(criterionId),
      'track': serializer.toJson<String>(track),
      'domain': serializer.toJson<String>(domain),
      'status': serializer.toJson<String>(status),
      'value': serializer.toJson<String?>(value),
      'evaluatedAt': serializer.toJson<DateTime?>(evaluatedAt),
      'attemptNumber': serializer.toJson<int>(attemptNumber),
    };
  }

  GateCriteriaStatesTableData copyWith(
          {int? id,
          int? gateNumber,
          String? criterionId,
          String? track,
          String? domain,
          String? status,
          Value<String?> value = const Value.absent(),
          Value<DateTime?> evaluatedAt = const Value.absent(),
          int? attemptNumber}) =>
      GateCriteriaStatesTableData(
        id: id ?? this.id,
        gateNumber: gateNumber ?? this.gateNumber,
        criterionId: criterionId ?? this.criterionId,
        track: track ?? this.track,
        domain: domain ?? this.domain,
        status: status ?? this.status,
        value: value.present ? value.value : this.value,
        evaluatedAt: evaluatedAt.present ? evaluatedAt.value : this.evaluatedAt,
        attemptNumber: attemptNumber ?? this.attemptNumber,
      );
  GateCriteriaStatesTableData copyWithCompanion(
      GateCriteriaStatesTableCompanion data) {
    return GateCriteriaStatesTableData(
      id: data.id.present ? data.id.value : this.id,
      gateNumber:
          data.gateNumber.present ? data.gateNumber.value : this.gateNumber,
      criterionId:
          data.criterionId.present ? data.criterionId.value : this.criterionId,
      track: data.track.present ? data.track.value : this.track,
      domain: data.domain.present ? data.domain.value : this.domain,
      status: data.status.present ? data.status.value : this.status,
      value: data.value.present ? data.value.value : this.value,
      evaluatedAt:
          data.evaluatedAt.present ? data.evaluatedAt.value : this.evaluatedAt,
      attemptNumber: data.attemptNumber.present
          ? data.attemptNumber.value
          : this.attemptNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GateCriteriaStatesTableData(')
          ..write('id: $id, ')
          ..write('gateNumber: $gateNumber, ')
          ..write('criterionId: $criterionId, ')
          ..write('track: $track, ')
          ..write('domain: $domain, ')
          ..write('status: $status, ')
          ..write('value: $value, ')
          ..write('evaluatedAt: $evaluatedAt, ')
          ..write('attemptNumber: $attemptNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, gateNumber, criterionId, track, domain,
      status, value, evaluatedAt, attemptNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GateCriteriaStatesTableData &&
          other.id == this.id &&
          other.gateNumber == this.gateNumber &&
          other.criterionId == this.criterionId &&
          other.track == this.track &&
          other.domain == this.domain &&
          other.status == this.status &&
          other.value == this.value &&
          other.evaluatedAt == this.evaluatedAt &&
          other.attemptNumber == this.attemptNumber);
}

class GateCriteriaStatesTableCompanion
    extends UpdateCompanion<GateCriteriaStatesTableData> {
  final Value<int> id;
  final Value<int> gateNumber;
  final Value<String> criterionId;
  final Value<String> track;
  final Value<String> domain;
  final Value<String> status;
  final Value<String?> value;
  final Value<DateTime?> evaluatedAt;
  final Value<int> attemptNumber;
  const GateCriteriaStatesTableCompanion({
    this.id = const Value.absent(),
    this.gateNumber = const Value.absent(),
    this.criterionId = const Value.absent(),
    this.track = const Value.absent(),
    this.domain = const Value.absent(),
    this.status = const Value.absent(),
    this.value = const Value.absent(),
    this.evaluatedAt = const Value.absent(),
    this.attemptNumber = const Value.absent(),
  });
  GateCriteriaStatesTableCompanion.insert({
    this.id = const Value.absent(),
    required int gateNumber,
    required String criterionId,
    required String track,
    required String domain,
    this.status = const Value.absent(),
    this.value = const Value.absent(),
    this.evaluatedAt = const Value.absent(),
    this.attemptNumber = const Value.absent(),
  })  : gateNumber = Value(gateNumber),
        criterionId = Value(criterionId),
        track = Value(track),
        domain = Value(domain);
  static Insertable<GateCriteriaStatesTableData> custom({
    Expression<int>? id,
    Expression<int>? gateNumber,
    Expression<String>? criterionId,
    Expression<String>? track,
    Expression<String>? domain,
    Expression<String>? status,
    Expression<String>? value,
    Expression<DateTime>? evaluatedAt,
    Expression<int>? attemptNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gateNumber != null) 'gate_number': gateNumber,
      if (criterionId != null) 'criterion_id': criterionId,
      if (track != null) 'track': track,
      if (domain != null) 'domain': domain,
      if (status != null) 'status': status,
      if (value != null) 'value': value,
      if (evaluatedAt != null) 'evaluated_at': evaluatedAt,
      if (attemptNumber != null) 'attempt_number': attemptNumber,
    });
  }

  GateCriteriaStatesTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? gateNumber,
      Value<String>? criterionId,
      Value<String>? track,
      Value<String>? domain,
      Value<String>? status,
      Value<String?>? value,
      Value<DateTime?>? evaluatedAt,
      Value<int>? attemptNumber}) {
    return GateCriteriaStatesTableCompanion(
      id: id ?? this.id,
      gateNumber: gateNumber ?? this.gateNumber,
      criterionId: criterionId ?? this.criterionId,
      track: track ?? this.track,
      domain: domain ?? this.domain,
      status: status ?? this.status,
      value: value ?? this.value,
      evaluatedAt: evaluatedAt ?? this.evaluatedAt,
      attemptNumber: attemptNumber ?? this.attemptNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gateNumber.present) {
      map['gate_number'] = Variable<int>(gateNumber.value);
    }
    if (criterionId.present) {
      map['criterion_id'] = Variable<String>(criterionId.value);
    }
    if (track.present) {
      map['track'] = Variable<String>(track.value);
    }
    if (domain.present) {
      map['domain'] = Variable<String>(domain.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (evaluatedAt.present) {
      map['evaluated_at'] = Variable<DateTime>(evaluatedAt.value);
    }
    if (attemptNumber.present) {
      map['attempt_number'] = Variable<int>(attemptNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GateCriteriaStatesTableCompanion(')
          ..write('id: $id, ')
          ..write('gateNumber: $gateNumber, ')
          ..write('criterionId: $criterionId, ')
          ..write('track: $track, ')
          ..write('domain: $domain, ')
          ..write('status: $status, ')
          ..write('value: $value, ')
          ..write('evaluatedAt: $evaluatedAt, ')
          ..write('attemptNumber: $attemptNumber')
          ..write(')'))
        .toString();
  }
}

class $LongitudinalMetricsTableTable extends LongitudinalMetricsTable
    with
        TableInfo<$LongitudinalMetricsTableTable,
            LongitudinalMetricsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LongitudinalMetricsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _metricIdMeta =
      const VerificationMeta('metricId');
  @override
  late final GeneratedColumn<String> metricId = GeneratedColumn<String>(
      'metric_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phaseNumberMeta =
      const VerificationMeta('phaseNumber');
  @override
  late final GeneratedColumn<int> phaseNumber = GeneratedColumn<int>(
      'phase_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _recordedAtMeta =
      const VerificationMeta('recordedAt');
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
      'recorded_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _sourceAssessmentIdMeta =
      const VerificationMeta('sourceAssessmentId');
  @override
  late final GeneratedColumn<int> sourceAssessmentId = GeneratedColumn<int>(
      'source_assessment_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, metricId, phaseNumber, recordedAt, value, sourceAssessmentId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'longitudinal_metrics';
  @override
  VerificationContext validateIntegrity(
      Insertable<LongitudinalMetricsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('metric_id')) {
      context.handle(_metricIdMeta,
          metricId.isAcceptableOrUnknown(data['metric_id']!, _metricIdMeta));
    } else if (isInserting) {
      context.missing(_metricIdMeta);
    }
    if (data.containsKey('phase_number')) {
      context.handle(
          _phaseNumberMeta,
          phaseNumber.isAcceptableOrUnknown(
              data['phase_number']!, _phaseNumberMeta));
    } else if (isInserting) {
      context.missing(_phaseNumberMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
          _recordedAtMeta,
          recordedAt.isAcceptableOrUnknown(
              data['recorded_at']!, _recordedAtMeta));
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('source_assessment_id')) {
      context.handle(
          _sourceAssessmentIdMeta,
          sourceAssessmentId.isAcceptableOrUnknown(
              data['source_assessment_id']!, _sourceAssessmentIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LongitudinalMetricsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LongitudinalMetricsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      metricId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metric_id'])!,
      phaseNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}phase_number'])!,
      recordedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}recorded_at'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value'])!,
      sourceAssessmentId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}source_assessment_id']),
    );
  }

  @override
  $LongitudinalMetricsTableTable createAlias(String alias) {
    return $LongitudinalMetricsTableTable(attachedDatabase, alias);
  }
}

class LongitudinalMetricsTableData extends DataClass
    implements Insertable<LongitudinalMetricsTableData> {
  final int id;
  final String metricId;
  final int phaseNumber;
  final DateTime recordedAt;
  final double value;
  final int? sourceAssessmentId;
  const LongitudinalMetricsTableData(
      {required this.id,
      required this.metricId,
      required this.phaseNumber,
      required this.recordedAt,
      required this.value,
      this.sourceAssessmentId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['metric_id'] = Variable<String>(metricId);
    map['phase_number'] = Variable<int>(phaseNumber);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    map['value'] = Variable<double>(value);
    if (!nullToAbsent || sourceAssessmentId != null) {
      map['source_assessment_id'] = Variable<int>(sourceAssessmentId);
    }
    return map;
  }

  LongitudinalMetricsTableCompanion toCompanion(bool nullToAbsent) {
    return LongitudinalMetricsTableCompanion(
      id: Value(id),
      metricId: Value(metricId),
      phaseNumber: Value(phaseNumber),
      recordedAt: Value(recordedAt),
      value: Value(value),
      sourceAssessmentId: sourceAssessmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceAssessmentId),
    );
  }

  factory LongitudinalMetricsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LongitudinalMetricsTableData(
      id: serializer.fromJson<int>(json['id']),
      metricId: serializer.fromJson<String>(json['metricId']),
      phaseNumber: serializer.fromJson<int>(json['phaseNumber']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      value: serializer.fromJson<double>(json['value']),
      sourceAssessmentId: serializer.fromJson<int?>(json['sourceAssessmentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'metricId': serializer.toJson<String>(metricId),
      'phaseNumber': serializer.toJson<int>(phaseNumber),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'value': serializer.toJson<double>(value),
      'sourceAssessmentId': serializer.toJson<int?>(sourceAssessmentId),
    };
  }

  LongitudinalMetricsTableData copyWith(
          {int? id,
          String? metricId,
          int? phaseNumber,
          DateTime? recordedAt,
          double? value,
          Value<int?> sourceAssessmentId = const Value.absent()}) =>
      LongitudinalMetricsTableData(
        id: id ?? this.id,
        metricId: metricId ?? this.metricId,
        phaseNumber: phaseNumber ?? this.phaseNumber,
        recordedAt: recordedAt ?? this.recordedAt,
        value: value ?? this.value,
        sourceAssessmentId: sourceAssessmentId.present
            ? sourceAssessmentId.value
            : this.sourceAssessmentId,
      );
  LongitudinalMetricsTableData copyWithCompanion(
      LongitudinalMetricsTableCompanion data) {
    return LongitudinalMetricsTableData(
      id: data.id.present ? data.id.value : this.id,
      metricId: data.metricId.present ? data.metricId.value : this.metricId,
      phaseNumber:
          data.phaseNumber.present ? data.phaseNumber.value : this.phaseNumber,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
      value: data.value.present ? data.value.value : this.value,
      sourceAssessmentId: data.sourceAssessmentId.present
          ? data.sourceAssessmentId.value
          : this.sourceAssessmentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LongitudinalMetricsTableData(')
          ..write('id: $id, ')
          ..write('metricId: $metricId, ')
          ..write('phaseNumber: $phaseNumber, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('value: $value, ')
          ..write('sourceAssessmentId: $sourceAssessmentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, metricId, phaseNumber, recordedAt, value, sourceAssessmentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LongitudinalMetricsTableData &&
          other.id == this.id &&
          other.metricId == this.metricId &&
          other.phaseNumber == this.phaseNumber &&
          other.recordedAt == this.recordedAt &&
          other.value == this.value &&
          other.sourceAssessmentId == this.sourceAssessmentId);
}

class LongitudinalMetricsTableCompanion
    extends UpdateCompanion<LongitudinalMetricsTableData> {
  final Value<int> id;
  final Value<String> metricId;
  final Value<int> phaseNumber;
  final Value<DateTime> recordedAt;
  final Value<double> value;
  final Value<int?> sourceAssessmentId;
  const LongitudinalMetricsTableCompanion({
    this.id = const Value.absent(),
    this.metricId = const Value.absent(),
    this.phaseNumber = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.value = const Value.absent(),
    this.sourceAssessmentId = const Value.absent(),
  });
  LongitudinalMetricsTableCompanion.insert({
    this.id = const Value.absent(),
    required String metricId,
    required int phaseNumber,
    required DateTime recordedAt,
    required double value,
    this.sourceAssessmentId = const Value.absent(),
  })  : metricId = Value(metricId),
        phaseNumber = Value(phaseNumber),
        recordedAt = Value(recordedAt),
        value = Value(value);
  static Insertable<LongitudinalMetricsTableData> custom({
    Expression<int>? id,
    Expression<String>? metricId,
    Expression<int>? phaseNumber,
    Expression<DateTime>? recordedAt,
    Expression<double>? value,
    Expression<int>? sourceAssessmentId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (metricId != null) 'metric_id': metricId,
      if (phaseNumber != null) 'phase_number': phaseNumber,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (value != null) 'value': value,
      if (sourceAssessmentId != null)
        'source_assessment_id': sourceAssessmentId,
    });
  }

  LongitudinalMetricsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? metricId,
      Value<int>? phaseNumber,
      Value<DateTime>? recordedAt,
      Value<double>? value,
      Value<int?>? sourceAssessmentId}) {
    return LongitudinalMetricsTableCompanion(
      id: id ?? this.id,
      metricId: metricId ?? this.metricId,
      phaseNumber: phaseNumber ?? this.phaseNumber,
      recordedAt: recordedAt ?? this.recordedAt,
      value: value ?? this.value,
      sourceAssessmentId: sourceAssessmentId ?? this.sourceAssessmentId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (metricId.present) {
      map['metric_id'] = Variable<String>(metricId.value);
    }
    if (phaseNumber.present) {
      map['phase_number'] = Variable<int>(phaseNumber.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (sourceAssessmentId.present) {
      map['source_assessment_id'] = Variable<int>(sourceAssessmentId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LongitudinalMetricsTableCompanion(')
          ..write('id: $id, ')
          ..write('metricId: $metricId, ')
          ..write('phaseNumber: $phaseNumber, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('value: $value, ')
          ..write('sourceAssessmentId: $sourceAssessmentId')
          ..write(')'))
        .toString();
  }
}

class $ScheduledAlarmsTableTable extends ScheduledAlarmsTable
    with TableInfo<$ScheduledAlarmsTableTable, ScheduledAlarmsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduledAlarmsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _alarmTypeMeta =
      const VerificationMeta('alarmType');
  @override
  late final GeneratedColumn<String> alarmType = GeneratedColumn<String>(
      'alarm_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scheduledForMeta =
      const VerificationMeta('scheduledFor');
  @override
  late final GeneratedColumn<DateTime> scheduledFor = GeneratedColumn<DateTime>(
      'scheduled_for', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _firedAtMeta =
      const VerificationMeta('firedAt');
  @override
  late final GeneratedColumn<DateTime> firedAt = GeneratedColumn<DateTime>(
      'fired_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _respondedAtMeta =
      const VerificationMeta('respondedAt');
  @override
  late final GeneratedColumn<DateTime> respondedAt = GeneratedColumn<DateTime>(
      'responded_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _responseJsonMeta =
      const VerificationMeta('responseJson');
  @override
  late final GeneratedColumn<String> responseJson = GeneratedColumn<String>(
      'response_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phaseNumberMeta =
      const VerificationMeta('phaseNumber');
  @override
  late final GeneratedColumn<int> phaseNumber = GeneratedColumn<int>(
      'phase_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        alarmType,
        scheduledFor,
        firedAt,
        respondedAt,
        responseJson,
        phaseNumber
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scheduled_alarms';
  @override
  VerificationContext validateIntegrity(
      Insertable<ScheduledAlarmsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('alarm_type')) {
      context.handle(_alarmTypeMeta,
          alarmType.isAcceptableOrUnknown(data['alarm_type']!, _alarmTypeMeta));
    } else if (isInserting) {
      context.missing(_alarmTypeMeta);
    }
    if (data.containsKey('scheduled_for')) {
      context.handle(
          _scheduledForMeta,
          scheduledFor.isAcceptableOrUnknown(
              data['scheduled_for']!, _scheduledForMeta));
    } else if (isInserting) {
      context.missing(_scheduledForMeta);
    }
    if (data.containsKey('fired_at')) {
      context.handle(_firedAtMeta,
          firedAt.isAcceptableOrUnknown(data['fired_at']!, _firedAtMeta));
    }
    if (data.containsKey('responded_at')) {
      context.handle(
          _respondedAtMeta,
          respondedAt.isAcceptableOrUnknown(
              data['responded_at']!, _respondedAtMeta));
    }
    if (data.containsKey('response_json')) {
      context.handle(
          _responseJsonMeta,
          responseJson.isAcceptableOrUnknown(
              data['response_json']!, _responseJsonMeta));
    }
    if (data.containsKey('phase_number')) {
      context.handle(
          _phaseNumberMeta,
          phaseNumber.isAcceptableOrUnknown(
              data['phase_number']!, _phaseNumberMeta));
    } else if (isInserting) {
      context.missing(_phaseNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduledAlarmsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduledAlarmsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      alarmType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}alarm_type'])!,
      scheduledFor: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}scheduled_for'])!,
      firedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fired_at']),
      respondedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}responded_at']),
      responseJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}response_json']),
      phaseNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}phase_number'])!,
    );
  }

  @override
  $ScheduledAlarmsTableTable createAlias(String alias) {
    return $ScheduledAlarmsTableTable(attachedDatabase, alias);
  }
}

class ScheduledAlarmsTableData extends DataClass
    implements Insertable<ScheduledAlarmsTableData> {
  final int id;
  final String alarmType;
  final DateTime scheduledFor;
  final DateTime? firedAt;
  final DateTime? respondedAt;
  final String? responseJson;
  final int phaseNumber;
  const ScheduledAlarmsTableData(
      {required this.id,
      required this.alarmType,
      required this.scheduledFor,
      this.firedAt,
      this.respondedAt,
      this.responseJson,
      required this.phaseNumber});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['alarm_type'] = Variable<String>(alarmType);
    map['scheduled_for'] = Variable<DateTime>(scheduledFor);
    if (!nullToAbsent || firedAt != null) {
      map['fired_at'] = Variable<DateTime>(firedAt);
    }
    if (!nullToAbsent || respondedAt != null) {
      map['responded_at'] = Variable<DateTime>(respondedAt);
    }
    if (!nullToAbsent || responseJson != null) {
      map['response_json'] = Variable<String>(responseJson);
    }
    map['phase_number'] = Variable<int>(phaseNumber);
    return map;
  }

  ScheduledAlarmsTableCompanion toCompanion(bool nullToAbsent) {
    return ScheduledAlarmsTableCompanion(
      id: Value(id),
      alarmType: Value(alarmType),
      scheduledFor: Value(scheduledFor),
      firedAt: firedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(firedAt),
      respondedAt: respondedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(respondedAt),
      responseJson: responseJson == null && nullToAbsent
          ? const Value.absent()
          : Value(responseJson),
      phaseNumber: Value(phaseNumber),
    );
  }

  factory ScheduledAlarmsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduledAlarmsTableData(
      id: serializer.fromJson<int>(json['id']),
      alarmType: serializer.fromJson<String>(json['alarmType']),
      scheduledFor: serializer.fromJson<DateTime>(json['scheduledFor']),
      firedAt: serializer.fromJson<DateTime?>(json['firedAt']),
      respondedAt: serializer.fromJson<DateTime?>(json['respondedAt']),
      responseJson: serializer.fromJson<String?>(json['responseJson']),
      phaseNumber: serializer.fromJson<int>(json['phaseNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'alarmType': serializer.toJson<String>(alarmType),
      'scheduledFor': serializer.toJson<DateTime>(scheduledFor),
      'firedAt': serializer.toJson<DateTime?>(firedAt),
      'respondedAt': serializer.toJson<DateTime?>(respondedAt),
      'responseJson': serializer.toJson<String?>(responseJson),
      'phaseNumber': serializer.toJson<int>(phaseNumber),
    };
  }

  ScheduledAlarmsTableData copyWith(
          {int? id,
          String? alarmType,
          DateTime? scheduledFor,
          Value<DateTime?> firedAt = const Value.absent(),
          Value<DateTime?> respondedAt = const Value.absent(),
          Value<String?> responseJson = const Value.absent(),
          int? phaseNumber}) =>
      ScheduledAlarmsTableData(
        id: id ?? this.id,
        alarmType: alarmType ?? this.alarmType,
        scheduledFor: scheduledFor ?? this.scheduledFor,
        firedAt: firedAt.present ? firedAt.value : this.firedAt,
        respondedAt: respondedAt.present ? respondedAt.value : this.respondedAt,
        responseJson:
            responseJson.present ? responseJson.value : this.responseJson,
        phaseNumber: phaseNumber ?? this.phaseNumber,
      );
  ScheduledAlarmsTableData copyWithCompanion(
      ScheduledAlarmsTableCompanion data) {
    return ScheduledAlarmsTableData(
      id: data.id.present ? data.id.value : this.id,
      alarmType: data.alarmType.present ? data.alarmType.value : this.alarmType,
      scheduledFor: data.scheduledFor.present
          ? data.scheduledFor.value
          : this.scheduledFor,
      firedAt: data.firedAt.present ? data.firedAt.value : this.firedAt,
      respondedAt:
          data.respondedAt.present ? data.respondedAt.value : this.respondedAt,
      responseJson: data.responseJson.present
          ? data.responseJson.value
          : this.responseJson,
      phaseNumber:
          data.phaseNumber.present ? data.phaseNumber.value : this.phaseNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduledAlarmsTableData(')
          ..write('id: $id, ')
          ..write('alarmType: $alarmType, ')
          ..write('scheduledFor: $scheduledFor, ')
          ..write('firedAt: $firedAt, ')
          ..write('respondedAt: $respondedAt, ')
          ..write('responseJson: $responseJson, ')
          ..write('phaseNumber: $phaseNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, alarmType, scheduledFor, firedAt,
      respondedAt, responseJson, phaseNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduledAlarmsTableData &&
          other.id == this.id &&
          other.alarmType == this.alarmType &&
          other.scheduledFor == this.scheduledFor &&
          other.firedAt == this.firedAt &&
          other.respondedAt == this.respondedAt &&
          other.responseJson == this.responseJson &&
          other.phaseNumber == this.phaseNumber);
}

class ScheduledAlarmsTableCompanion
    extends UpdateCompanion<ScheduledAlarmsTableData> {
  final Value<int> id;
  final Value<String> alarmType;
  final Value<DateTime> scheduledFor;
  final Value<DateTime?> firedAt;
  final Value<DateTime?> respondedAt;
  final Value<String?> responseJson;
  final Value<int> phaseNumber;
  const ScheduledAlarmsTableCompanion({
    this.id = const Value.absent(),
    this.alarmType = const Value.absent(),
    this.scheduledFor = const Value.absent(),
    this.firedAt = const Value.absent(),
    this.respondedAt = const Value.absent(),
    this.responseJson = const Value.absent(),
    this.phaseNumber = const Value.absent(),
  });
  ScheduledAlarmsTableCompanion.insert({
    this.id = const Value.absent(),
    required String alarmType,
    required DateTime scheduledFor,
    this.firedAt = const Value.absent(),
    this.respondedAt = const Value.absent(),
    this.responseJson = const Value.absent(),
    required int phaseNumber,
  })  : alarmType = Value(alarmType),
        scheduledFor = Value(scheduledFor),
        phaseNumber = Value(phaseNumber);
  static Insertable<ScheduledAlarmsTableData> custom({
    Expression<int>? id,
    Expression<String>? alarmType,
    Expression<DateTime>? scheduledFor,
    Expression<DateTime>? firedAt,
    Expression<DateTime>? respondedAt,
    Expression<String>? responseJson,
    Expression<int>? phaseNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (alarmType != null) 'alarm_type': alarmType,
      if (scheduledFor != null) 'scheduled_for': scheduledFor,
      if (firedAt != null) 'fired_at': firedAt,
      if (respondedAt != null) 'responded_at': respondedAt,
      if (responseJson != null) 'response_json': responseJson,
      if (phaseNumber != null) 'phase_number': phaseNumber,
    });
  }

  ScheduledAlarmsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? alarmType,
      Value<DateTime>? scheduledFor,
      Value<DateTime?>? firedAt,
      Value<DateTime?>? respondedAt,
      Value<String?>? responseJson,
      Value<int>? phaseNumber}) {
    return ScheduledAlarmsTableCompanion(
      id: id ?? this.id,
      alarmType: alarmType ?? this.alarmType,
      scheduledFor: scheduledFor ?? this.scheduledFor,
      firedAt: firedAt ?? this.firedAt,
      respondedAt: respondedAt ?? this.respondedAt,
      responseJson: responseJson ?? this.responseJson,
      phaseNumber: phaseNumber ?? this.phaseNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (alarmType.present) {
      map['alarm_type'] = Variable<String>(alarmType.value);
    }
    if (scheduledFor.present) {
      map['scheduled_for'] = Variable<DateTime>(scheduledFor.value);
    }
    if (firedAt.present) {
      map['fired_at'] = Variable<DateTime>(firedAt.value);
    }
    if (respondedAt.present) {
      map['responded_at'] = Variable<DateTime>(respondedAt.value);
    }
    if (responseJson.present) {
      map['response_json'] = Variable<String>(responseJson.value);
    }
    if (phaseNumber.present) {
      map['phase_number'] = Variable<int>(phaseNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduledAlarmsTableCompanion(')
          ..write('id: $id, ')
          ..write('alarmType: $alarmType, ')
          ..write('scheduledFor: $scheduledFor, ')
          ..write('firedAt: $firedAt, ')
          ..write('respondedAt: $respondedAt, ')
          ..write('responseJson: $responseJson, ')
          ..write('phaseNumber: $phaseNumber')
          ..write(')'))
        .toString();
  }
}

class $StatsQueueTableTable extends StatsQueueTable
    with TableInfo<$StatsQueueTableTable, StatsQueueTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatsQueueTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _schemaVersionMeta =
      const VerificationMeta('schemaVersion');
  @override
  late final GeneratedColumn<int> schemaVersion = GeneratedColumn<int>(
      'schema_version', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _eventTypeMeta =
      const VerificationMeta('eventType');
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
      'event_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadJsonMeta =
      const VerificationMeta('payloadJson');
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
      'payload_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _submittedAtMeta =
      const VerificationMeta('submittedAt');
  @override
  late final GeneratedColumn<DateTime> submittedAt = GeneratedColumn<DateTime>(
      'submitted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, schemaVersion, eventType, payloadJson, createdAt, submittedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stats_queue';
  @override
  VerificationContext validateIntegrity(
      Insertable<StatsQueueTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('schema_version')) {
      context.handle(
          _schemaVersionMeta,
          schemaVersion.isAcceptableOrUnknown(
              data['schema_version']!, _schemaVersionMeta));
    }
    if (data.containsKey('event_type')) {
      context.handle(_eventTypeMeta,
          eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta));
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
          _payloadJsonMeta,
          payloadJson.isAcceptableOrUnknown(
              data['payload_json']!, _payloadJsonMeta));
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('submitted_at')) {
      context.handle(
          _submittedAtMeta,
          submittedAt.isAcceptableOrUnknown(
              data['submitted_at']!, _submittedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StatsQueueTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StatsQueueTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      schemaVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}schema_version'])!,
      eventType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event_type'])!,
      payloadJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload_json'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      submittedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}submitted_at']),
    );
  }

  @override
  $StatsQueueTableTable createAlias(String alias) {
    return $StatsQueueTableTable(attachedDatabase, alias);
  }
}

class StatsQueueTableData extends DataClass
    implements Insertable<StatsQueueTableData> {
  final int id;
  final int schemaVersion;
  final String eventType;
  final String payloadJson;
  final DateTime createdAt;
  final DateTime? submittedAt;
  const StatsQueueTableData(
      {required this.id,
      required this.schemaVersion,
      required this.eventType,
      required this.payloadJson,
      required this.createdAt,
      this.submittedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['schema_version'] = Variable<int>(schemaVersion);
    map['event_type'] = Variable<String>(eventType);
    map['payload_json'] = Variable<String>(payloadJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || submittedAt != null) {
      map['submitted_at'] = Variable<DateTime>(submittedAt);
    }
    return map;
  }

  StatsQueueTableCompanion toCompanion(bool nullToAbsent) {
    return StatsQueueTableCompanion(
      id: Value(id),
      schemaVersion: Value(schemaVersion),
      eventType: Value(eventType),
      payloadJson: Value(payloadJson),
      createdAt: Value(createdAt),
      submittedAt: submittedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(submittedAt),
    );
  }

  factory StatsQueueTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StatsQueueTableData(
      id: serializer.fromJson<int>(json['id']),
      schemaVersion: serializer.fromJson<int>(json['schemaVersion']),
      eventType: serializer.fromJson<String>(json['eventType']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      submittedAt: serializer.fromJson<DateTime?>(json['submittedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'schemaVersion': serializer.toJson<int>(schemaVersion),
      'eventType': serializer.toJson<String>(eventType),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'submittedAt': serializer.toJson<DateTime?>(submittedAt),
    };
  }

  StatsQueueTableData copyWith(
          {int? id,
          int? schemaVersion,
          String? eventType,
          String? payloadJson,
          DateTime? createdAt,
          Value<DateTime?> submittedAt = const Value.absent()}) =>
      StatsQueueTableData(
        id: id ?? this.id,
        schemaVersion: schemaVersion ?? this.schemaVersion,
        eventType: eventType ?? this.eventType,
        payloadJson: payloadJson ?? this.payloadJson,
        createdAt: createdAt ?? this.createdAt,
        submittedAt: submittedAt.present ? submittedAt.value : this.submittedAt,
      );
  StatsQueueTableData copyWithCompanion(StatsQueueTableCompanion data) {
    return StatsQueueTableData(
      id: data.id.present ? data.id.value : this.id,
      schemaVersion: data.schemaVersion.present
          ? data.schemaVersion.value
          : this.schemaVersion,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      payloadJson:
          data.payloadJson.present ? data.payloadJson.value : this.payloadJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      submittedAt:
          data.submittedAt.present ? data.submittedAt.value : this.submittedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StatsQueueTableData(')
          ..write('id: $id, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('eventType: $eventType, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('submittedAt: $submittedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, schemaVersion, eventType, payloadJson, createdAt, submittedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StatsQueueTableData &&
          other.id == this.id &&
          other.schemaVersion == this.schemaVersion &&
          other.eventType == this.eventType &&
          other.payloadJson == this.payloadJson &&
          other.createdAt == this.createdAt &&
          other.submittedAt == this.submittedAt);
}

class StatsQueueTableCompanion extends UpdateCompanion<StatsQueueTableData> {
  final Value<int> id;
  final Value<int> schemaVersion;
  final Value<String> eventType;
  final Value<String> payloadJson;
  final Value<DateTime> createdAt;
  final Value<DateTime?> submittedAt;
  const StatsQueueTableCompanion({
    this.id = const Value.absent(),
    this.schemaVersion = const Value.absent(),
    this.eventType = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.submittedAt = const Value.absent(),
  });
  StatsQueueTableCompanion.insert({
    this.id = const Value.absent(),
    this.schemaVersion = const Value.absent(),
    required String eventType,
    required String payloadJson,
    this.createdAt = const Value.absent(),
    this.submittedAt = const Value.absent(),
  })  : eventType = Value(eventType),
        payloadJson = Value(payloadJson);
  static Insertable<StatsQueueTableData> custom({
    Expression<int>? id,
    Expression<int>? schemaVersion,
    Expression<String>? eventType,
    Expression<String>? payloadJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? submittedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (schemaVersion != null) 'schema_version': schemaVersion,
      if (eventType != null) 'event_type': eventType,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (createdAt != null) 'created_at': createdAt,
      if (submittedAt != null) 'submitted_at': submittedAt,
    });
  }

  StatsQueueTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? schemaVersion,
      Value<String>? eventType,
      Value<String>? payloadJson,
      Value<DateTime>? createdAt,
      Value<DateTime?>? submittedAt}) {
    return StatsQueueTableCompanion(
      id: id ?? this.id,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      eventType: eventType ?? this.eventType,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAt: createdAt ?? this.createdAt,
      submittedAt: submittedAt ?? this.submittedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (schemaVersion.present) {
      map['schema_version'] = Variable<int>(schemaVersion.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (submittedAt.present) {
      map['submitted_at'] = Variable<DateTime>(submittedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatsQueueTableCompanion(')
          ..write('id: $id, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('eventType: $eventType, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('submittedAt: $submittedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserStateTableTable userStateTable = $UserStateTableTable(this);
  late final $PhaseProgressTableTable phaseProgressTable =
      $PhaseProgressTableTable(this);
  late final $PracticeSessionsTableTable practiceSessionsTable =
      $PracticeSessionsTableTable(this);
  late final $AssessmentResultsTableTable assessmentResultsTable =
      $AssessmentResultsTableTable(this);
  late final $JournalEntriesTableTable journalEntriesTable =
      $JournalEntriesTableTable(this);
  late final $GateStatesTableTable gateStatesTable =
      $GateStatesTableTable(this);
  late final $GateCriteriaStatesTableTable gateCriteriaStatesTable =
      $GateCriteriaStatesTableTable(this);
  late final $LongitudinalMetricsTableTable longitudinalMetricsTable =
      $LongitudinalMetricsTableTable(this);
  late final $ScheduledAlarmsTableTable scheduledAlarmsTable =
      $ScheduledAlarmsTableTable(this);
  late final $StatsQueueTableTable statsQueueTable =
      $StatsQueueTableTable(this);
  late final UserStateDao userStateDao = UserStateDao(this as AppDatabase);
  late final PhaseProgressDao phaseProgressDao =
      PhaseProgressDao(this as AppDatabase);
  late final PracticeSessionsDao practiceSessionsDao =
      PracticeSessionsDao(this as AppDatabase);
  late final AssessmentResultsDao assessmentResultsDao =
      AssessmentResultsDao(this as AppDatabase);
  late final JournalEntriesDao journalEntriesDao =
      JournalEntriesDao(this as AppDatabase);
  late final GateStatesDao gateStatesDao = GateStatesDao(this as AppDatabase);
  late final GateCriteriaStatesDao gateCriteriaStatesDao =
      GateCriteriaStatesDao(this as AppDatabase);
  late final LongitudinalMetricsDao longitudinalMetricsDao =
      LongitudinalMetricsDao(this as AppDatabase);
  late final ScheduledAlarmsDao scheduledAlarmsDao =
      ScheduledAlarmsDao(this as AppDatabase);
  late final StatsQueueDao statsQueueDao = StatsQueueDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        userStateTable,
        phaseProgressTable,
        practiceSessionsTable,
        assessmentResultsTable,
        journalEntriesTable,
        gateStatesTable,
        gateCriteriaStatesTable,
        longitudinalMetricsTable,
        scheduledAlarmsTable,
        statsQueueTable
      ];
}

typedef $$UserStateTableTableCreateCompanionBuilder = UserStateTableCompanion
    Function({
  Value<int> id,
  Value<bool> onboardingComplete,
  Value<int> currentPhase,
  Value<String?> trackEmotionalLiteracy,
  Value<String?> trackSomatic,
  Value<String?> trackVocabulary,
  Value<int?> tas20Score,
  Value<String?> valuesDocument,
  Value<String?> selfDescription,
  Value<bool> statsOptIn,
  Value<String?> statsToken,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$UserStateTableTableUpdateCompanionBuilder = UserStateTableCompanion
    Function({
  Value<int> id,
  Value<bool> onboardingComplete,
  Value<int> currentPhase,
  Value<String?> trackEmotionalLiteracy,
  Value<String?> trackSomatic,
  Value<String?> trackVocabulary,
  Value<int?> tas20Score,
  Value<String?> valuesDocument,
  Value<String?> selfDescription,
  Value<bool> statsOptIn,
  Value<String?> statsToken,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$UserStateTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserStateTableTable> {
  $$UserStateTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get onboardingComplete => $composableBuilder(
      column: $table.onboardingComplete,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentPhase => $composableBuilder(
      column: $table.currentPhase, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get trackEmotionalLiteracy => $composableBuilder(
      column: $table.trackEmotionalLiteracy,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get trackSomatic => $composableBuilder(
      column: $table.trackSomatic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get trackVocabulary => $composableBuilder(
      column: $table.trackVocabulary,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tas20Score => $composableBuilder(
      column: $table.tas20Score, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get valuesDocument => $composableBuilder(
      column: $table.valuesDocument,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get selfDescription => $composableBuilder(
      column: $table.selfDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get statsOptIn => $composableBuilder(
      column: $table.statsOptIn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get statsToken => $composableBuilder(
      column: $table.statsToken, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$UserStateTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserStateTableTable> {
  $$UserStateTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get onboardingComplete => $composableBuilder(
      column: $table.onboardingComplete,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentPhase => $composableBuilder(
      column: $table.currentPhase,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get trackEmotionalLiteracy => $composableBuilder(
      column: $table.trackEmotionalLiteracy,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get trackSomatic => $composableBuilder(
      column: $table.trackSomatic,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get trackVocabulary => $composableBuilder(
      column: $table.trackVocabulary,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tas20Score => $composableBuilder(
      column: $table.tas20Score, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get valuesDocument => $composableBuilder(
      column: $table.valuesDocument,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get selfDescription => $composableBuilder(
      column: $table.selfDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get statsOptIn => $composableBuilder(
      column: $table.statsOptIn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get statsToken => $composableBuilder(
      column: $table.statsToken, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$UserStateTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserStateTableTable> {
  $$UserStateTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get onboardingComplete => $composableBuilder(
      column: $table.onboardingComplete, builder: (column) => column);

  GeneratedColumn<int> get currentPhase => $composableBuilder(
      column: $table.currentPhase, builder: (column) => column);

  GeneratedColumn<String> get trackEmotionalLiteracy => $composableBuilder(
      column: $table.trackEmotionalLiteracy, builder: (column) => column);

  GeneratedColumn<String> get trackSomatic => $composableBuilder(
      column: $table.trackSomatic, builder: (column) => column);

  GeneratedColumn<String> get trackVocabulary => $composableBuilder(
      column: $table.trackVocabulary, builder: (column) => column);

  GeneratedColumn<int> get tas20Score => $composableBuilder(
      column: $table.tas20Score, builder: (column) => column);

  GeneratedColumn<String> get valuesDocument => $composableBuilder(
      column: $table.valuesDocument, builder: (column) => column);

  GeneratedColumn<String> get selfDescription => $composableBuilder(
      column: $table.selfDescription, builder: (column) => column);

  GeneratedColumn<bool> get statsOptIn => $composableBuilder(
      column: $table.statsOptIn, builder: (column) => column);

  GeneratedColumn<String> get statsToken => $composableBuilder(
      column: $table.statsToken, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserStateTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserStateTableTable,
    UserStateTableData,
    $$UserStateTableTableFilterComposer,
    $$UserStateTableTableOrderingComposer,
    $$UserStateTableTableAnnotationComposer,
    $$UserStateTableTableCreateCompanionBuilder,
    $$UserStateTableTableUpdateCompanionBuilder,
    (
      UserStateTableData,
      BaseReferences<_$AppDatabase, $UserStateTableTable, UserStateTableData>
    ),
    UserStateTableData,
    PrefetchHooks Function()> {
  $$UserStateTableTableTableManager(
      _$AppDatabase db, $UserStateTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserStateTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserStateTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserStateTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> onboardingComplete = const Value.absent(),
            Value<int> currentPhase = const Value.absent(),
            Value<String?> trackEmotionalLiteracy = const Value.absent(),
            Value<String?> trackSomatic = const Value.absent(),
            Value<String?> trackVocabulary = const Value.absent(),
            Value<int?> tas20Score = const Value.absent(),
            Value<String?> valuesDocument = const Value.absent(),
            Value<String?> selfDescription = const Value.absent(),
            Value<bool> statsOptIn = const Value.absent(),
            Value<String?> statsToken = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UserStateTableCompanion(
            id: id,
            onboardingComplete: onboardingComplete,
            currentPhase: currentPhase,
            trackEmotionalLiteracy: trackEmotionalLiteracy,
            trackSomatic: trackSomatic,
            trackVocabulary: trackVocabulary,
            tas20Score: tas20Score,
            valuesDocument: valuesDocument,
            selfDescription: selfDescription,
            statsOptIn: statsOptIn,
            statsToken: statsToken,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> onboardingComplete = const Value.absent(),
            Value<int> currentPhase = const Value.absent(),
            Value<String?> trackEmotionalLiteracy = const Value.absent(),
            Value<String?> trackSomatic = const Value.absent(),
            Value<String?> trackVocabulary = const Value.absent(),
            Value<int?> tas20Score = const Value.absent(),
            Value<String?> valuesDocument = const Value.absent(),
            Value<String?> selfDescription = const Value.absent(),
            Value<bool> statsOptIn = const Value.absent(),
            Value<String?> statsToken = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UserStateTableCompanion.insert(
            id: id,
            onboardingComplete: onboardingComplete,
            currentPhase: currentPhase,
            trackEmotionalLiteracy: trackEmotionalLiteracy,
            trackSomatic: trackSomatic,
            trackVocabulary: trackVocabulary,
            tas20Score: tas20Score,
            valuesDocument: valuesDocument,
            selfDescription: selfDescription,
            statsOptIn: statsOptIn,
            statsToken: statsToken,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserStateTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserStateTableTable,
    UserStateTableData,
    $$UserStateTableTableFilterComposer,
    $$UserStateTableTableOrderingComposer,
    $$UserStateTableTableAnnotationComposer,
    $$UserStateTableTableCreateCompanionBuilder,
    $$UserStateTableTableUpdateCompanionBuilder,
    (
      UserStateTableData,
      BaseReferences<_$AppDatabase, $UserStateTableTable, UserStateTableData>
    ),
    UserStateTableData,
    PrefetchHooks Function()>;
typedef $$PhaseProgressTableTableCreateCompanionBuilder
    = PhaseProgressTableCompanion Function({
  Value<int> id,
  required int phaseNumber,
  Value<String> status,
  required DateTime startedAt,
  Value<DateTime?> completedAt,
  Value<int> weekNumber,
  Value<String?> extensionsJson,
});
typedef $$PhaseProgressTableTableUpdateCompanionBuilder
    = PhaseProgressTableCompanion Function({
  Value<int> id,
  Value<int> phaseNumber,
  Value<String> status,
  Value<DateTime> startedAt,
  Value<DateTime?> completedAt,
  Value<int> weekNumber,
  Value<String?> extensionsJson,
});

class $$PhaseProgressTableTableFilterComposer
    extends Composer<_$AppDatabase, $PhaseProgressTableTable> {
  $$PhaseProgressTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get weekNumber => $composableBuilder(
      column: $table.weekNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get extensionsJson => $composableBuilder(
      column: $table.extensionsJson,
      builder: (column) => ColumnFilters(column));
}

class $$PhaseProgressTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PhaseProgressTableTable> {
  $$PhaseProgressTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get weekNumber => $composableBuilder(
      column: $table.weekNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get extensionsJson => $composableBuilder(
      column: $table.extensionsJson,
      builder: (column) => ColumnOrderings(column));
}

class $$PhaseProgressTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhaseProgressTableTable> {
  $$PhaseProgressTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<int> get weekNumber => $composableBuilder(
      column: $table.weekNumber, builder: (column) => column);

  GeneratedColumn<String> get extensionsJson => $composableBuilder(
      column: $table.extensionsJson, builder: (column) => column);
}

class $$PhaseProgressTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PhaseProgressTableTable,
    PhaseProgressTableData,
    $$PhaseProgressTableTableFilterComposer,
    $$PhaseProgressTableTableOrderingComposer,
    $$PhaseProgressTableTableAnnotationComposer,
    $$PhaseProgressTableTableCreateCompanionBuilder,
    $$PhaseProgressTableTableUpdateCompanionBuilder,
    (
      PhaseProgressTableData,
      BaseReferences<_$AppDatabase, $PhaseProgressTableTable,
          PhaseProgressTableData>
    ),
    PhaseProgressTableData,
    PrefetchHooks Function()> {
  $$PhaseProgressTableTableTableManager(
      _$AppDatabase db, $PhaseProgressTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhaseProgressTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhaseProgressTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhaseProgressTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> phaseNumber = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> startedAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> weekNumber = const Value.absent(),
            Value<String?> extensionsJson = const Value.absent(),
          }) =>
              PhaseProgressTableCompanion(
            id: id,
            phaseNumber: phaseNumber,
            status: status,
            startedAt: startedAt,
            completedAt: completedAt,
            weekNumber: weekNumber,
            extensionsJson: extensionsJson,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int phaseNumber,
            Value<String> status = const Value.absent(),
            required DateTime startedAt,
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> weekNumber = const Value.absent(),
            Value<String?> extensionsJson = const Value.absent(),
          }) =>
              PhaseProgressTableCompanion.insert(
            id: id,
            phaseNumber: phaseNumber,
            status: status,
            startedAt: startedAt,
            completedAt: completedAt,
            weekNumber: weekNumber,
            extensionsJson: extensionsJson,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PhaseProgressTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PhaseProgressTableTable,
    PhaseProgressTableData,
    $$PhaseProgressTableTableFilterComposer,
    $$PhaseProgressTableTableOrderingComposer,
    $$PhaseProgressTableTableAnnotationComposer,
    $$PhaseProgressTableTableCreateCompanionBuilder,
    $$PhaseProgressTableTableUpdateCompanionBuilder,
    (
      PhaseProgressTableData,
      BaseReferences<_$AppDatabase, $PhaseProgressTableTable,
          PhaseProgressTableData>
    ),
    PhaseProgressTableData,
    PrefetchHooks Function()>;
typedef $$PracticeSessionsTableTableCreateCompanionBuilder
    = PracticeSessionsTableCompanion Function({
  Value<int> id,
  required String practiceId,
  required int phaseNumber,
  required DateTime startedAt,
  Value<DateTime?> endedAt,
  Value<int?> durationSeconds,
  Value<int> driftCount,
  Value<String?> driftTapLog,
  Value<double?> arousalBefore,
  Value<double?> arousalAfter,
  Value<double?> hrBefore,
  Value<double?> hrAfter,
  Value<double?> qualityScore,
  Value<String?> notesText,
  Value<String?> voiceTranscript,
  Value<bool> safetyAcknowledged,
});
typedef $$PracticeSessionsTableTableUpdateCompanionBuilder
    = PracticeSessionsTableCompanion Function({
  Value<int> id,
  Value<String> practiceId,
  Value<int> phaseNumber,
  Value<DateTime> startedAt,
  Value<DateTime?> endedAt,
  Value<int?> durationSeconds,
  Value<int> driftCount,
  Value<String?> driftTapLog,
  Value<double?> arousalBefore,
  Value<double?> arousalAfter,
  Value<double?> hrBefore,
  Value<double?> hrAfter,
  Value<double?> qualityScore,
  Value<String?> notesText,
  Value<String?> voiceTranscript,
  Value<bool> safetyAcknowledged,
});

class $$PracticeSessionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PracticeSessionsTableTable> {
  $$PracticeSessionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get practiceId => $composableBuilder(
      column: $table.practiceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
      column: $table.endedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get driftCount => $composableBuilder(
      column: $table.driftCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get driftTapLog => $composableBuilder(
      column: $table.driftTapLog, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get arousalBefore => $composableBuilder(
      column: $table.arousalBefore, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get arousalAfter => $composableBuilder(
      column: $table.arousalAfter, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get hrBefore => $composableBuilder(
      column: $table.hrBefore, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get hrAfter => $composableBuilder(
      column: $table.hrAfter, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get qualityScore => $composableBuilder(
      column: $table.qualityScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notesText => $composableBuilder(
      column: $table.notesText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get voiceTranscript => $composableBuilder(
      column: $table.voiceTranscript,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get safetyAcknowledged => $composableBuilder(
      column: $table.safetyAcknowledged,
      builder: (column) => ColumnFilters(column));
}

class $$PracticeSessionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PracticeSessionsTableTable> {
  $$PracticeSessionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get practiceId => $composableBuilder(
      column: $table.practiceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
      column: $table.endedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get driftCount => $composableBuilder(
      column: $table.driftCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get driftTapLog => $composableBuilder(
      column: $table.driftTapLog, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get arousalBefore => $composableBuilder(
      column: $table.arousalBefore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get arousalAfter => $composableBuilder(
      column: $table.arousalAfter,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get hrBefore => $composableBuilder(
      column: $table.hrBefore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get hrAfter => $composableBuilder(
      column: $table.hrAfter, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get qualityScore => $composableBuilder(
      column: $table.qualityScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notesText => $composableBuilder(
      column: $table.notesText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get voiceTranscript => $composableBuilder(
      column: $table.voiceTranscript,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get safetyAcknowledged => $composableBuilder(
      column: $table.safetyAcknowledged,
      builder: (column) => ColumnOrderings(column));
}

class $$PracticeSessionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PracticeSessionsTableTable> {
  $$PracticeSessionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get practiceId => $composableBuilder(
      column: $table.practiceId, builder: (column) => column);

  GeneratedColumn<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds, builder: (column) => column);

  GeneratedColumn<int> get driftCount => $composableBuilder(
      column: $table.driftCount, builder: (column) => column);

  GeneratedColumn<String> get driftTapLog => $composableBuilder(
      column: $table.driftTapLog, builder: (column) => column);

  GeneratedColumn<double> get arousalBefore => $composableBuilder(
      column: $table.arousalBefore, builder: (column) => column);

  GeneratedColumn<double> get arousalAfter => $composableBuilder(
      column: $table.arousalAfter, builder: (column) => column);

  GeneratedColumn<double> get hrBefore =>
      $composableBuilder(column: $table.hrBefore, builder: (column) => column);

  GeneratedColumn<double> get hrAfter =>
      $composableBuilder(column: $table.hrAfter, builder: (column) => column);

  GeneratedColumn<double> get qualityScore => $composableBuilder(
      column: $table.qualityScore, builder: (column) => column);

  GeneratedColumn<String> get notesText =>
      $composableBuilder(column: $table.notesText, builder: (column) => column);

  GeneratedColumn<String> get voiceTranscript => $composableBuilder(
      column: $table.voiceTranscript, builder: (column) => column);

  GeneratedColumn<bool> get safetyAcknowledged => $composableBuilder(
      column: $table.safetyAcknowledged, builder: (column) => column);
}

class $$PracticeSessionsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PracticeSessionsTableTable,
    PracticeSessionsTableData,
    $$PracticeSessionsTableTableFilterComposer,
    $$PracticeSessionsTableTableOrderingComposer,
    $$PracticeSessionsTableTableAnnotationComposer,
    $$PracticeSessionsTableTableCreateCompanionBuilder,
    $$PracticeSessionsTableTableUpdateCompanionBuilder,
    (
      PracticeSessionsTableData,
      BaseReferences<_$AppDatabase, $PracticeSessionsTableTable,
          PracticeSessionsTableData>
    ),
    PracticeSessionsTableData,
    PrefetchHooks Function()> {
  $$PracticeSessionsTableTableTableManager(
      _$AppDatabase db, $PracticeSessionsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PracticeSessionsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$PracticeSessionsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PracticeSessionsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> practiceId = const Value.absent(),
            Value<int> phaseNumber = const Value.absent(),
            Value<DateTime> startedAt = const Value.absent(),
            Value<DateTime?> endedAt = const Value.absent(),
            Value<int?> durationSeconds = const Value.absent(),
            Value<int> driftCount = const Value.absent(),
            Value<String?> driftTapLog = const Value.absent(),
            Value<double?> arousalBefore = const Value.absent(),
            Value<double?> arousalAfter = const Value.absent(),
            Value<double?> hrBefore = const Value.absent(),
            Value<double?> hrAfter = const Value.absent(),
            Value<double?> qualityScore = const Value.absent(),
            Value<String?> notesText = const Value.absent(),
            Value<String?> voiceTranscript = const Value.absent(),
            Value<bool> safetyAcknowledged = const Value.absent(),
          }) =>
              PracticeSessionsTableCompanion(
            id: id,
            practiceId: practiceId,
            phaseNumber: phaseNumber,
            startedAt: startedAt,
            endedAt: endedAt,
            durationSeconds: durationSeconds,
            driftCount: driftCount,
            driftTapLog: driftTapLog,
            arousalBefore: arousalBefore,
            arousalAfter: arousalAfter,
            hrBefore: hrBefore,
            hrAfter: hrAfter,
            qualityScore: qualityScore,
            notesText: notesText,
            voiceTranscript: voiceTranscript,
            safetyAcknowledged: safetyAcknowledged,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String practiceId,
            required int phaseNumber,
            required DateTime startedAt,
            Value<DateTime?> endedAt = const Value.absent(),
            Value<int?> durationSeconds = const Value.absent(),
            Value<int> driftCount = const Value.absent(),
            Value<String?> driftTapLog = const Value.absent(),
            Value<double?> arousalBefore = const Value.absent(),
            Value<double?> arousalAfter = const Value.absent(),
            Value<double?> hrBefore = const Value.absent(),
            Value<double?> hrAfter = const Value.absent(),
            Value<double?> qualityScore = const Value.absent(),
            Value<String?> notesText = const Value.absent(),
            Value<String?> voiceTranscript = const Value.absent(),
            Value<bool> safetyAcknowledged = const Value.absent(),
          }) =>
              PracticeSessionsTableCompanion.insert(
            id: id,
            practiceId: practiceId,
            phaseNumber: phaseNumber,
            startedAt: startedAt,
            endedAt: endedAt,
            durationSeconds: durationSeconds,
            driftCount: driftCount,
            driftTapLog: driftTapLog,
            arousalBefore: arousalBefore,
            arousalAfter: arousalAfter,
            hrBefore: hrBefore,
            hrAfter: hrAfter,
            qualityScore: qualityScore,
            notesText: notesText,
            voiceTranscript: voiceTranscript,
            safetyAcknowledged: safetyAcknowledged,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PracticeSessionsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $PracticeSessionsTableTable,
        PracticeSessionsTableData,
        $$PracticeSessionsTableTableFilterComposer,
        $$PracticeSessionsTableTableOrderingComposer,
        $$PracticeSessionsTableTableAnnotationComposer,
        $$PracticeSessionsTableTableCreateCompanionBuilder,
        $$PracticeSessionsTableTableUpdateCompanionBuilder,
        (
          PracticeSessionsTableData,
          BaseReferences<_$AppDatabase, $PracticeSessionsTableTable,
              PracticeSessionsTableData>
        ),
        PracticeSessionsTableData,
        PrefetchHooks Function()>;
typedef $$AssessmentResultsTableTableCreateCompanionBuilder
    = AssessmentResultsTableCompanion Function({
  Value<int> id,
  required String assessmentId,
  required int phaseNumber,
  required DateTime administeredAt,
  required String rawScores,
  Value<double?> totalScore,
  Value<String?> subscaleScores,
  Value<String?> environmentType,
  Value<String?> loadType,
  Value<double?> hrDeviceCount,
  Value<double?> hrUserEstimate,
});
typedef $$AssessmentResultsTableTableUpdateCompanionBuilder
    = AssessmentResultsTableCompanion Function({
  Value<int> id,
  Value<String> assessmentId,
  Value<int> phaseNumber,
  Value<DateTime> administeredAt,
  Value<String> rawScores,
  Value<double?> totalScore,
  Value<String?> subscaleScores,
  Value<String?> environmentType,
  Value<String?> loadType,
  Value<double?> hrDeviceCount,
  Value<double?> hrUserEstimate,
});

class $$AssessmentResultsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AssessmentResultsTableTable> {
  $$AssessmentResultsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get assessmentId => $composableBuilder(
      column: $table.assessmentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get administeredAt => $composableBuilder(
      column: $table.administeredAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rawScores => $composableBuilder(
      column: $table.rawScores, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalScore => $composableBuilder(
      column: $table.totalScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subscaleScores => $composableBuilder(
      column: $table.subscaleScores,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get environmentType => $composableBuilder(
      column: $table.environmentType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get loadType => $composableBuilder(
      column: $table.loadType, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get hrDeviceCount => $composableBuilder(
      column: $table.hrDeviceCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get hrUserEstimate => $composableBuilder(
      column: $table.hrUserEstimate,
      builder: (column) => ColumnFilters(column));
}

class $$AssessmentResultsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AssessmentResultsTableTable> {
  $$AssessmentResultsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get assessmentId => $composableBuilder(
      column: $table.assessmentId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get administeredAt => $composableBuilder(
      column: $table.administeredAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rawScores => $composableBuilder(
      column: $table.rawScores, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalScore => $composableBuilder(
      column: $table.totalScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subscaleScores => $composableBuilder(
      column: $table.subscaleScores,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get environmentType => $composableBuilder(
      column: $table.environmentType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get loadType => $composableBuilder(
      column: $table.loadType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get hrDeviceCount => $composableBuilder(
      column: $table.hrDeviceCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get hrUserEstimate => $composableBuilder(
      column: $table.hrUserEstimate,
      builder: (column) => ColumnOrderings(column));
}

class $$AssessmentResultsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssessmentResultsTableTable> {
  $$AssessmentResultsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get assessmentId => $composableBuilder(
      column: $table.assessmentId, builder: (column) => column);

  GeneratedColumn<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get administeredAt => $composableBuilder(
      column: $table.administeredAt, builder: (column) => column);

  GeneratedColumn<String> get rawScores =>
      $composableBuilder(column: $table.rawScores, builder: (column) => column);

  GeneratedColumn<double> get totalScore => $composableBuilder(
      column: $table.totalScore, builder: (column) => column);

  GeneratedColumn<String> get subscaleScores => $composableBuilder(
      column: $table.subscaleScores, builder: (column) => column);

  GeneratedColumn<String> get environmentType => $composableBuilder(
      column: $table.environmentType, builder: (column) => column);

  GeneratedColumn<String> get loadType =>
      $composableBuilder(column: $table.loadType, builder: (column) => column);

  GeneratedColumn<double> get hrDeviceCount => $composableBuilder(
      column: $table.hrDeviceCount, builder: (column) => column);

  GeneratedColumn<double> get hrUserEstimate => $composableBuilder(
      column: $table.hrUserEstimate, builder: (column) => column);
}

class $$AssessmentResultsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AssessmentResultsTableTable,
    AssessmentResultsTableData,
    $$AssessmentResultsTableTableFilterComposer,
    $$AssessmentResultsTableTableOrderingComposer,
    $$AssessmentResultsTableTableAnnotationComposer,
    $$AssessmentResultsTableTableCreateCompanionBuilder,
    $$AssessmentResultsTableTableUpdateCompanionBuilder,
    (
      AssessmentResultsTableData,
      BaseReferences<_$AppDatabase, $AssessmentResultsTableTable,
          AssessmentResultsTableData>
    ),
    AssessmentResultsTableData,
    PrefetchHooks Function()> {
  $$AssessmentResultsTableTableTableManager(
      _$AppDatabase db, $AssessmentResultsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssessmentResultsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$AssessmentResultsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssessmentResultsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> assessmentId = const Value.absent(),
            Value<int> phaseNumber = const Value.absent(),
            Value<DateTime> administeredAt = const Value.absent(),
            Value<String> rawScores = const Value.absent(),
            Value<double?> totalScore = const Value.absent(),
            Value<String?> subscaleScores = const Value.absent(),
            Value<String?> environmentType = const Value.absent(),
            Value<String?> loadType = const Value.absent(),
            Value<double?> hrDeviceCount = const Value.absent(),
            Value<double?> hrUserEstimate = const Value.absent(),
          }) =>
              AssessmentResultsTableCompanion(
            id: id,
            assessmentId: assessmentId,
            phaseNumber: phaseNumber,
            administeredAt: administeredAt,
            rawScores: rawScores,
            totalScore: totalScore,
            subscaleScores: subscaleScores,
            environmentType: environmentType,
            loadType: loadType,
            hrDeviceCount: hrDeviceCount,
            hrUserEstimate: hrUserEstimate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String assessmentId,
            required int phaseNumber,
            required DateTime administeredAt,
            required String rawScores,
            Value<double?> totalScore = const Value.absent(),
            Value<String?> subscaleScores = const Value.absent(),
            Value<String?> environmentType = const Value.absent(),
            Value<String?> loadType = const Value.absent(),
            Value<double?> hrDeviceCount = const Value.absent(),
            Value<double?> hrUserEstimate = const Value.absent(),
          }) =>
              AssessmentResultsTableCompanion.insert(
            id: id,
            assessmentId: assessmentId,
            phaseNumber: phaseNumber,
            administeredAt: administeredAt,
            rawScores: rawScores,
            totalScore: totalScore,
            subscaleScores: subscaleScores,
            environmentType: environmentType,
            loadType: loadType,
            hrDeviceCount: hrDeviceCount,
            hrUserEstimate: hrUserEstimate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AssessmentResultsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $AssessmentResultsTableTable,
        AssessmentResultsTableData,
        $$AssessmentResultsTableTableFilterComposer,
        $$AssessmentResultsTableTableOrderingComposer,
        $$AssessmentResultsTableTableAnnotationComposer,
        $$AssessmentResultsTableTableCreateCompanionBuilder,
        $$AssessmentResultsTableTableUpdateCompanionBuilder,
        (
          AssessmentResultsTableData,
          BaseReferences<_$AppDatabase, $AssessmentResultsTableTable,
              AssessmentResultsTableData>
        ),
        AssessmentResultsTableData,
        PrefetchHooks Function()>;
typedef $$JournalEntriesTableTableCreateCompanionBuilder
    = JournalEntriesTableCompanion Function({
  Value<int> id,
  Value<String?> templateId,
  required int phaseNumber,
  Value<String?> practiceId,
  Value<DateTime> createdAt,
  required String filePath,
  Value<int?> wordCount,
  Value<bool> transcriptionComplete,
});
typedef $$JournalEntriesTableTableUpdateCompanionBuilder
    = JournalEntriesTableCompanion Function({
  Value<int> id,
  Value<String?> templateId,
  Value<int> phaseNumber,
  Value<String?> practiceId,
  Value<DateTime> createdAt,
  Value<String> filePath,
  Value<int?> wordCount,
  Value<bool> transcriptionComplete,
});

class $$JournalEntriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $JournalEntriesTableTable> {
  $$JournalEntriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get templateId => $composableBuilder(
      column: $table.templateId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get practiceId => $composableBuilder(
      column: $table.practiceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get filePath => $composableBuilder(
      column: $table.filePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get wordCount => $composableBuilder(
      column: $table.wordCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get transcriptionComplete => $composableBuilder(
      column: $table.transcriptionComplete,
      builder: (column) => ColumnFilters(column));
}

class $$JournalEntriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalEntriesTableTable> {
  $$JournalEntriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get templateId => $composableBuilder(
      column: $table.templateId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get practiceId => $composableBuilder(
      column: $table.practiceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get filePath => $composableBuilder(
      column: $table.filePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get wordCount => $composableBuilder(
      column: $table.wordCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get transcriptionComplete => $composableBuilder(
      column: $table.transcriptionComplete,
      builder: (column) => ColumnOrderings(column));
}

class $$JournalEntriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalEntriesTableTable> {
  $$JournalEntriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get templateId => $composableBuilder(
      column: $table.templateId, builder: (column) => column);

  GeneratedColumn<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => column);

  GeneratedColumn<String> get practiceId => $composableBuilder(
      column: $table.practiceId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<int> get wordCount =>
      $composableBuilder(column: $table.wordCount, builder: (column) => column);

  GeneratedColumn<bool> get transcriptionComplete => $composableBuilder(
      column: $table.transcriptionComplete, builder: (column) => column);
}

class $$JournalEntriesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $JournalEntriesTableTable,
    JournalEntriesTableData,
    $$JournalEntriesTableTableFilterComposer,
    $$JournalEntriesTableTableOrderingComposer,
    $$JournalEntriesTableTableAnnotationComposer,
    $$JournalEntriesTableTableCreateCompanionBuilder,
    $$JournalEntriesTableTableUpdateCompanionBuilder,
    (
      JournalEntriesTableData,
      BaseReferences<_$AppDatabase, $JournalEntriesTableTable,
          JournalEntriesTableData>
    ),
    JournalEntriesTableData,
    PrefetchHooks Function()> {
  $$JournalEntriesTableTableTableManager(
      _$AppDatabase db, $JournalEntriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalEntriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalEntriesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalEntriesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> templateId = const Value.absent(),
            Value<int> phaseNumber = const Value.absent(),
            Value<String?> practiceId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String> filePath = const Value.absent(),
            Value<int?> wordCount = const Value.absent(),
            Value<bool> transcriptionComplete = const Value.absent(),
          }) =>
              JournalEntriesTableCompanion(
            id: id,
            templateId: templateId,
            phaseNumber: phaseNumber,
            practiceId: practiceId,
            createdAt: createdAt,
            filePath: filePath,
            wordCount: wordCount,
            transcriptionComplete: transcriptionComplete,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> templateId = const Value.absent(),
            required int phaseNumber,
            Value<String?> practiceId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            required String filePath,
            Value<int?> wordCount = const Value.absent(),
            Value<bool> transcriptionComplete = const Value.absent(),
          }) =>
              JournalEntriesTableCompanion.insert(
            id: id,
            templateId: templateId,
            phaseNumber: phaseNumber,
            practiceId: practiceId,
            createdAt: createdAt,
            filePath: filePath,
            wordCount: wordCount,
            transcriptionComplete: transcriptionComplete,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$JournalEntriesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $JournalEntriesTableTable,
    JournalEntriesTableData,
    $$JournalEntriesTableTableFilterComposer,
    $$JournalEntriesTableTableOrderingComposer,
    $$JournalEntriesTableTableAnnotationComposer,
    $$JournalEntriesTableTableCreateCompanionBuilder,
    $$JournalEntriesTableTableUpdateCompanionBuilder,
    (
      JournalEntriesTableData,
      BaseReferences<_$AppDatabase, $JournalEntriesTableTable,
          JournalEntriesTableData>
    ),
    JournalEntriesTableData,
    PrefetchHooks Function()>;
typedef $$GateStatesTableTableCreateCompanionBuilder = GateStatesTableCompanion
    Function({
  Value<int> id,
  required int gateNumber,
  Value<String> status,
  Value<int> attemptCount,
  Value<int?> phq9AtGate,
  Value<bool?> crisisIndicatorsClear,
  Value<String?> selfAssessmentText,
  Value<String?> blockReason,
  Value<DateTime?> lastAttemptedAt,
  Value<DateTime?> passedAt,
});
typedef $$GateStatesTableTableUpdateCompanionBuilder = GateStatesTableCompanion
    Function({
  Value<int> id,
  Value<int> gateNumber,
  Value<String> status,
  Value<int> attemptCount,
  Value<int?> phq9AtGate,
  Value<bool?> crisisIndicatorsClear,
  Value<String?> selfAssessmentText,
  Value<String?> blockReason,
  Value<DateTime?> lastAttemptedAt,
  Value<DateTime?> passedAt,
});

class $$GateStatesTableTableFilterComposer
    extends Composer<_$AppDatabase, $GateStatesTableTable> {
  $$GateStatesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get gateNumber => $composableBuilder(
      column: $table.gateNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get phq9AtGate => $composableBuilder(
      column: $table.phq9AtGate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get crisisIndicatorsClear => $composableBuilder(
      column: $table.crisisIndicatorsClear,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get selfAssessmentText => $composableBuilder(
      column: $table.selfAssessmentText,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get blockReason => $composableBuilder(
      column: $table.blockReason, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastAttemptedAt => $composableBuilder(
      column: $table.lastAttemptedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get passedAt => $composableBuilder(
      column: $table.passedAt, builder: (column) => ColumnFilters(column));
}

class $$GateStatesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GateStatesTableTable> {
  $$GateStatesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get gateNumber => $composableBuilder(
      column: $table.gateNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get phq9AtGate => $composableBuilder(
      column: $table.phq9AtGate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get crisisIndicatorsClear => $composableBuilder(
      column: $table.crisisIndicatorsClear,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get selfAssessmentText => $composableBuilder(
      column: $table.selfAssessmentText,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get blockReason => $composableBuilder(
      column: $table.blockReason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastAttemptedAt => $composableBuilder(
      column: $table.lastAttemptedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get passedAt => $composableBuilder(
      column: $table.passedAt, builder: (column) => ColumnOrderings(column));
}

class $$GateStatesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GateStatesTableTable> {
  $$GateStatesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get gateNumber => $composableBuilder(
      column: $table.gateNumber, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount, builder: (column) => column);

  GeneratedColumn<int> get phq9AtGate => $composableBuilder(
      column: $table.phq9AtGate, builder: (column) => column);

  GeneratedColumn<bool> get crisisIndicatorsClear => $composableBuilder(
      column: $table.crisisIndicatorsClear, builder: (column) => column);

  GeneratedColumn<String> get selfAssessmentText => $composableBuilder(
      column: $table.selfAssessmentText, builder: (column) => column);

  GeneratedColumn<String> get blockReason => $composableBuilder(
      column: $table.blockReason, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptedAt => $composableBuilder(
      column: $table.lastAttemptedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get passedAt =>
      $composableBuilder(column: $table.passedAt, builder: (column) => column);
}

class $$GateStatesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GateStatesTableTable,
    GateStatesTableData,
    $$GateStatesTableTableFilterComposer,
    $$GateStatesTableTableOrderingComposer,
    $$GateStatesTableTableAnnotationComposer,
    $$GateStatesTableTableCreateCompanionBuilder,
    $$GateStatesTableTableUpdateCompanionBuilder,
    (
      GateStatesTableData,
      BaseReferences<_$AppDatabase, $GateStatesTableTable, GateStatesTableData>
    ),
    GateStatesTableData,
    PrefetchHooks Function()> {
  $$GateStatesTableTableTableManager(
      _$AppDatabase db, $GateStatesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GateStatesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GateStatesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GateStatesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> gateNumber = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> attemptCount = const Value.absent(),
            Value<int?> phq9AtGate = const Value.absent(),
            Value<bool?> crisisIndicatorsClear = const Value.absent(),
            Value<String?> selfAssessmentText = const Value.absent(),
            Value<String?> blockReason = const Value.absent(),
            Value<DateTime?> lastAttemptedAt = const Value.absent(),
            Value<DateTime?> passedAt = const Value.absent(),
          }) =>
              GateStatesTableCompanion(
            id: id,
            gateNumber: gateNumber,
            status: status,
            attemptCount: attemptCount,
            phq9AtGate: phq9AtGate,
            crisisIndicatorsClear: crisisIndicatorsClear,
            selfAssessmentText: selfAssessmentText,
            blockReason: blockReason,
            lastAttemptedAt: lastAttemptedAt,
            passedAt: passedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int gateNumber,
            Value<String> status = const Value.absent(),
            Value<int> attemptCount = const Value.absent(),
            Value<int?> phq9AtGate = const Value.absent(),
            Value<bool?> crisisIndicatorsClear = const Value.absent(),
            Value<String?> selfAssessmentText = const Value.absent(),
            Value<String?> blockReason = const Value.absent(),
            Value<DateTime?> lastAttemptedAt = const Value.absent(),
            Value<DateTime?> passedAt = const Value.absent(),
          }) =>
              GateStatesTableCompanion.insert(
            id: id,
            gateNumber: gateNumber,
            status: status,
            attemptCount: attemptCount,
            phq9AtGate: phq9AtGate,
            crisisIndicatorsClear: crisisIndicatorsClear,
            selfAssessmentText: selfAssessmentText,
            blockReason: blockReason,
            lastAttemptedAt: lastAttemptedAt,
            passedAt: passedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GateStatesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GateStatesTableTable,
    GateStatesTableData,
    $$GateStatesTableTableFilterComposer,
    $$GateStatesTableTableOrderingComposer,
    $$GateStatesTableTableAnnotationComposer,
    $$GateStatesTableTableCreateCompanionBuilder,
    $$GateStatesTableTableUpdateCompanionBuilder,
    (
      GateStatesTableData,
      BaseReferences<_$AppDatabase, $GateStatesTableTable, GateStatesTableData>
    ),
    GateStatesTableData,
    PrefetchHooks Function()>;
typedef $$GateCriteriaStatesTableTableCreateCompanionBuilder
    = GateCriteriaStatesTableCompanion Function({
  Value<int> id,
  required int gateNumber,
  required String criterionId,
  required String track,
  required String domain,
  Value<String> status,
  Value<String?> value,
  Value<DateTime?> evaluatedAt,
  Value<int> attemptNumber,
});
typedef $$GateCriteriaStatesTableTableUpdateCompanionBuilder
    = GateCriteriaStatesTableCompanion Function({
  Value<int> id,
  Value<int> gateNumber,
  Value<String> criterionId,
  Value<String> track,
  Value<String> domain,
  Value<String> status,
  Value<String?> value,
  Value<DateTime?> evaluatedAt,
  Value<int> attemptNumber,
});

class $$GateCriteriaStatesTableTableFilterComposer
    extends Composer<_$AppDatabase, $GateCriteriaStatesTableTable> {
  $$GateCriteriaStatesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get gateNumber => $composableBuilder(
      column: $table.gateNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get criterionId => $composableBuilder(
      column: $table.criterionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get track => $composableBuilder(
      column: $table.track, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get domain => $composableBuilder(
      column: $table.domain, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get evaluatedAt => $composableBuilder(
      column: $table.evaluatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attemptNumber => $composableBuilder(
      column: $table.attemptNumber, builder: (column) => ColumnFilters(column));
}

class $$GateCriteriaStatesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GateCriteriaStatesTableTable> {
  $$GateCriteriaStatesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get gateNumber => $composableBuilder(
      column: $table.gateNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get criterionId => $composableBuilder(
      column: $table.criterionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get track => $composableBuilder(
      column: $table.track, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get domain => $composableBuilder(
      column: $table.domain, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get evaluatedAt => $composableBuilder(
      column: $table.evaluatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attemptNumber => $composableBuilder(
      column: $table.attemptNumber,
      builder: (column) => ColumnOrderings(column));
}

class $$GateCriteriaStatesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GateCriteriaStatesTableTable> {
  $$GateCriteriaStatesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get gateNumber => $composableBuilder(
      column: $table.gateNumber, builder: (column) => column);

  GeneratedColumn<String> get criterionId => $composableBuilder(
      column: $table.criterionId, builder: (column) => column);

  GeneratedColumn<String> get track =>
      $composableBuilder(column: $table.track, builder: (column) => column);

  GeneratedColumn<String> get domain =>
      $composableBuilder(column: $table.domain, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get evaluatedAt => $composableBuilder(
      column: $table.evaluatedAt, builder: (column) => column);

  GeneratedColumn<int> get attemptNumber => $composableBuilder(
      column: $table.attemptNumber, builder: (column) => column);
}

class $$GateCriteriaStatesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GateCriteriaStatesTableTable,
    GateCriteriaStatesTableData,
    $$GateCriteriaStatesTableTableFilterComposer,
    $$GateCriteriaStatesTableTableOrderingComposer,
    $$GateCriteriaStatesTableTableAnnotationComposer,
    $$GateCriteriaStatesTableTableCreateCompanionBuilder,
    $$GateCriteriaStatesTableTableUpdateCompanionBuilder,
    (
      GateCriteriaStatesTableData,
      BaseReferences<_$AppDatabase, $GateCriteriaStatesTableTable,
          GateCriteriaStatesTableData>
    ),
    GateCriteriaStatesTableData,
    PrefetchHooks Function()> {
  $$GateCriteriaStatesTableTableTableManager(
      _$AppDatabase db, $GateCriteriaStatesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GateCriteriaStatesTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$GateCriteriaStatesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GateCriteriaStatesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> gateNumber = const Value.absent(),
            Value<String> criterionId = const Value.absent(),
            Value<String> track = const Value.absent(),
            Value<String> domain = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> value = const Value.absent(),
            Value<DateTime?> evaluatedAt = const Value.absent(),
            Value<int> attemptNumber = const Value.absent(),
          }) =>
              GateCriteriaStatesTableCompanion(
            id: id,
            gateNumber: gateNumber,
            criterionId: criterionId,
            track: track,
            domain: domain,
            status: status,
            value: value,
            evaluatedAt: evaluatedAt,
            attemptNumber: attemptNumber,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int gateNumber,
            required String criterionId,
            required String track,
            required String domain,
            Value<String> status = const Value.absent(),
            Value<String?> value = const Value.absent(),
            Value<DateTime?> evaluatedAt = const Value.absent(),
            Value<int> attemptNumber = const Value.absent(),
          }) =>
              GateCriteriaStatesTableCompanion.insert(
            id: id,
            gateNumber: gateNumber,
            criterionId: criterionId,
            track: track,
            domain: domain,
            status: status,
            value: value,
            evaluatedAt: evaluatedAt,
            attemptNumber: attemptNumber,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GateCriteriaStatesTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $GateCriteriaStatesTableTable,
        GateCriteriaStatesTableData,
        $$GateCriteriaStatesTableTableFilterComposer,
        $$GateCriteriaStatesTableTableOrderingComposer,
        $$GateCriteriaStatesTableTableAnnotationComposer,
        $$GateCriteriaStatesTableTableCreateCompanionBuilder,
        $$GateCriteriaStatesTableTableUpdateCompanionBuilder,
        (
          GateCriteriaStatesTableData,
          BaseReferences<_$AppDatabase, $GateCriteriaStatesTableTable,
              GateCriteriaStatesTableData>
        ),
        GateCriteriaStatesTableData,
        PrefetchHooks Function()>;
typedef $$LongitudinalMetricsTableTableCreateCompanionBuilder
    = LongitudinalMetricsTableCompanion Function({
  Value<int> id,
  required String metricId,
  required int phaseNumber,
  required DateTime recordedAt,
  required double value,
  Value<int?> sourceAssessmentId,
});
typedef $$LongitudinalMetricsTableTableUpdateCompanionBuilder
    = LongitudinalMetricsTableCompanion Function({
  Value<int> id,
  Value<String> metricId,
  Value<int> phaseNumber,
  Value<DateTime> recordedAt,
  Value<double> value,
  Value<int?> sourceAssessmentId,
});

class $$LongitudinalMetricsTableTableFilterComposer
    extends Composer<_$AppDatabase, $LongitudinalMetricsTableTable> {
  $$LongitudinalMetricsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metricId => $composableBuilder(
      column: $table.metricId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sourceAssessmentId => $composableBuilder(
      column: $table.sourceAssessmentId,
      builder: (column) => ColumnFilters(column));
}

class $$LongitudinalMetricsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LongitudinalMetricsTableTable> {
  $$LongitudinalMetricsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metricId => $composableBuilder(
      column: $table.metricId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sourceAssessmentId => $composableBuilder(
      column: $table.sourceAssessmentId,
      builder: (column) => ColumnOrderings(column));
}

class $$LongitudinalMetricsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LongitudinalMetricsTableTable> {
  $$LongitudinalMetricsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get metricId =>
      $composableBuilder(column: $table.metricId, builder: (column) => column);

  GeneratedColumn<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<int> get sourceAssessmentId => $composableBuilder(
      column: $table.sourceAssessmentId, builder: (column) => column);
}

class $$LongitudinalMetricsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LongitudinalMetricsTableTable,
    LongitudinalMetricsTableData,
    $$LongitudinalMetricsTableTableFilterComposer,
    $$LongitudinalMetricsTableTableOrderingComposer,
    $$LongitudinalMetricsTableTableAnnotationComposer,
    $$LongitudinalMetricsTableTableCreateCompanionBuilder,
    $$LongitudinalMetricsTableTableUpdateCompanionBuilder,
    (
      LongitudinalMetricsTableData,
      BaseReferences<_$AppDatabase, $LongitudinalMetricsTableTable,
          LongitudinalMetricsTableData>
    ),
    LongitudinalMetricsTableData,
    PrefetchHooks Function()> {
  $$LongitudinalMetricsTableTableTableManager(
      _$AppDatabase db, $LongitudinalMetricsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LongitudinalMetricsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$LongitudinalMetricsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LongitudinalMetricsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> metricId = const Value.absent(),
            Value<int> phaseNumber = const Value.absent(),
            Value<DateTime> recordedAt = const Value.absent(),
            Value<double> value = const Value.absent(),
            Value<int?> sourceAssessmentId = const Value.absent(),
          }) =>
              LongitudinalMetricsTableCompanion(
            id: id,
            metricId: metricId,
            phaseNumber: phaseNumber,
            recordedAt: recordedAt,
            value: value,
            sourceAssessmentId: sourceAssessmentId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String metricId,
            required int phaseNumber,
            required DateTime recordedAt,
            required double value,
            Value<int?> sourceAssessmentId = const Value.absent(),
          }) =>
              LongitudinalMetricsTableCompanion.insert(
            id: id,
            metricId: metricId,
            phaseNumber: phaseNumber,
            recordedAt: recordedAt,
            value: value,
            sourceAssessmentId: sourceAssessmentId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LongitudinalMetricsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $LongitudinalMetricsTableTable,
        LongitudinalMetricsTableData,
        $$LongitudinalMetricsTableTableFilterComposer,
        $$LongitudinalMetricsTableTableOrderingComposer,
        $$LongitudinalMetricsTableTableAnnotationComposer,
        $$LongitudinalMetricsTableTableCreateCompanionBuilder,
        $$LongitudinalMetricsTableTableUpdateCompanionBuilder,
        (
          LongitudinalMetricsTableData,
          BaseReferences<_$AppDatabase, $LongitudinalMetricsTableTable,
              LongitudinalMetricsTableData>
        ),
        LongitudinalMetricsTableData,
        PrefetchHooks Function()>;
typedef $$ScheduledAlarmsTableTableCreateCompanionBuilder
    = ScheduledAlarmsTableCompanion Function({
  Value<int> id,
  required String alarmType,
  required DateTime scheduledFor,
  Value<DateTime?> firedAt,
  Value<DateTime?> respondedAt,
  Value<String?> responseJson,
  required int phaseNumber,
});
typedef $$ScheduledAlarmsTableTableUpdateCompanionBuilder
    = ScheduledAlarmsTableCompanion Function({
  Value<int> id,
  Value<String> alarmType,
  Value<DateTime> scheduledFor,
  Value<DateTime?> firedAt,
  Value<DateTime?> respondedAt,
  Value<String?> responseJson,
  Value<int> phaseNumber,
});

class $$ScheduledAlarmsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ScheduledAlarmsTableTable> {
  $$ScheduledAlarmsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get alarmType => $composableBuilder(
      column: $table.alarmType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get scheduledFor => $composableBuilder(
      column: $table.scheduledFor, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get firedAt => $composableBuilder(
      column: $table.firedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get respondedAt => $composableBuilder(
      column: $table.respondedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get responseJson => $composableBuilder(
      column: $table.responseJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => ColumnFilters(column));
}

class $$ScheduledAlarmsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ScheduledAlarmsTableTable> {
  $$ScheduledAlarmsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get alarmType => $composableBuilder(
      column: $table.alarmType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get scheduledFor => $composableBuilder(
      column: $table.scheduledFor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get firedAt => $composableBuilder(
      column: $table.firedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get respondedAt => $composableBuilder(
      column: $table.respondedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get responseJson => $composableBuilder(
      column: $table.responseJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => ColumnOrderings(column));
}

class $$ScheduledAlarmsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScheduledAlarmsTableTable> {
  $$ScheduledAlarmsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get alarmType =>
      $composableBuilder(column: $table.alarmType, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledFor => $composableBuilder(
      column: $table.scheduledFor, builder: (column) => column);

  GeneratedColumn<DateTime> get firedAt =>
      $composableBuilder(column: $table.firedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get respondedAt => $composableBuilder(
      column: $table.respondedAt, builder: (column) => column);

  GeneratedColumn<String> get responseJson => $composableBuilder(
      column: $table.responseJson, builder: (column) => column);

  GeneratedColumn<int> get phaseNumber => $composableBuilder(
      column: $table.phaseNumber, builder: (column) => column);
}

class $$ScheduledAlarmsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ScheduledAlarmsTableTable,
    ScheduledAlarmsTableData,
    $$ScheduledAlarmsTableTableFilterComposer,
    $$ScheduledAlarmsTableTableOrderingComposer,
    $$ScheduledAlarmsTableTableAnnotationComposer,
    $$ScheduledAlarmsTableTableCreateCompanionBuilder,
    $$ScheduledAlarmsTableTableUpdateCompanionBuilder,
    (
      ScheduledAlarmsTableData,
      BaseReferences<_$AppDatabase, $ScheduledAlarmsTableTable,
          ScheduledAlarmsTableData>
    ),
    ScheduledAlarmsTableData,
    PrefetchHooks Function()> {
  $$ScheduledAlarmsTableTableTableManager(
      _$AppDatabase db, $ScheduledAlarmsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduledAlarmsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScheduledAlarmsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScheduledAlarmsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> alarmType = const Value.absent(),
            Value<DateTime> scheduledFor = const Value.absent(),
            Value<DateTime?> firedAt = const Value.absent(),
            Value<DateTime?> respondedAt = const Value.absent(),
            Value<String?> responseJson = const Value.absent(),
            Value<int> phaseNumber = const Value.absent(),
          }) =>
              ScheduledAlarmsTableCompanion(
            id: id,
            alarmType: alarmType,
            scheduledFor: scheduledFor,
            firedAt: firedAt,
            respondedAt: respondedAt,
            responseJson: responseJson,
            phaseNumber: phaseNumber,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String alarmType,
            required DateTime scheduledFor,
            Value<DateTime?> firedAt = const Value.absent(),
            Value<DateTime?> respondedAt = const Value.absent(),
            Value<String?> responseJson = const Value.absent(),
            required int phaseNumber,
          }) =>
              ScheduledAlarmsTableCompanion.insert(
            id: id,
            alarmType: alarmType,
            scheduledFor: scheduledFor,
            firedAt: firedAt,
            respondedAt: respondedAt,
            responseJson: responseJson,
            phaseNumber: phaseNumber,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ScheduledAlarmsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ScheduledAlarmsTableTable,
        ScheduledAlarmsTableData,
        $$ScheduledAlarmsTableTableFilterComposer,
        $$ScheduledAlarmsTableTableOrderingComposer,
        $$ScheduledAlarmsTableTableAnnotationComposer,
        $$ScheduledAlarmsTableTableCreateCompanionBuilder,
        $$ScheduledAlarmsTableTableUpdateCompanionBuilder,
        (
          ScheduledAlarmsTableData,
          BaseReferences<_$AppDatabase, $ScheduledAlarmsTableTable,
              ScheduledAlarmsTableData>
        ),
        ScheduledAlarmsTableData,
        PrefetchHooks Function()>;
typedef $$StatsQueueTableTableCreateCompanionBuilder = StatsQueueTableCompanion
    Function({
  Value<int> id,
  Value<int> schemaVersion,
  required String eventType,
  required String payloadJson,
  Value<DateTime> createdAt,
  Value<DateTime?> submittedAt,
});
typedef $$StatsQueueTableTableUpdateCompanionBuilder = StatsQueueTableCompanion
    Function({
  Value<int> id,
  Value<int> schemaVersion,
  Value<String> eventType,
  Value<String> payloadJson,
  Value<DateTime> createdAt,
  Value<DateTime?> submittedAt,
});

class $$StatsQueueTableTableFilterComposer
    extends Composer<_$AppDatabase, $StatsQueueTableTable> {
  $$StatsQueueTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get schemaVersion => $composableBuilder(
      column: $table.schemaVersion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventType => $composableBuilder(
      column: $table.eventType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get submittedAt => $composableBuilder(
      column: $table.submittedAt, builder: (column) => ColumnFilters(column));
}

class $$StatsQueueTableTableOrderingComposer
    extends Composer<_$AppDatabase, $StatsQueueTableTable> {
  $$StatsQueueTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get schemaVersion => $composableBuilder(
      column: $table.schemaVersion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eventType => $composableBuilder(
      column: $table.eventType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get submittedAt => $composableBuilder(
      column: $table.submittedAt, builder: (column) => ColumnOrderings(column));
}

class $$StatsQueueTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $StatsQueueTableTable> {
  $$StatsQueueTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get schemaVersion => $composableBuilder(
      column: $table.schemaVersion, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get submittedAt => $composableBuilder(
      column: $table.submittedAt, builder: (column) => column);
}

class $$StatsQueueTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StatsQueueTableTable,
    StatsQueueTableData,
    $$StatsQueueTableTableFilterComposer,
    $$StatsQueueTableTableOrderingComposer,
    $$StatsQueueTableTableAnnotationComposer,
    $$StatsQueueTableTableCreateCompanionBuilder,
    $$StatsQueueTableTableUpdateCompanionBuilder,
    (
      StatsQueueTableData,
      BaseReferences<_$AppDatabase, $StatsQueueTableTable, StatsQueueTableData>
    ),
    StatsQueueTableData,
    PrefetchHooks Function()> {
  $$StatsQueueTableTableTableManager(
      _$AppDatabase db, $StatsQueueTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StatsQueueTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StatsQueueTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StatsQueueTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> schemaVersion = const Value.absent(),
            Value<String> eventType = const Value.absent(),
            Value<String> payloadJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> submittedAt = const Value.absent(),
          }) =>
              StatsQueueTableCompanion(
            id: id,
            schemaVersion: schemaVersion,
            eventType: eventType,
            payloadJson: payloadJson,
            createdAt: createdAt,
            submittedAt: submittedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> schemaVersion = const Value.absent(),
            required String eventType,
            required String payloadJson,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> submittedAt = const Value.absent(),
          }) =>
              StatsQueueTableCompanion.insert(
            id: id,
            schemaVersion: schemaVersion,
            eventType: eventType,
            payloadJson: payloadJson,
            createdAt: createdAt,
            submittedAt: submittedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$StatsQueueTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StatsQueueTableTable,
    StatsQueueTableData,
    $$StatsQueueTableTableFilterComposer,
    $$StatsQueueTableTableOrderingComposer,
    $$StatsQueueTableTableAnnotationComposer,
    $$StatsQueueTableTableCreateCompanionBuilder,
    $$StatsQueueTableTableUpdateCompanionBuilder,
    (
      StatsQueueTableData,
      BaseReferences<_$AppDatabase, $StatsQueueTableTable, StatsQueueTableData>
    ),
    StatsQueueTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserStateTableTableTableManager get userStateTable =>
      $$UserStateTableTableTableManager(_db, _db.userStateTable);
  $$PhaseProgressTableTableTableManager get phaseProgressTable =>
      $$PhaseProgressTableTableTableManager(_db, _db.phaseProgressTable);
  $$PracticeSessionsTableTableTableManager get practiceSessionsTable =>
      $$PracticeSessionsTableTableTableManager(_db, _db.practiceSessionsTable);
  $$AssessmentResultsTableTableTableManager get assessmentResultsTable =>
      $$AssessmentResultsTableTableTableManager(
          _db, _db.assessmentResultsTable);
  $$JournalEntriesTableTableTableManager get journalEntriesTable =>
      $$JournalEntriesTableTableTableManager(_db, _db.journalEntriesTable);
  $$GateStatesTableTableTableManager get gateStatesTable =>
      $$GateStatesTableTableTableManager(_db, _db.gateStatesTable);
  $$GateCriteriaStatesTableTableTableManager get gateCriteriaStatesTable =>
      $$GateCriteriaStatesTableTableTableManager(
          _db, _db.gateCriteriaStatesTable);
  $$LongitudinalMetricsTableTableTableManager get longitudinalMetricsTable =>
      $$LongitudinalMetricsTableTableTableManager(
          _db, _db.longitudinalMetricsTable);
  $$ScheduledAlarmsTableTableTableManager get scheduledAlarmsTable =>
      $$ScheduledAlarmsTableTableTableManager(_db, _db.scheduledAlarmsTable);
  $$StatsQueueTableTableTableManager get statsQueueTable =>
      $$StatsQueueTableTableTableManager(_db, _db.statsQueueTable);
}
