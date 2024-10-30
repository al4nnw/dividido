import 'dart:developer';
import 'package:dividido/ui/screens/routes/root_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

class SignIn extends ConsumerWidget {
  const SignIn({super.key});

  Future<void> _signInWithGoogle(context) async {
    // Initialize Firestore
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    log("[_signInWithGoogle] Signing in with Google");
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      log("[_signInWithGoogle] Google user: $googleUser");
      if (googleUser == null) {
        // The user canceled the sign-in
        log("[_signInWithGoogle] User canceled the sign-in");
        return;
      }
      log("[_signInWithGoogle] User signed in: ${googleUser.displayName}");
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      log("[_signInWithGoogle] Signing in with credential: $credential");
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      log("[_signInWithGoogle] Signed in with Google");

      // Get the signed-in user
      User? user = userCredential.user;

      if (user != null) {
        // Save user info to Firestore
        await firestore.collection('users').doc(user.uid).set({
          'displayName': user.displayName,
          'email': user.email,
          'photoURL': user.photoURL,
          'uid': user.uid,
        }, SetOptions(merge: true));
        log("[_signInWithGoogle] User document created/updated in Firestore");
      }

      // Navigate to the home screen
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RootNavigator()));
    } catch (e) {
      log("[_signInWithGoogle] Error while signing in: ${e.toString()}");
      if (e is FirebaseAuthException) {
        log("[_signInWithGoogle] ${e.message}");
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Sign in to Dividido"),
          ElevatedButton(
              onPressed: () async {
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();
              },
              child: const Text(
                "Sign out",
              )),
          authState.when(
            data: (user) {
              return ElevatedButton(
                onPressed: () => _signInWithGoogle(context),
                child: const Text('Sign In with Google'),
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
          ),
        ],
      ),
    );
  }
}
