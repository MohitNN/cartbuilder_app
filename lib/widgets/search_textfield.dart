import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Widget suffixIcon;
  final Widget suffix;
  bool obscureText = false;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  ValueChanged<String> onChanged;
  VoidCallback onCancel;
  TextInputAction textInputAction;

  SearchTextField(
      {@required this.controller,
      this.labelText,
      @required this.hintText,
      this.suffixIcon,
      this.suffix,
      @required this.obscureText,
      this.keyboardType,
      this.validator,
      this.onSaved,
      this.onChanged,
      this.textInputAction,
      this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      // margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: textFieldBg,
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              onFieldSubmitted: onSaved,
              textInputAction: textInputAction,
              style: TextStyle(color: mPrimaryColor, fontSize: 18.0),
              obscureText: obscureText,
              onChanged: onChanged,
              decoration: InputDecoration(
                fillColor: searchBarColor,
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: searchIconColor,
                  size: 30.0,
                ),
                suffixIcon: suffixIcon,
                suffix: suffix,
                hintText: hintText,
                labelText: labelText,
                hintStyle: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: searchHintColor,
                ),
              ),
              keyboardType: keyboardType,
              onSaved: onSaved,
              validator: validator,
            ),
          ),
          IconButton(onPressed: onCancel, icon: Icon(Icons.highlight_remove))
        ],
      ),
    );
  }
}
