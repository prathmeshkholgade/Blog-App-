import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

getResponsiveWidth(context) {
  final size = MediaQuery.of(context).size;
  double boxWidth;

  if (size.width < 600) {
    boxWidth = 90.w;
  } else if (size.width >= 600 && size.width < 1024) {
    boxWidth = 55.w;
  } else {
    boxWidth = 45.w;
  }
  return boxWidth;
}

getResponsiveWidthForSignup(context) {
  final size = MediaQuery.of(context).size;
  double boxWidth;

  if (size.width < 600) {
    boxWidth = 90.w;
  } else if (size.width >= 600 && size.width < 1024) {
    boxWidth = 45.w;
  } else {
    boxWidth = 25.w;
  }
  return boxWidth;
}
