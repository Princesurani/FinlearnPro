import 'package:flutter/material.dart';

abstract final class AppSpacing {

  static const double unit = 8.0;

  static const double xxxs = 2.0;

  static const double xxs = 4.0;

  static const double xs = 8.0;

  static const double sm = 12.0;

  static const double md = 16.0;

  static const double lg = 20.0;

  static const double xl = 24.0;

  static const double xxl = 32.0;

  static const double xxxl = 40.0;

  static const double huge = 48.0;

  static const double massive = 56.0;

  static const double giant = 64.0;

  static const double colossal = 80.0;

  static const double max = 96.0;

  static const double screenPaddingHorizontal = 20.0;

  static const double screenPaddingVertical = 24.0;

  static const double cardPadding = 20.0;

  static const double cardPaddingCompact = 16.0;

  static const double buttonPaddingHorizontal = 24.0;

  static const double buttonPaddingVertical = 16.0;

  static const double inputPadding = 16.0;

  static const double listItemPadding = 16.0;

  static const double listItemGap = 12.0;

  static const double iconTextGap = 12.0;

  static const double sectionGap = 32.0;

  static const double cardGap = 16.0;

  static const double bottomNavMargin = 16.0;

  static const double modalPadding = 24.0;

  static const double appBarPadding = 16.0;

  static const double tabPadding = 8.0;

  static const EdgeInsets zero = EdgeInsets.zero;

  static const EdgeInsets paddingMicro = EdgeInsets.all(xxs);

  static const EdgeInsets paddingXS = EdgeInsets.all(xs);

  static const EdgeInsets paddingSM = EdgeInsets.all(sm);

  static const EdgeInsets paddingMD = EdgeInsets.all(md);

  static const EdgeInsets paddingLG = EdgeInsets.all(lg);

  static const EdgeInsets paddingXL = EdgeInsets.all(xl);

  static const EdgeInsets paddingXXL = EdgeInsets.all(xxl);

  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screenPaddingHorizontal,
    vertical: screenPaddingVertical,
  );

  static const EdgeInsets screenPaddingH = EdgeInsets.symmetric(
    horizontal: screenPaddingHorizontal,
  );

  static const EdgeInsets cardInsets = EdgeInsets.all(cardPadding);

  static const EdgeInsets cardInsetsCompact = EdgeInsets.all(cardPaddingCompact);

  static const EdgeInsets buttonInsets = EdgeInsets.symmetric(
    horizontal: buttonPaddingHorizontal,
    vertical: buttonPaddingVertical,
  );

  static const EdgeInsets buttonInsetsCompact = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );

  static const EdgeInsets inputInsets = EdgeInsets.all(inputPadding);

  static const EdgeInsets listItemInsets = EdgeInsets.symmetric(
    horizontal: md,
    vertical: listItemPadding,
  );

  static const EdgeInsets modalInsets = EdgeInsets.all(modalPadding);

  static const EdgeInsets sheetHandlePadding = EdgeInsets.only(
    top: sm,
    bottom: md,
  );

  static const double radiusNone = 0.0;

  static const double radiusXS = 4.0;

  static const double radiusSM = 8.0;

  static const double radiusMD = 12.0;

  static const double radiusLG = 16.0;

  static const double radiusXL = 20.0;

  static const double radiusXXL = 24.0;

  static const double radiusFull = 9999.0;

  // Border Radius Presets
  static const BorderRadius borderRadiusXS = BorderRadius.all(Radius.circular(radiusXS));
  static const BorderRadius borderRadiusSM = BorderRadius.all(Radius.circular(radiusSM));
  static const BorderRadius borderRadiusMD = BorderRadius.all(Radius.circular(radiusMD));
  static const BorderRadius borderRadiusLG = BorderRadius.all(Radius.circular(radiusLG));
  static const BorderRadius borderRadiusXL = BorderRadius.all(Radius.circular(radiusXL));
  static const BorderRadius borderRadiusXXL = BorderRadius.all(Radius.circular(radiusXXL));
  static const BorderRadius borderRadiusFull = BorderRadius.all(Radius.circular(radiusFull));

  // Top-only radius for bottom sheets
  static const BorderRadius borderRadiusTopLG = BorderRadius.only(
    topLeft: Radius.circular(radiusLG),
    topRight: Radius.circular(radiusLG),
  );

  static const BorderRadius borderRadiusTopXL = BorderRadius.only(
    topLeft: Radius.circular(radiusXL),
    topRight: Radius.circular(radiusXL),
  );

  static const BorderRadius borderRadiusTopXXL = BorderRadius.only(
    topLeft: Radius.circular(radiusXXL),
    topRight: Radius.circular(radiusXXL),
  );

  static const double buttonHeight = 56.0;

  static const double buttonHeightCompact = 44.0;

  static const double buttonHeightSmall = 36.0;

  static const double inputHeight = 56.0;

  static const double iconButtonSize = 48.0;

  static const double iconButtonSizeCompact = 40.0;

  static const double iconSize = 24.0;

  static const double iconSizeSM = 20.0;

  static const double iconSizeLG = 28.0;

  static const double iconSizeXL = 32.0;

  static const double avatarSizeSM = 32.0;

  static const double avatarSizeMD = 40.0;

  static const double avatarSizeLG = 48.0;

  static const double avatarSizeXL = 64.0;

  static const double bottomNavHeight = 80.0;

  static const double appBarHeight = 56.0;

  static const double minTouchTarget = 48.0;

  static const double maxContentWidth = 600.0;

  static const double cardMinWidth = 280.0;

  static const double modalMaxWidth = 400.0;

  static double scale(double multiplier) => unit * multiplier;

  static double responsive(BuildContext context, double baseSpacing) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1200) return baseSpacing * 1.5;
    if (width >= 900) return baseSpacing * 1.25;
    if (width >= 600) return baseSpacing * 1.1;
    return baseSpacing;
  }

  static SizedBox verticalGap(double height) => SizedBox(height: height);

  static SizedBox horizontalGap(double width) => SizedBox(width: width);

  // Common gap widgets for convenience
  static const SizedBox gapXXS = SizedBox(height: xxs);
  static const SizedBox gapXS = SizedBox(height: xs);
  static const SizedBox gapSM = SizedBox(height: sm);
  static const SizedBox gapMD = SizedBox(height: md);
  static const SizedBox gapLG = SizedBox(height: lg);
  static const SizedBox gapXL = SizedBox(height: xl);
  static const SizedBox gapXXL = SizedBox(height: xxl);
  static const SizedBox gapSection = SizedBox(height: sectionGap);

  static const SizedBox gapHXXS = SizedBox(width: xxs);
  static const SizedBox gapHXS = SizedBox(width: xs);
  static const SizedBox gapHSM = SizedBox(width: sm);
  static const SizedBox gapHMD = SizedBox(width: md);
  static const SizedBox gapHLG = SizedBox(width: lg);
  static const SizedBox gapHXL = SizedBox(width: xl);
}
