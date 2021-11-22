import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

class SecondTextField extends StatelessWidget {
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
  FocusNode focusNode;
  int maxline;
  String prefixText;

  SecondTextField(
      {this.controller,
      this.labelText,
      this.hintText,
      this.prefixIcon,
      this.focusNode,
      this.suffixIcon,
      this.suffix,
      @required this.obscureText,
      this.enabled,
      this.keyboardType,
      this.textInputAction,
      this.validator,
      this.onSaved,
      this.onChanged,
      this.prefixText,
      this.maxline});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      focusNode: focusNode,
      textInputAction: textInputAction,
      maxLines: maxline,
      enabled: enabled,
      decoration: InputDecoration(
        prefixText: prefixText,
        fillColor: mtextBoxColor,
        filled: true,
        border: InputBorder.none,
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: mborderColor)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: mborderColor)),
        errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: mborderColor)),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffix: suffix,
        hintText: hintText,
        hintStyle: GoogleFonts.roboto(
          fontSize: 14,
          color: mTextboxHintColor,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: GoogleFonts.roboto(
          fontSize: 15,
          color: mDisableTextColor,
          fontWeight: FontWeight.w400,
        ),
        contentPadding:
            EdgeInsets.only(left: 8.0, top: maxline == null ? 0 : 8),
      ),
      keyboardType: keyboardType,
      onSaved: onSaved,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
