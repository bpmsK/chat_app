import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user.dart';

final authProvider = StateProvider<AppUser?>((ref) => null);

final authControllerProvider = Provider<AuthController>((ref) {
  return AuthController(ref);
});

class AuthController {
  AuthController(this.ref);
  final Ref ref;

  Future<void> signIn() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    ref.read(authProvider.notifier).state = AppUser(
      uid: userCredential.user!.uid,
      name: userCredential.user!.displayName ?? '匿名',
      imageUrl:
          userCredential.user!.photoURL ?? 'https://via.placeholder.com/150',
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    ref.read(authProvider.notifier).state = null;
  }
}
