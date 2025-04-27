import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

class TimestampConverter {
  static Timestamp? fromJson(dynamic json) {
    if (json is int) {
      return Timestamp.fromMillisecondsSinceEpoch(json);
    } else if (json is Timestamp) {
      return json;
    }
    return null;
  }

  static int? toJson(Timestamp? timestamp) {
    return timestamp?.millisecondsSinceEpoch;
  }
}

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    @Default('') String todoId,
    @Default('') String title,
    @Default('') String description,
    @Default('') String ownerId,
    @Default([]) List<String> sharedWith,
    @JsonKey(
        fromJson: TimestampConverter.fromJson,
        toJson: TimestampConverter.toJson)
    Timestamp? timestamp,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
