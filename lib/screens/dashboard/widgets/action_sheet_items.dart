import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/utils/app_strings.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

Widget actionSheetItems({
  String title,
  String description,
  String icon,
  GestureTapCallback onTap,
}) {
  return Container(
    margin: EdgeInsets.only(left: 15.0, right: 10.0, top: 5.0, bottom: 5.0),
    child: InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            AppString.iconImagesPath + icon,
            color: mTextboxTitleColor,
            height: 25.0,
            width: 25.0,
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: mTextColor,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: mBlackColor.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
