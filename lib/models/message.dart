import 'package:freezed_annotation/freezed_annotation.dart';
part 'message.freezed.dart';

@freezed
class Message with _$Message {
  factory Message({
    required String id,
    required String text,
    required String userName,
    required String userImage,
    required DateTime timestamp,
  }) = _Message;
}
