import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/chat_provider.dart';

class MessageList extends ConsumerWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(chatStreamProvider);
    return messagesAsync.when(
      data:
          (messages) => ListView(
            reverse: true,
            children:
                messages
                    .map(
                      (msg) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(msg.userImage),
                        ),
                        title: Text(msg.userName),
                        subtitle: Text(msg.text),
                      ),
                    )
                    .toList(),
          ),
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const Text('エラーが発生しました'),
    );
  }
}
