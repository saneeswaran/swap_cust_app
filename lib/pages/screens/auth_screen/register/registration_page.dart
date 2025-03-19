import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swap_cust_app/constants/constants.dart';
import 'package:swap_cust_app/widgets/custom_elevated_button.dart';
import 'package:swap_cust_app/widgets/custom_text_form_field.dart';

import '../../../../util/app_validator.dart';
import '../login/login_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _EmailSigninPageState();
}

class _EmailSigninPageState extends State<RegistrationPage> {
  //class
  final validator = Appvalidator();

  int totalCreditRedeemed = 0;
  int creditBalance = 0;

  bool isShowPassword = true;
  File? image;

  //controllers
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //image picker

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
                height: size.height * 0.10,
              ),
              image != null
                  ? Stack(
                      children: [
                        Center(
                          child: Material(
                            shape: CircleBorder(
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 3)),
                            color: Theme.of(context).primaryColor,
                            child: Material(
                              shape: CircleBorder(
                                  side: BorderSide(
                                      color: Colors.white, width: 4)),
                              child: CircleAvatar(
                                backgroundImage: FileImage(image!),
                                radius: 80,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                              margin:
                                  const EdgeInsets.only(top: 120, left: 120),
                              height: size.height * 0.05,
                              width: size.width * 0.10,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      image = null;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ))),
                        )
                      ],
                    )
                  : Center(
                      child: Material(
                        shape: CircleBorder(
                            side: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 3)),
                        color: Theme.of(context).primaryColor,
                        child: Material(
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.white, width: 4)),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(emptyProfile),
                            radius: 80,
                          ),
                        ),
                      ),
                    ),
              Center(
                  child: Text(
                "Please select your image",
                style: TextStyle(color: Colors.grey.shade700, fontSize: 20),
              )),
              Text(
                "Sign In",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              CustomTextFormField(
                controller: userNameController,
                labelText: "Username",
                validator: validator.userNameValidator,
                keyboardtype: TextInputType.emailAddress,
              ),
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
                  onPressed: () {},
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
              _navigateToLoginPage(context)
            ],
          ),
        ),
      ),
    );
  }

  Row _navigateToLoginPage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account?"),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 600),
                      child: LoginPage()));
            },
            child: Text(
              "Login",
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 16),
            )),
      ],
    );
  }
}
