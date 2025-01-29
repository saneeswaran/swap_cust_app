import 'dart:io';
import 'package:flutter/material.dart';
import 'package:swap_cust_app/constants/constants.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/custom_elevated_button.dart';
import '../widgets/profile_page_buttons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool switchButtonValue = false;

  bool? switchButtonOnchanged(value) {
    setState(() {
      switchButtonValue = value;
    });
    return null;
  }

//image picker
  File? image;
  final picker = ImagePicker();

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

//class
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
            //profile picture
            (image != null)
                ? Center(
                    child: Material(
                      shape: CircleBorder(
                          side: BorderSide(
                              color: Theme.of(context).primaryColor, width: 3)),
                      color: Theme.of(context).primaryColor,
                      child: Material(
                        shape: CircleBorder(
                            side: BorderSide(color: Colors.white, width: 4)),
                        child: CircleAvatar(
                          backgroundImage: FileImage(image!),
                          radius: 80,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: GestureDetector(
                      onTap: getImageFromGallery,
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
                            backgroundImage: AssetImage(profile),
                            radius: 80,
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: size.height * 0.01,
            ),
            // user name
            Text(
              "Kunal",
              style: TextStyle(
                  color: Color(0xff0B67BC),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1.3,
            ),
            //total credit balance
            Text(
              "5000",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),
            Text(
              "Credit Balance",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                spacing: size.height * 0.03,
                children: [
                  // SizedBox(
                  //   height: size.height * 0.10,
                  //   width: size.width * 1,
                  //   child: ProfilePageSwitchButton(
                  //     text: "Premium User",
                  //     icon: Icons.power_settings_new,
                  //     value: switchButtonValue,
                  //     onChanged: switchButtonOnchanged,
                  //   ),
                  // ),
                  SizedBox(
                    height: size.height * 0.08,
                    width: size.width * 1,
                    child: ProfilePageButtons(
                      text: "Edit Profile",
                      icon: Icons.edit,
                      onPressed: () {},
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.08,
                    width: size.width * 1,
                    child: ProfilePageButtons(
                      text: "Change Contact Number",
                      icon: Icons.contact_phone_outlined,
                      onPressed: () {},
                    ),
                  ),
                  // SizedBox(
                  //   height: size.height * 0.08,
                  //   width: size.width * 1,
                  //   child: ProfilePageButtons(
                  //     text: "Account Settings",
                  //     icon: Icons.swap_calls,
                  //     onPressed: () {},
                  //   ),
                  // ),
                  CustomElevatedButton(
                    text: "Logout",
                    onPressed: () {},
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
