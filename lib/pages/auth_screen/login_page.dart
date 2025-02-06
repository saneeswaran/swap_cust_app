import 'package:flutter/material.dart';
import 'package:swap_cust_app/services/authendication_service.dart';

import '../../util/app_validator.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginWithEmailPageState();
}

class _LoginWithEmailPageState extends State<LoginPage> {
  //controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //var
  bool isShowPassword = true;

  //classes
  final validator = Appvalidator();
  final auth = AuthendicationService();
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
                "Login",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  text: "Login",
                  onPressed: () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please fill the form")),
                      );
                      return;
                    }
                    await auth.loginUser(context,
                        email: emailController.text.trim(),
                        password: passwordController.text.trim());
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
