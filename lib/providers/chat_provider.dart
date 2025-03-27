import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message.dart';

final chatStreamProvider = StreamProvider.autoDispose<List<Message>>((ref) {
  final snapshots =
      FirebaseFirestore.instance
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots();

  return snapshots.map(
    (snapshot) =>
        snapshot.docs
            .map(
              (doc) => Message(
                id: doc.id,
                text: doc['text'],
                userName: doc['userName'],
                userImage: doc['userImage'],
                timestamp: (doc['timestamp'] as Timestamp).toDate(),
              ),
            )
            .toList(),
  );
});
