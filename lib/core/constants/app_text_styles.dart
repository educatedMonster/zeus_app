import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_fonts.dart';

/// Common text style
TextStyle axisTextStyle(ColorScheme colorScheme) => TextStyle(
  color: colorScheme.onTertiary,
  fontSize: 8.0.sp,
  fontFamily: Fonts.fontPoppins,
);

TextStyle appBarTextStyle(ColorScheme colorScheme) => TextStyle(
  color: colorScheme.onSurface,
  fontWeight: FontWeight.w700,
  fontSize: 18.0.sp,
  fontFamily: Fonts.fontMontserrat,
);

TextStyle defaultCaptionTextStyle(ColorScheme colorScheme) => TextStyle(
  fontSize: 10.0.sp,
  fontWeight: FontWeight.w300,
  color: colorScheme.onSurface.withValues(alpha: 0.50),
  fontFamily: Fonts.fontPoppins,
);

TextStyle dataCellTextStyle(ColorScheme colorScheme) => TextStyle(
  fontSize: 10.0.sp,
  fontWeight: FontWeight.w300,
  color: colorScheme.onSurface,
  fontFamily: Fonts.fontPoppins,
);

TextStyle defaultTitleTextStyle(ColorScheme colorScheme) => TextStyle(
  fontSize: 12.0.sp,
  fontWeight: FontWeight.w300,
  color: colorScheme.onSurface.withValues(alpha: 0.50),
  fontFamily: Fonts.fontPoppins,
);

TextStyle viewReportTextStyle(ColorScheme colorScheme) => TextStyle(
  fontSize: 12.0.sp,
  fontWeight: FontWeight.w600,
  color: colorScheme.onSurface,
  fontFamily: Fonts.fontPoppins,
);

TextStyle mediumTitleTextStyle(ColorScheme colorScheme) => TextStyle(
  fontSize: 13.0.sp,
  fontWeight: FontWeight.w500,
  color: colorScheme.onSurface,
  fontFamily: Fonts.fontPoppins,
);

TextStyle largeTitleTextStyle(Color textColor) => TextStyle(
  fontSize: 18.0.sp,
  fontWeight: FontWeight.w700,
  color: textColor,
  fontFamily: Fonts.fontPoppins,
);

TextStyle salesPOSTextStyle(Color textColor) => TextStyle(
  fontSize: 18.0.sp,
  fontWeight: FontWeight.w600,
  color: textColor,
  fontFamily: Fonts.fontMontserrat,
);

TextStyle captionPOSTextStyle(Color textColor) => TextStyle(
  fontSize: 11.0.sp,
  fontWeight: FontWeight.w500,
  color: textColor,
  fontFamily: Fonts.fontMontserrat,
);

TextStyle titlePOSTextStyle(Color textColor) => TextStyle(
  fontSize: 12.0.sp,
  fontWeight: FontWeight.w500,
  color: textColor,
  fontFamily: Fonts.fontMontserrat,
);

TextStyle percentPOSTextStyle(Color textColor) => TextStyle(
  fontSize: 14.0.sp,
  fontWeight: FontWeight.w500,
  color: textColor,
  fontFamily: Fonts.fontMontserrat,
);

TextStyle captionReportTextStyle(ColorScheme colorScheme) => TextStyle(
  fontSize: 10.0.sp,
  fontWeight: FontWeight.w300,
  color: Colors.green,
  fontFamily: Fonts.fontPoppins,
);

TextStyle cardTitleTextStyle(ColorScheme colorScheme) => TextStyle(
  fontSize: 14.0.sp,
  fontWeight: FontWeight.w500,
  color: colorScheme.onSurface,
  fontFamily: Fonts.fontPoppins,
);

TextStyle propertyTitleTextStyle(ColorScheme colorScheme) => TextStyle(
  fontSize: 10.0.sp,
  fontWeight: FontWeight.w300,
  color: colorScheme.onSurface.withValues(alpha: 0.50),
  fontFamily: Fonts.fontPoppins,
);

TextStyle noDataTextStyle(ColorScheme colorScheme) => TextStyle(
  fontSize: 16.0.sp,
  fontWeight: FontWeight.w700,
  color: colorScheme.onSurface,
  fontFamily: Fonts.fontPoppins,
);

TextStyle dropdownTextStyle(ColorScheme colorScheme) => TextStyle(
  fontSize: 12.0.sp,
  color: colorScheme.onSurface,
  fontWeight: FontWeight.w300,
  fontFamily: Fonts.fontPoppins,
);

TextStyle tabBarTextStyle(ColorScheme colorScheme) => TextStyle(
  fontSize: 12.0.sp,
  color: colorScheme.onSurface,
  fontWeight: FontWeight.w500,
  fontFamily: Fonts.fontPoppins,
);

Icon iconDownload() => Icon(Icons.download, size: 22.0.r);
Icon backButton() => Icon(Icons.arrow_back_sharp, size: 22.0.r);
Icon closeButton() => Icon(Icons.close, size: 22.0.r);
Icon menuButton() => Icon(Icons.menu, size: 22.0.r);


