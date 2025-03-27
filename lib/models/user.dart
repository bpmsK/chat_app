import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';

@freezed
class AppUser with _$AppUser {
  factory AppUser({
    required String uid,
    required String name,
    required String imageUrl,
  }) = _AppUser;
}
