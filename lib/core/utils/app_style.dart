// ignore_for_file: strict_top_level_inference
import 'package:flutter/material.dart';

abstract class AppStyles {
  static TextStyle styleRegular12(BuildContext context) {
    return TextStyle(
      color: const Color(0xFFFFFFFF),
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleBold12(BuildContext context) {
    return TextStyle(
      color: const Color(0xFFFFFFFF),
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleRegular14(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.titleMedium?.color,
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleBold14(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.titleMedium?.color,
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleRegular16(context) {
    return TextStyle(
      color: Theme.of(context).textTheme.titleMedium?.color,
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleBold16(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.titleMedium?.color,
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleRegular18(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.titleMedium?.color,
      fontSize: getResponsiveFontSize(context, fontSize: 18),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleBold18(BuildContext context) {
    return TextStyle(
      color: const Color(0xFFFFFFFF),
      fontSize: getResponsiveFontSize(context, fontSize: 18),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleRegular20(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.titleMedium?.color,
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleBold20(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.titleMedium?.color,
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleRegular24(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.titleMedium?.color,
      fontSize: getResponsiveFontSize(context, fontSize: 24),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleBold24(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.titleMedium?.color,
      fontSize: getResponsiveFontSize(context, fontSize: 24),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleRegular28(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.titleMedium?.color,
      fontSize: getResponsiveFontSize(context, fontSize: 28),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleBold28(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.titleMedium?.color,
      fontSize: getResponsiveFontSize(context, fontSize: 28),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleRegular32(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.titleMedium?.color,
      fontSize: getResponsiveFontSize(context, fontSize: 32),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleBold32(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.titleMedium?.color,
      fontSize: getResponsiveFontSize(context, fontSize: 32),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w700,
    );
  }
}

double getResponsiveFontSize(context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(context) {
  double width = MediaQuery.sizeOf(context).width;
  if (width < 700) {
    return width / 650;
  } else if (width < 1000) {
    return width / 1100;
  } else {
    return width / 1920;
  }
}
