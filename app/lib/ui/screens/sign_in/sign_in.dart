import 'dart:developer';
import 'package:dividido/ui/screens/routes/root_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

class SignIn extends ConsumerWidget {
  const SignIn({super.key});

  Future<void> _signInWithGoogle(context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        log("[_signInWithGoogle] User canceled the sign-in");
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      /// Navigate to the home screen
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RootNavigator()));
    } catch (e) {
      log("[_signInWithGoogle] Error while signing in: $e");
      return;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      body: Center(
        child: authState.when(
          data: (user) {
            return ElevatedButton(
              onPressed: () => _signInWithGoogle(context),
              child: const Text('Sign In with Google'),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
      ),
    );
  }
}
