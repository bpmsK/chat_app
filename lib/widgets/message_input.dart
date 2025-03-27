import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class MessageInput extends StatelessWidget {
  final AppUser user;
  const MessageInput({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'メッセージ入力'),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            FirebaseFirestore.instance.collection('messages').add({
              'text': controller.text,
              'userName': user.name,
              'userImage': user.imageUrl,
              'timestamp': Timestamp.now(),
            });
            controller.clear();
          },
        ),
      ],
    );
  }
}
