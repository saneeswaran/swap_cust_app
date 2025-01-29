import 'package:flutter/material.dart';
import 'package:swap_cust_app/pages/bottom_nav_bar.dart';
import 'package:swap_cust_app/services/authendication_service.dart';
import 'package:swap_cust_app/widgets/custom_elevated_button.dart';
import 'package:swap_cust_app/widgets/custom_text_form_field.dart';

import '../services/database.dart';
import '../util/app_validator.dart';

class EmailSigninPage extends StatefulWidget {
  const EmailSigninPage({super.key});

  @override
  State<EmailSigninPage> createState() => _EmailSigninPageState();
}

class _EmailSigninPageState extends State<EmailSigninPage> {
  //class
  final validator = Appvalidator();
  final auth = AuthendicationService();
  final db = Database();
  int totalCreditRedeemed = 0;
  int creditBalance = 0;

  bool isShowPassword = true;

  //controllers
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: size.height * 0.02,
            children: [
              SizedBox(
                height: size.height * 0.04,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                height: size.height * 0.30,
                width: size.width * 1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://i.postimg.cc/nz0YBQcH/Logo-light.png"),
                        fit: BoxFit.contain)),
              ),
              Text(
                "Sign In",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              CustomTextFormField(
                  controller: userNameController,
                  labelText: "Username",
                  validator: validator.emailValidator),
              CustomTextFormField(
                  controller: emailController,
                  labelText: "Email",
                  validator: validator.emailValidator),
              CustomTextFormField(
                controller: passwordController,
                labelText: "Password",
                validator: validator.passwordValidator,
                suffixIcon:
                    isShowPassword ? Icons.visibility : Icons.visibility_off,
                onPressed: () {
                  setState(() {
                    isShowPassword = !isShowPassword;
                  });
                },
                obScureText: isShowPassword,
              ),
              SizedBox(
                height: size.height * 0.08,
                width: size.width * 1,
                child: CustomElevatedButton(
                  text: "Sign In",
                  onPressed: () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please fill the form")),
                      );
                      return;
                    }
                    await auth.createUser(
                        emailController.text, passwordController.text);
                    await db.createData(context, data: {
                      "Username": userNameController.text,
                      "email": emailController.text,
                      "password": passwordController.text,
                      "totalCreditRedeemed": totalCreditRedeemed,
                      "creditBalance": creditBalance
                    });
                    emailController.clear();
                    passwordController.clear();
                    if (context.mounted) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavBar()));
                    }
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
