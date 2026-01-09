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

TextStyle largeTitleTextStyle(ColorScheme colorScheme) => TextStyle(
  fontSize: 16.0.sp,
  fontWeight: FontWeight.w500,
  color: colorScheme.onSurface,
  fontFamily: Fonts.fontPoppins,
);

TextStyle xlargeTitleTextStyle(Color textColor) => TextStyle(
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
  fontWeight: FontWeight.w600,
  color: colorScheme.onSurface.withValues(alpha: 0.50),
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
  fontWeight: FontWeight.w700,
  fontFamily: Fonts.fontPoppins,
);

TextStyle buttonTextStyle(Color textColor) => TextStyle(
  fontSize: 12.0.sp,
  color: textColor,
  fontWeight: FontWeight.w600,
  fontFamily: Fonts.fontPoppins,
);

TextStyle statusTextStyle(Color textColor) => TextStyle(
  fontSize: 16.0.sp,
  fontWeight: FontWeight.w500,
  color: textColor,
  fontFamily: Fonts.fontPoppins,
);

TextStyle defaultOnPrimaryTextStyle(Color textColor) => TextStyle(
  fontSize: 12.0.sp,
  fontWeight: FontWeight.w300,
  color: textColor,
  fontFamily: Fonts.fontPoppins,
);

Icon iconDownload() => Icon(Icons.download, size: 22.0.r);

Icon backButton() => Icon(Icons.arrow_back_sharp, size: 22.0.r);

Icon closeButton() => Icon(Icons.close, size: 22.0.r);

Icon rejectButton(Color textColor) =>
    Icon(Icons.close, size: 16.0.r, color: textColor);

Icon approveButton(Color textColor) =>
    Icon(Icons.check, size: 16.0.r, color: textColor);

Icon undoButton(Color textColor) =>
    Icon(Icons.undo, size: 16.0.r, color: textColor);

Icon moreButton(Color textColor) =>
    Icon(Icons.chevron_right, size: 24.0.r, color: textColor);

Icon menuButton() => Icon(Icons.menu, size: 22.0.r);

Icon editButton(ColorScheme colorScheme) =>
    Icon(Icons.edit_outlined, color: colorScheme.onSecondary);

Icon sortArrowButton(ColorScheme colorScheme) =>
    Icon(Icons.arrow_drop_down, size: 16.0.r, color: colorScheme.onSurface);
