import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swap_cust_app/pages/screens/auth_screen/login/login_page.dart';
import 'package:swap_cust_app/pages/screens/auth_screen/login/provider/auth_provider.dart';

import 'pages/screens/auth_screen/register/registration_page.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "swap shop",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xff2797FF),
          scaffoldBackgroundColor: Color.fromRGBO(255, 247, 255, 1)),
      home: LoginPage(),
    );
  }
}
