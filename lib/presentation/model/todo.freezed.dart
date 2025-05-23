// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Todo {
  String get todoId;
  String get title;
  String get description;
  String get ownerId;
  List<String> get sharedWith;
  @JsonKey(
      fromJson: TimestampConverter.fromJson, toJson: TimestampConverter.toJson)
  Timestamp? get timestamp;

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TodoCopyWith<Todo> get copyWith =>
      _$TodoCopyWithImpl<Todo>(this as Todo, _$identity);

  /// Serializes this Todo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Todo &&
            (identical(other.todoId, todoId) || other.todoId == todoId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality()
                .equals(other.sharedWith, sharedWith) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, todoId, title, description,
      ownerId, const DeepCollectionEquality().hash(sharedWith), timestamp);

  @override
  String toString() {
    return 'Todo(todoId: $todoId, title: $title, description: $description, ownerId: $ownerId, sharedWith: $sharedWith, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $TodoCopyWith<$Res> {
  factory $TodoCopyWith(Todo value, $Res Function(Todo) _then) =
      _$TodoCopyWithImpl;
  @useResult
  $Res call(
      {String todoId,
      String title,
      String description,
      String ownerId,
      List<String> sharedWith,
      @JsonKey(
          fromJson: TimestampConverter.fromJson,
          toJson: TimestampConverter.toJson)
      Timestamp? timestamp});
}

/// @nodoc
class _$TodoCopyWithImpl<$Res> implements $TodoCopyWith<$Res> {
  _$TodoCopyWithImpl(this._self, this._then);

  final Todo _self;
  final $Res Function(Todo) _then;

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todoId = null,
    Object? title = null,
    Object? description = null,
    Object? ownerId = null,
    Object? sharedWith = null,
    Object? timestamp = freezed,
  }) {
    return _then(_self.copyWith(
      todoId: null == todoId
          ? _self.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _self.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      sharedWith: null == sharedWith
          ? _self.sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Todo implements Todo {
  const _Todo(
      {this.todoId = '',
      this.title = '',
      this.description = '',
      this.ownerId = '',
      final List<String> sharedWith = const [],
      @JsonKey(
          fromJson: TimestampConverter.fromJson,
          toJson: TimestampConverter.toJson)
      this.timestamp})
      : _sharedWith = sharedWith;
  factory _Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  @override
  @JsonKey()
  final String todoId;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String ownerId;
  final List<String> _sharedWith;
  @override
  @JsonKey()
  List<String> get sharedWith {
    if (_sharedWith is EqualUnmodifiableListView) return _sharedWith;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sharedWith);
  }

  @override
  @JsonKey(
      fromJson: TimestampConverter.fromJson, toJson: TimestampConverter.toJson)
  final Timestamp? timestamp;

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TodoCopyWith<_Todo> get copyWith =>
      __$TodoCopyWithImpl<_Todo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TodoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Todo &&
            (identical(other.todoId, todoId) || other.todoId == todoId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality()
                .equals(other._sharedWith, _sharedWith) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, todoId, title, description,
      ownerId, const DeepCollectionEquality().hash(_sharedWith), timestamp);

  @override
  String toString() {
    return 'Todo(todoId: $todoId, title: $title, description: $description, ownerId: $ownerId, sharedWith: $sharedWith, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$TodoCopyWith<$Res> implements $TodoCopyWith<$Res> {
  factory _$TodoCopyWith(_Todo value, $Res Function(_Todo) _then) =
      __$TodoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String todoId,
      String title,
      String description,
      String ownerId,
      List<String> sharedWith,
      @JsonKey(
          fromJson: TimestampConverter.fromJson,
          toJson: TimestampConverter.toJson)
      Timestamp? timestamp});
}

/// @nodoc
class __$TodoCopyWithImpl<$Res> implements _$TodoCopyWith<$Res> {
  __$TodoCopyWithImpl(this._self, this._then);

  final _Todo _self;
  final $Res Function(_Todo) _then;

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? todoId = null,
    Object? title = null,
    Object? description = null,
    Object? ownerId = null,
    Object? sharedWith = null,
    Object? timestamp = freezed,
  }) {
    return _then(_Todo(
      todoId: null == todoId
          ? _self.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _self.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      sharedWith: null == sharedWith
          ? _self._sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
    ));
  }
}

// dart format on
