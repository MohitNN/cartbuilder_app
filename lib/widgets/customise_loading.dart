import 'package:flutter/material.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:shimmer/shimmer.dart';

Widget customiseLoading({double hPad}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: hPad ?? 16),
    child: Column(
      children: [
        SizedBox(
          height: 0,
        ),
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 7,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      shimmerLoadingCard2(height: 83, radius: 0),
                      Row(
                        children: [
                          Spacer(
                            flex: 2,
                          ),
                          Expanded(
                              flex: 2,
                              child:
                                  shimmerLoadingCard2(height: 25, width: 60)),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: shimmerLoadingCard2(height: 30, width: 60),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }),
        )
      ],
    ),
  );
}

Widget templatesLoading(int length) {
  return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          childAspectRatio: 0.6),
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
      itemCount: length,
      itemBuilder: (context, index) {
        return shimmerLoadingCard2(radius: 6);
      });
}

Widget shimmerLoadingCard2({double height, double radius, double width}) {
  return Shimmer.fromColors(
    baseColor: Color(0xff86cdff).withOpacity(0.5),
    highlightColor: Colors.white,
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
