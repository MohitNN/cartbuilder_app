import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingImage(String url, {double height, double width, BoxFit fit}) {
  return FancyShimmerImage(
    imageUrl: url,
    height: height ?? 200,
    width: width,
    boxFit: fit,
    shimmerDirection: ShimmerDirection.ltr,
    shimmerBaseColor: Color(0xffD8EDFC),
    shimmerHighlightColor: Colors.white,
  );
}
