import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> setupEmulators() async {
  // Uncomment this line if using Firebase Auth Emulator
  // await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);

  FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080);
  FirebaseStorage.instance.useStorageEmulator('127.0.0.1', 9199);
  FirebaseFunctions.instance.useFunctionsEmulator('127.0.0.1', 5001);
}
