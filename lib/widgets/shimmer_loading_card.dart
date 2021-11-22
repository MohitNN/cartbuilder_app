import 'package:flutter/material.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerLoadingCard({double height, double radius, double width}) {
  return Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: Colors.grey[200],
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: radius == null
            ? BorderRadius.circular(40)
            : BorderRadius.circular(radius),
        color: mBgColor,
      ),
    ),
  );
}
