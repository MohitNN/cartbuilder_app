import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final Widget suffix;
  bool obscureText = false;
  bool enabled = true;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  ValueChanged<String> onChanged;

  CustomTextField({
    @required this.controller,
    this.labelText,
    @required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    @required this.obscureText,
    this.enabled,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onSaved,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Card(
          elevation: 0.0,
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: TextFormField(
              autocorrect: false,
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                fillColor: mWhiteColor,
                border: InputBorder.none,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: mWhiteColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: mWhiteColor)),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                suffix: suffix,
                hintText: hintText,
                labelText: labelText,
                hintStyle: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: mIconColor,
                ),
              ),
              keyboardType: keyboardType,
              onSaved: onSaved,
              validator: validator,
            ),
          ),
        ),
      ),
    );
  }
}
