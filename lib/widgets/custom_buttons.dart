import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    @required this.onPressed,
    @required this.text,
    this.width,
    this.height,
    @required this.textColor,
    this.backgroundColor,
  });
  final GestureTapCallback onPressed;

  final String text;

  final Color textColor;
  final Color backgroundColor;
  final double width;
  final double height;

  @override
  Widget build(
    BuildContext context,
  ) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
//        margin: EdgeInsets.only(right: Constant.size15),
        decoration: BoxDecoration(
          color: mBtnColor,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Center(
          child: Container(
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 Text(
                  text,
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
