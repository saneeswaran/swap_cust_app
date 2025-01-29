import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:swap_cust_app/firebase_options.dart';
import 'package:swap_cust_app/services/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "swap shop",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xff2797FF),
          scaffoldBackgroundColor: Color.fromRGBO(255, 247, 255, 1)),
      home: AuthGate(),
    );
  }
}
