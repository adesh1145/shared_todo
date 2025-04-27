import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_detail.freezed.dart';
part 'user_detail.g.dart';

@freezed
abstract class UserDetail with _$UserDetail {
  const factory UserDetail({
    @Default('') String? uid,
    @Default('') String? email,
    @Default('') String? name,
    String? photoUrl,
    @Default('') String? source,
  }) = _UserDetail;

  factory UserDetail.fromJson(Map<String, dynamic> json) =>
      _$UserDetailFromJson(json);
}
