import 'package:firebase_auth/firebase_auth.dart';

class AuthendicationService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await auth.signOut();
  }
}
