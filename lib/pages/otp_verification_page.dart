import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:swap_cust_app/constants/constants.dart';
import 'package:swap_cust_app/pages/bottom_nav_bar.dart';
import 'package:swap_cust_app/services/database.dart';
import 'package:swap_cust_app/widgets/custom_elevated_button.dart';

class OtpVerificationPage extends StatefulWidget {
  final String username;
  final String mobileNumberController;
  final String verificationId;
  const OtpVerificationPage(
      {super.key,
      required this.username,
      required this.mobileNumberController,
      required this.verificationId});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  int totalCreditRedeemed = 0;
  int creditBalance = 0;
  final db = Database();
  String smsCode = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.10,
            ),
            Center(
              child: Container(
                height: size.height * 0.40,
                width: size.width * 0.70,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(otp), fit: BoxFit.cover)),
              ),
            ),
            Text(
              "You'll recieve 4 digit code\n to verify next",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            OtpTextField(
              numberOfFields: 6,
              borderColor: Theme.of(context).primaryColor,
              clearText: true,
              showFieldAsBox: true,
              fieldWidth: 40,
              handleControllers: (controllers) {
                smsCode = controllers.join();
              },
              focusedBorderColor: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Sent code again",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            CustomElevatedButton(
                text: "Verify OTP",
                onPressed: () async {
                  try {
                    final cred = PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode: smsCode);
                    await FirebaseAuth.instance.signInWithCredential(cred);
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(e.toString()),
                      ));
                    }
                  }

                  if (context.mounted) {
                    db.createData(context, data: {
                      "username": widget.username,
                      "mobileNumber": widget.mobileNumberController,
                      "totalCreditRedeemed": totalCreditRedeemed,
                      "creditBalance": creditBalance
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNavBar()),
                        (Route<dynamic> route) => false);
                  }
                },
                backgroundColor: Theme.of(context).primaryColor)
          ],
        ),
      ),
    );
  }
}
