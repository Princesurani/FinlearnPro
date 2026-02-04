import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class AppTypography {

  static const String fontFamilyDisplay = 'Inter';

  static const String fontFamilyBody = 'Inter';

  static const String fontFamilyMono = 'JetBrains Mono';

  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  static const double lineHeightTight = 1.1;

  static const double lineHeightSnug = 1.25;

  static const double lineHeightNormal = 1.5;

  static const double lineHeightRelaxed = 1.625;

  static const double lineHeightLoose = 1.75;

  static const double letterSpacingTight = -0.64;

  static const double letterSpacingSnug = -0.32;

  static const double letterSpacingNormal = 0.0;

  static const double letterSpacingWide = 0.8;

  static const double letterSpacingExtraWide = 1.6;

  static const TextStyle display1 = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 56.0,
    fontWeight: bold,
    height: lineHeightTight,
    letterSpacing: letterSpacingTight,
    color: AppColors.textPrimary,
  );

  static const TextStyle display2 = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 48.0,
    fontWeight: bold,
    height: lineHeightTight,
    letterSpacing: letterSpacingTight,
    color: AppColors.textPrimary,
  );

  static const TextStyle display3 = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 40.0,
    fontWeight: semiBold,
    height: lineHeightTight,
    letterSpacing: letterSpacingSnug,
    color: AppColors.textPrimary,
  );

  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 32.0,
    fontWeight: bold,
    height: lineHeightSnug,
    letterSpacing: letterSpacingSnug,
    color: AppColors.textPrimary,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 28.0,
    fontWeight: semiBold,
    height: lineHeightSnug,
    letterSpacing: letterSpacingSnug,
    color: AppColors.textPrimary,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 24.0,
    fontWeight: semiBold,
    height: lineHeightSnug,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textPrimary,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 20.0,
    fontWeight: semiBold,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textPrimary,
  );

  static const TextStyle h5 = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 18.0,
    fontWeight: semiBold,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textPrimary,
  );

  static const TextStyle h6 = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 16.0,
    fontWeight: semiBold,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 18.0,
    fontWeight: regular,
    height: lineHeightRelaxed,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 16.0,
    fontWeight: regular,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 16.0,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 14.0,
    fontWeight: regular,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodyXS = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 12.0,
    fontWeight: regular,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textTertiary,
  );

  static const TextStyle buttonLarge = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 18.0,
    fontWeight: semiBold,
    height: lineHeightSnug,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textOnPrimary,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 16.0,
    fontWeight: semiBold,
    height: lineHeightSnug,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textOnPrimary,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 14.0,
    fontWeight: semiBold,
    height: lineHeightSnug,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textOnPrimary,
  );

  static const TextStyle label = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 14.0,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textSecondary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 12.0,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWide,
    color: AppColors.textTertiary,
  );

  static const TextStyle overline = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 11.0,
    fontWeight: semiBold,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWide,
    color: AppColors.textTertiary,
  );

  static const TextStyle numberDisplay = TextStyle(
    fontFamily: fontFamilyMono,
    fontSize: 40.0,
    fontWeight: bold,
    height: lineHeightTight,
    letterSpacing: letterSpacingTight,
    color: AppColors.textPrimary,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const TextStyle numberLarge = TextStyle(
    fontFamily: fontFamilyMono,
    fontSize: 28.0,
    fontWeight: semiBold,
    height: lineHeightSnug,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textPrimary,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const TextStyle numberMedium = TextStyle(
    fontFamily: fontFamilyMono,
    fontSize: 20.0,
    fontWeight: semiBold,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textPrimary,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const TextStyle number = TextStyle(
    fontFamily: fontFamilyMono,
    fontSize: 16.0,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textPrimary,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const TextStyle numberSmall = TextStyle(
    fontFamily: fontFamilyMono,
    fontSize: 14.0,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textSecondary,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static TextStyle percentagePositive({double fontSize = 14.0}) => TextStyle(
    fontFamily: fontFamilyMono,
    fontSize: fontSize,
    fontWeight: semiBold,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.profitGreen,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  static TextStyle percentageNegative({double fontSize = 14.0}) => TextStyle(
    fontFamily: fontFamilyMono,
    fontSize: fontSize,
    fontWeight: semiBold,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.lossRed,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  static const TextStyle link = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 16.0,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.primaryPurple,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.primaryPurple,
  );

  static const TextStyle code = TextStyle(
    fontFamily: fontFamilyMono,
    fontSize: 14.0,
    fontWeight: regular,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textPrimary,
  );

  static const TextStyle quote = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 18.0,
    fontWeight: regular,
    fontStyle: FontStyle.italic,
    height: lineHeightRelaxed,
    letterSpacing: letterSpacingNormal,
    color: AppColors.textSecondary,
  );

  static const TextTheme textTheme = TextTheme(
    displayLarge: display1,
    displayMedium: display2,
    displaySmall: display3,
    headlineLarge: h1,
    headlineMedium: h2,
    headlineSmall: h3,
    titleLarge: h4,
    titleMedium: h5,
    titleSmall: h6,
    bodyLarge: bodyLarge,
    bodyMedium: body,
    bodySmall: bodySmall,
    labelLarge: button,
    labelMedium: label,
    labelSmall: labelSmall,
  );

  static TextStyle dark(TextStyle style) => style.copyWith(
    color: style.color == AppColors.textPrimary
        ? AppColors.textOnDark
        : style.color == AppColors.textSecondary
            ? AppColors.textOnDark.withAlpha((0.7 * 255).round())
            : style.color == AppColors.textTertiary
                ? AppColors.textOnDark.withAlpha((0.5 * 255).round())
                : style.color,
  );

  static TextStyle withPrimary(TextStyle style) =>
      style.copyWith(color: AppColors.primaryPurple);

  static TextStyle withSecondary(TextStyle style) =>
      style.copyWith(color: AppColors.textSecondary);

  static TextStyle withSuccess(TextStyle style) =>
      style.copyWith(color: AppColors.success);

  static TextStyle withError(TextStyle style) =>
      style.copyWith(color: AppColors.error);

  static TextStyle withBold(TextStyle style) =>
      style.copyWith(fontWeight: bold);

  static TextStyle withMedium(TextStyle style) =>
      style.copyWith(fontWeight: medium);
}

extension TextStyleExtensions on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get primary => copyWith(color: AppColors.textPrimary);

  TextStyle get secondary => copyWith(color: AppColors.textSecondary);

  TextStyle get tertiary => copyWith(color: AppColors.textTertiary);

  TextStyle get accent => copyWith(color: AppColors.primaryPurple);

  TextStyle get success => copyWith(color: AppColors.success);

  TextStyle get error => copyWith(color: AppColors.error);

  TextStyle get white => copyWith(color: Colors.white);

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
}
