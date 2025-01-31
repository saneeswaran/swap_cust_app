import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swap_cust_app/pages/registration_page.dart';
import 'package:swap_cust_app/pages/splash_page.dart';

import '../pages/bottom_nav_bar.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashPage();
          }
          return snapshot.hasData ? const BottomNavBar() : RegistrationPage();
        });
  }
}
