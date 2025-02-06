import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swap_cust_app/util/app_validator.dart';
import 'package:swap_cust_app/widgets/custom_elevated_button.dart';
import 'package:swap_cust_app/widgets/custom_text_form_field.dart';

import '../bottom_nav_bar/bottom_nav_bar.dart';
import 'otp_verification_page.dart';
import 'registration_page.dart';

class LoginWithMobileNumberPage extends StatefulWidget {
  const LoginWithMobileNumberPage({super.key});

  @override
  State<LoginWithMobileNumberPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginWithMobileNumberPage> {
  //controllers
  final usernameController = TextEditingController();
  final mobileNumberController = TextEditingController();

//classes
  final appvalidator = Appvalidator();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: size.height * 0.08,
          children: [
            Container(
              height: size.height * 0.30,
              width: size.width * 1,
              decoration: BoxDecoration(color: Colors.grey),
              child: Center(
                child: Text("Image"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                spacing: size.height * 0.03,
                children: [
                  CustomTextFormField(
                    labelText: "Username",
                    controller: usernameController,
                    validator: appvalidator.emailValidator,
                  ),
                  CustomTextFormField(
                    labelText: "Mobile number",
                    controller: mobileNumberController,
                    validator: appvalidator.mobileNumberValidator,
                  ),

                  SizedBox(
                    height: size.height * 0.06,
                    width: size.width * 0.66,
                    child: CustomElevatedButton(
                      text: "Get OTP",
                      onPressed: () async {
                        if (usernameController.text.isEmpty ||
                            mobileNumberController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Please fill the details")));
                        }
                        await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: mobileNumberController.text,
                            verificationCompleted: (phoneAuthCredential) {
                              FirebaseAuth.instance
                                  .signInWithCredential(phoneAuthCredential)
                                  .then((userCredential) {
                                if (context.mounted) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavBar()));
                                }
                              }).catchError((error) {
                                log("Verification Completed Error: $error");
                              });
                            },
                            verificationFailed: (error) {
                              log("Verification Failed: ${error.message}");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Verification Failed: ${error.message}"),
                                ),
                              );
                            },
                            codeSent: (verificationId, forceResendingToken) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OtpVerificationPage(
                                            verificationId: verificationId,
                                            username: usernameController.text,
                                            mobileNumberController:
                                                mobileNumberController.text,
                                          )));
                            },
                            codeAutoRetrievalTimeout: (verificationId) {
                              log("Auto Retrival Timeout");
                            });
                      },
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  //or sign up with text
                  Text("Or Sign Up with"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationPage()));
                    },
                    child: Text("Sign in with email"),
                  ),
                  //continue with google
                  SizedBox(
                    height: size.height * 0.06,
                    width: size.width * 0.66,
                    child: CustomOutlinedButton(
                      text: "Continue with Google",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavBar()));
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
