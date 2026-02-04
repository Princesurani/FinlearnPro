import 'package:flutter/material.dart';

abstract final class AppShadows {

  static const Color shadowColor = Color(0xFF1E293B);

  static const Color shadowColorLight = Color(0xFF64748B);

  static const Color shadowColorPrimary = Color(0xFF6B4EF5);

  static const Color shadowColorSuccess = Color(0xFF00BFA5);

  static const Color shadowColorError = Color(0xFFFF5252);

  static const List<BoxShadow> none = [];

  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x08000000),
      blurRadius: 4,
      offset: Offset(0, 1),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x05000000),
      blurRadius: 2,
      offset: Offset(0, 1),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 8,
      offset: Offset(0, 2),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x06000000),
      blurRadius: 4,
      offset: Offset(0, 2),
      spreadRadius: -1,
    ),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x0C000000),
      blurRadius: 16,
      offset: Offset(0, 4),
      spreadRadius: -2,
    ),
    BoxShadow(
      color: Color(0x08000000),
      blurRadius: 8,
      offset: Offset(0, 4),
      spreadRadius: -2,
    ),
  ];

  static const List<BoxShadow> xl = [
    BoxShadow(
      color: Color(0x10000000),
      blurRadius: 24,
      offset: Offset(0, 8),
      spreadRadius: -4,
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 12,
      offset: Offset(0, 6),
      spreadRadius: -4,
    ),
  ];

  static const List<BoxShadow> xxl = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 32,
      offset: Offset(0, 12),
      spreadRadius: -6,
    ),
    BoxShadow(
      color: Color(0x0C000000),
      blurRadius: 16,
      offset: Offset(0, 8),
      spreadRadius: -6,
    ),
  ];

  static const List<BoxShadow> hero = [
    BoxShadow(
      color: Color(0x18000000),
      blurRadius: 48,
      offset: Offset(0, 16),
      spreadRadius: -8,
    ),
    BoxShadow(
      color: Color(0x10000000),
      blurRadius: 24,
      offset: Offset(0, 12),
      spreadRadius: -8,
    ),
  ];

  static List<BoxShadow> primaryGlow = [
    BoxShadow(
      color: shadowColorPrimary.withAlpha((0.25 * 255).round()),
      blurRadius: 16,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: shadowColorPrimary.withAlpha((0.15 * 255).round()),
      blurRadius: 8,
      offset: const Offset(0, 2),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> primaryGlowIntense = [
    BoxShadow(
      color: shadowColorPrimary.withAlpha((0.35 * 255).round()),
      blurRadius: 24,
      offset: const Offset(0, 6),
      spreadRadius: -2,
    ),
    BoxShadow(
      color: shadowColorPrimary.withAlpha((0.2 * 255).round()),
      blurRadius: 12,
      offset: const Offset(0, 4),
      spreadRadius: -2,
    ),
  ];

  static List<BoxShadow> successGlow = [
    BoxShadow(
      color: shadowColorSuccess.withAlpha((0.25 * 255).round()),
      blurRadius: 16,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: shadowColorSuccess.withAlpha((0.15 * 255).round()),
      blurRadius: 8,
      offset: const Offset(0, 2),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> errorGlow = [
    BoxShadow(
      color: shadowColorError.withAlpha((0.25 * 255).round()),
      blurRadius: 16,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: shadowColorError.withAlpha((0.15 * 255).round()),
      blurRadius: 8,
      offset: const Offset(0, 2),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> cardRest = md;

  static const List<BoxShadow> cardHover = lg;

  static const List<BoxShadow> cardPressed = sm;

  static const List<BoxShadow> buttonRest = md;

  static List<BoxShadow> buttonHover = primaryGlow;

  static const List<BoxShadow> buttonPressed = sm;

  static const List<BoxShadow> darkSm = [
    BoxShadow(
      color: Color(0x40000000),
      blurRadius: 4,
      offset: Offset(0, 1),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> darkMd = [
    BoxShadow(
      color: Color(0x50000000),
      blurRadius: 8,
      offset: Offset(0, 2),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> darkLg = [
    BoxShadow(
      color: Color(0x60000000),
      blurRadius: 16,
      offset: Offset(0, 4),
      spreadRadius: -2,
    ),
  ];

  static List<BoxShadow> darkPrimaryGlow = [
    BoxShadow(
      color: shadowColorPrimary.withAlpha((0.4 * 255).round()),
      blurRadius: 20,
      offset: const Offset(0, 4),
      spreadRadius: -2,
    ),
  ];

  static const List<BoxShadow> innerSm = [
    BoxShadow(
      color: Color(0x08000000),
      blurRadius: 4,
      offset: Offset(0, 2),
      spreadRadius: -1,
    ),
  ];

  static const List<BoxShadow> innerMd = [
    BoxShadow(
      color: Color(0x0C000000),
      blurRadius: 8,
      offset: Offset(0, 4),
      spreadRadius: -2,
    ),
  ];

  static const List<BoxShadow> glassShadow = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 24,
      offset: Offset(0, 8),
      spreadRadius: -4,
    ),
    BoxShadow(
      color: Color(0x05FFFFFF),
      blurRadius: 0,
      offset: Offset(0, 1),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> neonGlow(Color color) => [
    BoxShadow(
      color: color.withAlpha((0.5 * 255).round()),
      blurRadius: 20,
      spreadRadius: -4,
    ),
    BoxShadow(
      color: color.withAlpha((0.3 * 255).round()),
      blurRadius: 40,
      spreadRadius: -8,
    ),
  ];

  static const List<BoxShadow> ambient = [
    BoxShadow(
      color: Color(0x06000000),
      blurRadius: 40,
      offset: Offset(0, 20),
      spreadRadius: -10,
    ),
    BoxShadow(
      color: Color(0x04000000),
      blurRadius: 20,
      offset: Offset(0, 10),
      spreadRadius: -5,
    ),
  ];

  static const List<Shadow> textShadowSm = [
    Shadow(
      color: Color(0x20000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  static const List<Shadow> textShadowMd = [
    Shadow(
      color: Color(0x30000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  static const List<Shadow> textShadowLg = [
    Shadow(
      color: Color(0x50000000),
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
  ];

  static List<Shadow> textGlow(Color color) => [
    Shadow(
      color: color.withAlpha((0.5 * 255).round()),
      blurRadius: 20,
    ),
  ];

  static List<BoxShadow> colored({
    required Color color,
    double opacity = 0.25,
    double blur = 16,
    Offset offset = const Offset(0, 4),
  }) {
    return [
      BoxShadow(
        color: color.withAlpha((opacity * 255).round()),
        blurRadius: blur,
        offset: offset,
        spreadRadius: 0,
      ),
    ];
  }

  static List<BoxShadow> lerp(
    List<BoxShadow> begin,
    List<BoxShadow> end,
    double t,
  ) {
    if (begin.isEmpty && end.isEmpty) return [];
    if (begin.isEmpty) {
      return end
          .map((s) => BoxShadow(
                color: Color.lerp(Colors.transparent, s.color, t)!,
                blurRadius: s.blurRadius * t,
                offset: s.offset * t,
                spreadRadius: s.spreadRadius * t,
              ))
          .toList();
    }
    if (end.isEmpty) {
      return begin
          .map((s) => BoxShadow(
                color: Color.lerp(s.color, Colors.transparent, t)!,
                blurRadius: s.blurRadius * (1 - t),
                offset: s.offset * (1 - t),
                spreadRadius: s.spreadRadius * (1 - t),
              ))
          .toList();
    }

    final result = <BoxShadow>[];
    final maxLength =
        begin.length > end.length ? begin.length : end.length;

    for (int i = 0; i < maxLength; i++) {
      final s1 = i < begin.length ? begin[i] : const BoxShadow();
      final s2 = i < end.length ? end[i] : const BoxShadow();
      result.add(BoxShadow.lerp(s1, s2, t)!);
    }

    return result;
  }
}

extension ShadowExtensions on List<BoxShadow> {
  List<BoxShadow> combine(List<BoxShadow> other) => [...this, ...other];

  List<BoxShadow> scale(double factor) => map((shadow) => BoxShadow(
        color: shadow.color.withAlpha(
          ((shadow.color.a * factor).clamp(0, 255)).round(),
        ),
        blurRadius: shadow.blurRadius * factor,
        offset: shadow.offset * factor,
        spreadRadius: shadow.spreadRadius * factor,
      )).toList();
}
