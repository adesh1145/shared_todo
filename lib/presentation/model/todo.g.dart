// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Todo _$TodoFromJson(Map<String, dynamic> json) => _Todo(
      todoId: json['todoId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      ownerId: json['ownerId'] as String? ?? '',
      sharedWith: (json['sharedWith'] as List<dynamic>?)
              ?.map((e) => SharedWithUser.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      timestamp: TimestampConverter.fromJson(json['timestamp']),
    );

Map<String, dynamic> _$TodoToJson(_Todo instance) => <String, dynamic>{
      'todoId': instance.todoId,
      'title': instance.title,
      'description': instance.description,
      'ownerId': instance.ownerId,
      'sharedWith': instance.sharedWith,
      'timestamp': TimestampConverter.toJson(instance.timestamp),
    };

_SharedWithUser _$SharedWithUserFromJson(Map<String, dynamic> json) =>
    _SharedWithUser(
      uid: json['uid'] as String? ?? '',
      permission: json['permission'] as String? ?? '',
    );

Map<String, dynamic> _$SharedWithUserToJson(_SharedWithUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'permission': instance.permission,
    };
