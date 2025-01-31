import 'package:flutter/material.dart';
import 'package:swap_cust_app/constants/constants.dart';
import 'package:swap_cust_app/pages/registration_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => RegistrationPage()));
      }
    });

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.20,
          ),
          Container(
            height: size.height * 0.20,
            width: size.width * 1,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(signInImage), fit: BoxFit.cover)),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          )
        ],
      ),
    );
  }
}
