import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthendicationService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> createUser(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
