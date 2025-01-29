// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? suffixIcon;
  final bool obScureText;
  final VoidCallback? onPressed;
  final FormFieldValidator validator;
  final TextInputType keyboardtype;
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.validator,
      this.obScureText = false,
      this.suffixIcon,
      this.keyboardtype = TextInputType.text,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obScureText,
      keyboardType: keyboardtype,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
        suffixIcon: IconButton(onPressed: onPressed, icon: Icon(suffixIcon)),
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class CustomDetailsGettingFromUserPage extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final TextInputType keyboardType;
  final int? maxLength;

  const CustomDetailsGettingFromUserPage({
    super.key,
    required this.text,
    required this.controller,
    required this.validator,
    this.maxLength,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: InputDecoration(
          labelText: text,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
          )),
    );
  }
}
