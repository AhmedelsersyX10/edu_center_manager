import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _Colors {
  // ── Sky Blues ───────────────────────────────────────────────────
  static const skyDeep = Color(0xFF0A4B6E); // أزرق سماوي عميق
  static const skyMid = Color(0xFF1275A0); // سماوي متوسط
  static const skyBright = Color(0xFF2CA8D5); // سماوي مضيء
  static const skyLight = Color(0xFF62C8E8); // سماوي فاتح — على الداكن
  static const skyMist = Color(0xFFB8E4F4); // ضباب سماوي — خافت جداً

  // ── Night Blues (Dark mode) ─────────────────────────────────────
  static const nightAbyss = Color(0xFF060D18); // الخلفية الليلية
  static const nightDeep = Color(0xFF0A1628); // كروت داكنة
  static const nightMid = Color(0xFF102035); // حدود داكنة
  static const nightSteel = Color(0xFF1A3050); // أسطح خافتة

  // ── Light Backgrounds ───────────────────────────────────────────
  static const dawnWhite = Color(0xFFF0F8FF); // خلفية رئيسية — أبيض فجري
  static const cloudWhite = Color(0xFFF8FCFF); // كروت — أبيض سحابي
  static const mistBlue = Color(0xFFDEEEF8); // حدود وفواصل
  static const silverBlue = Color(0xFF8AAFC4); // نص ثانوي

  // ── Gold accent ─────────────────────────────────────────────────
  static const gold = Color(0xFFCFA84C); // ذهبي أصيل — عنصر مميز
  static const goldSoft = Color(0xFFE8C86A); // ذهبي ناعم — على الداكن

  // ── Text ────────────────────────────────────────────────────────
  static const inkNavy = Color(0xFF0C1E35); // نص رئيسي light
  static const pearlWhite = Color(0xFFEBF4FA); // نص رئيسي dark
}

// ─── Light Theme ──────────────────────────────────────────────────────────────

final ThemeData lightTheme = ThemeData.light(useMaterial3: false).copyWith(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF0A4B6E), // أزرار، شريط التنقل
    onPrimary: _Colors.cloudWhite,
    secondary: _Colors.cloudWhite, // خلفية كروت
    onSecondary: _Colors.inkNavy,
    error: _Colors.mistBlue,
    onError: _Colors.silverBlue,
    surface: _Colors.skyMid, // timeline، حلقة التقدم، حدود
    onSurface: _Colors.inkNavy,
    inversePrimary: _Colors.inkNavy, // ← النص الرئيسي
    inverseSurface: _Colors.gold, // ← الذهبي
    primaryContainer: _Colors.cloudWhite, // bottom-sheets
    onPrimaryContainer: _Colors.mistBlue,
    onInverseSurface: _Colors.inkNavy,
    surfaceContainer: _Colors.dawnWhite, // scaffold
    secondaryContainer: _Colors.cloudWhite,
  ),
  primaryColor: _Colors.skyDeep,
  primaryColorLight: _Colors.skyBright,
  primaryColorDark: _Colors.inkNavy,
  dividerColor: _Colors.mistBlue,
  highlightColor: _Colors.skyBright.withValues(alpha: 0.18),
  scaffoldBackgroundColor: _Colors.dawnWhite,
  canvasColor: _Colors.pearlWhite,
  hoverColor: _Colors.skyMist.withValues(alpha: 0.40),
  disabledColor: _Colors.silverBlue,
  hintColor: _Colors.silverBlue,
  focusColor: _Colors.skyMid,
  secondaryHeaderColor: _Colors.skyMid,
  cardColor: _Colors.cloudWhite,
  dividerTheme: const DividerThemeData(color: _Colors.mistBlue, thickness: 1),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: _Colors.skyBright.withValues(alpha: 0.28),
    selectionHandleColor: _Colors.skyMid,
  ),
  cupertinoOverrideTheme: const CupertinoThemeData(primaryColor: _Colors.skyMid),
  timePickerTheme: TimePickerThemeData(
    backgroundColor: _Colors.skyDeep,
    dialBackgroundColor: _Colors.dawnWhite,
    dialHandColor: _Colors.skyBright,
    dialTextColor: _Colors.inkNavy.withValues(alpha: .75),
    entryModeIconColor: _Colors.pearlWhite.withValues(alpha: .7),
    hourMinuteTextColor: _Colors.pearlWhite.withValues(alpha: .90),
    dayPeriodTextColor: _Colors.pearlWhite.withValues(alpha: .90),
    cancelButtonStyle: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(_Colors.nightSteel),
      foregroundColor: WidgetStateProperty.all(_Colors.pearlWhite),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      textStyle: WidgetStateProperty.all(const TextStyle(fontFamily: 'cairo', fontSize: 16)),
    ),
    confirmButtonStyle: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(_Colors.skyBright),
      foregroundColor: WidgetStateProperty.all(_Colors.cloudWhite),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      textStyle: WidgetStateProperty.all(const TextStyle(fontFamily: 'cairo', fontSize: 16)),
    ),
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: 'cairo',
      fontSize: 12,
      color: _Colors.inkNavy,
    ),
  ),
);

