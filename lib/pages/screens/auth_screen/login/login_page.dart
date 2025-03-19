import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:swap_cust_app/pages/screens/auth_screen/login/provider/auth_provider.dart';
import 'package:swap_cust_app/pages/screens/auth_screen/register/registration_page.dart';

import '../../../../models/user/user_model.dart';
import '../../../../util/app_validator.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginWithEmailPageState();
}

class _LoginWithEmailPageState extends State<LoginPage> {
  //controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
//keys
  final formKey = GlobalKey<FormState>();
  //var
  bool isShowPassword = true;

  //classes
  final validator = Appvalidator();
  final loginProvider = AuthProvider();
  //function
  void registerUser() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    UserModel newUser = UserModel(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      image: null, // Add image URL if needed
    );

    bool success = await authProvider.registerUser(newUser);
    if (success) {
      if (kDebugMode) {
        print("User Registered Successfully!");
      }
    } else {
      if (kDebugMode) {
        print("Failed to register user.");
      }
    }
  }

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
                  controller: _emailController,
                  labelText: "Email",
                  validator: validator.emailValidator),
              CustomTextFormField(
                controller: _passwordController,
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
                  onPressed: registerUser,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
              _registerPageNavigator()
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerPageNavigator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
        ),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 500),
                      child: RegistrationPage()));
            },
            child: Text(
              "Register",
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 16),
            ))
      ],
    );
  }
}
