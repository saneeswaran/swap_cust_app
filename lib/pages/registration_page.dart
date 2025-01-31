import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swap_cust_app/constants/constants.dart';
import 'package:swap_cust_app/pages/login_page.dart';
import 'package:swap_cust_app/services/authendication_service.dart';
import 'package:swap_cust_app/widgets/custom_elevated_button.dart';
import 'package:swap_cust_app/widgets/custom_text_form_field.dart';

import '../services/database.dart';
import '../util/app_validator.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _EmailSigninPageState();
}

class _EmailSigninPageState extends State<RegistrationPage> {
  //class
  final validator = Appvalidator();
  final auth = AuthendicationService();
  final db = Database();
  int totalCreditRedeemed = 0;
  int creditBalance = 0;

  bool isShowPassword = true;
  File? image;

  //controllers
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //image picker

  Future<String?> uploadImage(File imageFile) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('user_profiles/$userId.jpg');

      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String? imageUrl = await uploadImage(imageFile);
      setState(() {
        image = File(imageFile.path);
      });

      if (imageUrl != null) {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'profile_pic': imageUrl,
        });
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
                  : GestureDetector(
                      onTap: pickAndUploadImage,
                      child: Center(
                        child: Material(
                          shape: CircleBorder(
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 3)),
                          color: Theme.of(context).primaryColor,
                          child: Material(
                            shape: CircleBorder(
                                side:
                                    BorderSide(color: Colors.white, width: 4)),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(emptyProfile),
                              radius: 80,
                            ),
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
                  onPressed: () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please fill the form")),
                      );
                      return;
                    }
                    await auth.createUser(context,
                        email: emailController.text.trim(),
                        password: passwordController.text.trim());

                    if (context.mounted) {
                      await db.createData(context,
                          userName: userNameController.text,
                          userEmail: emailController.text,
                          userImage: image?.path ?? '',
                          totalCreditRedeemed: totalCreditRedeemed,
                          creditBalance: creditBalance);
                    }
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text("Login")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
