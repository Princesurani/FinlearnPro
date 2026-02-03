import 'package:flutter/material.dart';
abstract final class AppColors {
  static const Color primaryPurple = Color(0xFF6B4EF5);

  static const Color primaryPurpleLight = Color(0xFF907AF8);

  static const Color primaryPurpleDark = Color(0xFF5038D4);

  static const Color primaryPurpleSubtle = Color(0xFFF3F0FF);

  static const Color electricBlue = Color(0xFF4E8BF5);

  static const Color oceanTeal = Color(0xFF00BFA5);

  static const Color coralPink = Color(0xFFFF6B8A);

  static const Color sunsetOrange = Color(0xFFFF8A50);

  static const Color goldenYellow = Color(0xFFFFBD3D);

  static const Color mintGreen = Color(0xFF4ADE80);

  static const Color lavender = Color(0xFFA78BFA);

  static const Color rose = Color(0xFFF472B6);

  static const Color cyan = Color(0xFF22D3EE);

  static const Color amber = Color(0xFFFBBF24);

  static const Color indigo = Color(0xFF6366F1);

  static const Color emerald = Color(0xFF10B981);

  static const Color auroraPurple = Color(0xFF7C3AED);

  static const Color auroraBlue = Color(0xFF3B82F6);

  static const Color auroraCyan = Color(0xFF06B6D4);

  static const Color auroraPink = Color(0xFFEC4899);

  static const Color auroraTeal = Color(0xFF14B8A6);

  static const Color auroraDeep = Color(0xFF0F172A);

  static const Color auroraMist = Color(0xFF1E293B);

  static const Color success = Color(0xFF00BFA5);

  static const Color successLight = Color(0xFFE8F5F1);

  static const Color warning = Color(0xFFFFBD3D);

  static const Color warningLight = Color(0xFFFFF8E6);

  static const Color error = Color(0xFFFF5252);

  static const Color errorLight = Color(0xFFFFEBEB);

  static const Color info = Color(0xFF4E8BF5);

  static const Color infoLight = Color(0xFFE8F1FF);

  static const Color profitGreen = Color(0xFF00C853);

  static const Color lossRed = Color(0xFFFF5252);

  static const Color neutralGray = Color(0xFF9CA3AF);

  static const Color backgroundPrimary = Color(0xFFF8F9FE);

  static const Color backgroundSecondary = Color(0xFFFFFFFF);

  static const Color backgroundTertiary = Color(0xFFF1F5F9);

  static const Color surface = Color(0xFFFFFFFF);

  static const Color surfaceVariant = Color(0xFFF8FAFC);

  static const Color border = Color(0xFFE2E8F0);

  static const Color borderLight = Color(0xFFF1F5F9);

  static const Color divider = Color(0xFFE5E7EB);

  static const Color textPrimary = Color(0xFF1E293B);

  static const Color textSecondary = Color(0xFF64748B);

  static const Color textTertiary = Color(0xFF94A3B8);

  static const Color textDisabled = Color(0xFFCBD5E1);

  static const Color textOnPrimary = Color(0xFFFFFFFF);

  static const Color textOnDark = Color(0xFFFFFFFF);

  static const Color darkBackground = Color(0xFF0F172A);

  static const Color darkSurface = Color(0xFF1E293B);

  static const Color darkSurfaceVariant = Color(0xFF334155);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryPurple, primaryPurpleLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient auroraGradient = LinearGradient(
    colors: [auroraPurple, auroraBlue, auroraCyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [oceanTeal, mintGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient premiumGradient = LinearGradient(
    colors: [goldenYellow, sunsetOrange],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient learningGradient = LinearGradient(
    colors: [electricBlue, indigo],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Map<String, Color> categoryColors = {
    'stocks': electricBlue,
    'options': coralPink,
    'crypto': sunsetOrange,
    'forex': oceanTeal,
    'fundamentals': indigo,
    'technical': lavender,
    'risk': amber,
    'portfolio': emerald,
    'psychology': rose,
    'retirement': goldenYellow,
    'taxes': cyan,
    'bonds': mintGreen,
  };

  static Color withBackgroundOpacity(Color color) => color.withOpacity(0.08);

  static Color withHoverOpacity(Color color) => color.withOpacity(0.12);

  static Color withPressedOpacity(Color color) => color.withOpacity(0.16);

  static LinearGradient shimmerGradient(Color baseColor) => LinearGradient(
    colors: [
      baseColor.withOpacity(0.1),
      baseColor.withOpacity(0.2),
      baseColor.withOpacity(0.1),
    ],
    stops: const [0.0, 0.5, 1.0],
    begin: const Alignment(-1.0, 0.0),
    end: const Alignment(1.0, 0.0),
  );
}