// ─── Dark Theme ───────────────────────────────────────────────────────────────

final ThemeData darkTheme = ThemeData.dark(useMaterial3: false).copyWith(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: _Colors.nightDeep,
    onPrimary: _Colors.nightAbyss,
    secondary: _Colors.pearlWhite,
    onSecondary: _Colors.nightSteel,
    error: _Colors.nightDeep,
    onError: _Colors.nightAbyss,
    surface: _Colors.skyLight, // timeline، حلقة التقدم — يضيء على الداكن
    onSurface: _Colors.nightAbyss,
    inversePrimary: _Colors.pearlWhite, // ← النص الرئيسي
    inverseSurface: _Colors.goldSoft, // ← الذهبي الناعم
    primaryContainer: _Colors.nightDeep, // bottom-sheets
    onPrimaryContainer: _Colors.nightMid,
    onInverseSurface: _Colors.nightAbyss,
    surfaceContainer: _Colors.nightMid,
    secondaryContainer: _Colors.nightSteel,
  ),
  primaryColor: _Colors.nightSteel,
  primaryColorLight: _Colors.nightMid,
  primaryColorDark: _Colors.nightAbyss,
  dividerColor: _Colors.nightMid,
  highlightColor: _Colors.skyLight.withValues(alpha: 0.14),
  scaffoldBackgroundColor: _Colors.nightAbyss,
  canvasColor: _Colors.pearlWhite,
  hoverColor: _Colors.pearlWhite.withValues(alpha: 0.08),
  disabledColor: _Colors.nightAbyss,
  hintColor: _Colors.pearlWhite,
  focusColor: _Colors.nightDeep,
  secondaryHeaderColor: _Colors.nightDeep,
  cardColor: _Colors.pearlWhite,
  dividerTheme: const DividerThemeData(color: _Colors.nightMid, thickness: 1),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: _Colors.skyLight.withValues(alpha: 0.25),
    selectionHandleColor: _Colors.skyLight,
  ),
  cupertinoOverrideTheme: const CupertinoThemeData(primaryColor: _Colors.skyLight),
  timePickerTheme: TimePickerThemeData(
    backgroundColor: _Colors.nightMid,
    dialBackgroundColor: _Colors.nightSteel,
    dialHandColor: _Colors.skyLight,
    dialTextColor: _Colors.pearlWhite.withValues(alpha: .75),
    entryModeIconColor: _Colors.pearlWhite.withValues(alpha: .6),
    hourMinuteTextColor: _Colors.pearlWhite.withValues(alpha: .85),
    dayPeriodTextColor: _Colors.pearlWhite.withValues(alpha: .85),
    dayPeriodColor: _Colors.nightSteel,
    cancelButtonStyle: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(_Colors.pearlWhite.withValues(alpha: .10)),
      foregroundColor: WidgetStateProperty.all(_Colors.pearlWhite),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      textStyle: WidgetStateProperty.all(const TextStyle(fontFamily: 'cairo', fontSize: 16)),
    ),
    confirmButtonStyle: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(_Colors.skyLight),
      foregroundColor: WidgetStateProperty.all(_Colors.nightAbyss),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      textStyle: WidgetStateProperty.all(const TextStyle(fontFamily: 'cairo', fontSize: 16)),
    ),
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: 'cairo',
      fontSize: 12,
      color: _Colors.nightDeep,
    ),
  ),
);
