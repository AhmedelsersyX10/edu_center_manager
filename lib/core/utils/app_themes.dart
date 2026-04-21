import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// 📦 RAW COLORS — لا تستخدمهم مباشرةً في الـ Widgets
// ═══════════════════════════════════════════════════════════════════════════════

class _C {
  // Sky Blues
  static const skyDeep = Color(0xFF0A4B6E);
  static const skyMid = Color(0xFF1275A0);
  static const skyBright = Color(0xFF2CA8D5);
  static const skyLight = Color(0xFF62C8E8);
  static const skyMist = Color(0xFFB8E4F4);

  // Night Blues
  static const nightAbyss = Color(0xFF060D18);
  static const nightDeep = Color(0xFF0A1628);
  static const nightMid = Color(0xFF102035);
  static const nightSteel = Color(0xFF1A3050);

  // Light Backgrounds
  static const dawnWhite = Color(0xFFF0F8FF);
  static const cloudWhite = Color(0xFFF8FCFF);
  static const mistBlue = Color(0xFFDEEEF8);
  static const silverBlue = Color(0xFF8AAFC4);

  // Gold
  static const gold = Color(0xFFCFA84C);
  static const goldSoft = Color(0xFFE8C86A);

  // Text
  static const inkNavy = Color(0xFF0C1E35);
  static const pearlWhite = Color(0xFFEBF4FA);

  // Error
  static const errorRed = Color(0xFFD32F2F);
  static const errorLight = Color(0xFFEF9A9A);
}

// ═══════════════════════════════════════════════════════════════════════════════
// 🎨 SEMANTIC COLORS — للاستخدام اليدوي لما يكون الـ Theme مش كافي
//    الاستخدام:  context.colors.primaryText
// ═══════════════════════════════════════════════════════════════════════════════

class AppThemeColors {
  const AppThemeColors._({
    required this.primaryText,
    required this.secondaryText,
    required this.hintText,
    required this.accent,
    required this.pageBackground,
    required this.cardBackground,
    required this.sheetBackground,
    required this.primaryButton,
    required this.primaryButtonText,
    required this.border,
    required this.progressIndicator,
    required this.disabled,
  });

  final Color primaryText; // النص الرئيسي
  final Color secondaryText; // النص الثانوي
  final Color hintText; // placeholder
  final Color accent; // العنصر الذهبي المميز
  final Color pageBackground; // خلفية الشاشة
  final Color cardBackground; // خلفية الكارد
  final Color sheetBackground; // خلفية BottomSheet / Dialog
  final Color primaryButton; // خلفية الزر الرئيسي
  final Color primaryButtonText; // نص الزر الرئيسي
  final Color border; // الحدود
  final Color progressIndicator; // شريط التقدم
  final Color disabled; // عناصر معطلة

  static const light = AppThemeColors._(
    primaryText: _C.inkNavy,
    secondaryText: _C.silverBlue,
    hintText: _C.silverBlue,
    accent: _C.gold,
    pageBackground: _C.dawnWhite,
    cardBackground: _C.cloudWhite,
    sheetBackground: _C.cloudWhite,
    primaryButton: _C.skyDeep,
    primaryButtonText: _C.cloudWhite,
    border: _C.mistBlue,
    progressIndicator: _C.skyMid,
    disabled: _C.silverBlue,
  );

  static const dark = AppThemeColors._(
    primaryText: _C.pearlWhite,
    secondaryText: _C.silverBlue,
    hintText: _C.silverBlue,
    accent: _C.goldSoft,
    pageBackground: _C.nightAbyss,
    cardBackground: _C.nightDeep,
    sheetBackground: _C.nightDeep,
    primaryButton: _C.skyMid,
    primaryButtonText: _C.pearlWhite,
    border: _C.nightMid,
    progressIndicator: _C.skyLight,
    disabled: _C.nightSteel,
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// ⚡ CONTEXT EXTENSION
// ═══════════════════════════════════════════════════════════════════════════════

extension AppThemeExtension on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  AppThemeColors get colors => isDark ? AppThemeColors.dark : AppThemeColors.light;
}

// ═══════════════════════════════════════════════════════════════════════════════
// 🔤 TEXT THEME — بيتطبق تلقائياً على كل Text() في التطبيق
// ═══════════════════════════════════════════════════════════════════════════════

TextTheme _textTheme(Color primary, Color secondary) => TextTheme(
  displayLarge: TextStyle(
    fontFamily: 'cairo',
    fontSize: 57,
    fontWeight: FontWeight.w400,
    color: primary,
  ),
  displayMedium: TextStyle(
    fontFamily: 'cairo',
    fontSize: 45,
    fontWeight: FontWeight.w400,
    color: primary,
  ),
  displaySmall: TextStyle(
    fontFamily: 'cairo',
    fontSize: 36,
    fontWeight: FontWeight.w400,
    color: primary,
  ),
  headlineLarge: TextStyle(
    fontFamily: 'cairo',
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: primary,
  ),
  headlineMedium: TextStyle(
    fontFamily: 'cairo',
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: primary,
  ),
  headlineSmall: TextStyle(
    fontFamily: 'cairo',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: primary,
  ),
  titleLarge: TextStyle(
    fontFamily: 'cairo',
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: primary,
  ),
  titleMedium: TextStyle(
    fontFamily: 'cairo',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: primary,
  ),
  titleSmall: TextStyle(
    fontFamily: 'cairo',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: primary,
  ),
  bodyLarge: TextStyle(
    fontFamily: 'cairo',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: primary,
  ),
  bodyMedium: TextStyle(
    fontFamily: 'cairo',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: primary,
  ),
  bodySmall: TextStyle(
    fontFamily: 'cairo',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: secondary,
  ),
  labelLarge: TextStyle(
    fontFamily: 'cairo',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: primary,
  ),
  labelMedium: TextStyle(
    fontFamily: 'cairo',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: secondary,
  ),
  labelSmall: TextStyle(
    fontFamily: 'cairo',
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: secondary,
  ),
);

// ═══════════════════════════════════════════════════════════════════════════════
// 🌞 LIGHT THEME
// ═══════════════════════════════════════════════════════════════════════════════

final ThemeData lightTheme = ThemeData.light(useMaterial3: false).copyWith(
  // ── ColorScheme — أساس كل الألوان التلقائية ──────────────────────────────
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: _C.skyDeep, // ElevatedButton، AppBar، Switch، Checkbox، ProgressIndicator
    onPrimary: _C.cloudWhite, // النص فوق primary
    secondary: _C.gold, // FAB، Chip selected، BottomNav selected
    onSecondary: _C.inkNavy, // النص فوق secondary
    surface: _C.cloudWhite, // Card، Dialog، BottomSheet، Drawer
    onSurface: _C.inkNavy, // ✅ النص الافتراضي لكل Text() في التطبيق
    error: _C.errorRed, // TextField error border، SnackBar error
    onError: _C.cloudWhite, // النص فوق error
    inversePrimary: _C.skyMid, // Timeline، CircularProgressIndicator
    inverseSurface: _C.gold, // Badge، عنصر مميز
    onInverseSurface: _C.inkNavy,
    primaryContainer: _C.mistBlue, // Chip unselected background
    onPrimaryContainer: _C.skyDeep,
    surfaceContainer: _C.dawnWhite, // Scaffold background
    secondaryContainer: _C.skyMist,
    onSecondaryContainer: _C.inkNavy,
  ),

  // ── Scaffold & Card ───────────────────────────────────────────────────────
  scaffoldBackgroundColor: _C.dawnWhite,
  cardColor: _C.cloudWhite,
  canvasColor: _C.cloudWhite,

  // ── Divider ───────────────────────────────────────────────────────────────
  dividerColor: _C.mistBlue,
  dividerTheme: const DividerThemeData(color: _C.mistBlue, thickness: 1, space: 1),

  // ── Icons ─────────────────────────────────────────────────────────────────
  iconTheme: const IconThemeData(color: _C.skyDeep),
  primaryIconTheme: const IconThemeData(color: _C.cloudWhite),

  // ── Disabled & Hint ───────────────────────────────────────────────────────
  disabledColor: _C.silverBlue,
  hintColor: _C.silverBlue,

  // ── Interaction ───────────────────────────────────────────────────────────
  highlightColor: const Color(0x2F2CA8D5),
  hoverColor: const Color(0x26B8E4F4),
  focusColor: const Color(0x1F1275A0),
  splashColor: const Color(0x1F2CA8D5),

  // ── Text ──────────────────────────────────────────────────────────────────
  textTheme: _textTheme(_C.inkNavy, _C.silverBlue),
  primaryTextTheme: _textTheme(_C.cloudWhite, _C.skyMist),

  // ── AppBar ────────────────────────────────────────────────────────────────
  appBarTheme: const AppBarTheme(
    backgroundColor: _C.skyDeep,
    foregroundColor: _C.cloudWhite,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: _C.cloudWhite),
    titleTextStyle: TextStyle(
      fontFamily: 'cairo',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _C.cloudWhite,
    ),
  ),

  // ── ElevatedButton ────────────────────────────────────────────────────────
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _C.skyDeep,
      foregroundColor: _C.cloudWhite,
      disabledBackgroundColor: _C.silverBlue,
      disabledForegroundColor: _C.cloudWhite,
      elevation: 2,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontFamily: 'cairo', fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),

  // ── TextButton ────────────────────────────────────────────────────────────
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: _C.skyMid,
      textStyle: const TextStyle(fontFamily: 'cairo', fontSize: 14, fontWeight: FontWeight.w600),
    ),
  ),

  // ── OutlinedButton ────────────────────────────────────────────────────────
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: _C.skyDeep,
      side: const BorderSide(color: _C.skyDeep, width: 1.5),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontFamily: 'cairo', fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),

  // ── FloatingActionButton ──────────────────────────────────────────────────
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: _C.gold,
    foregroundColor: _C.inkNavy,
    elevation: 4,
  ),

  // ── TextField ─────────────────────────────────────────────────────────────
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: _C.cloudWhite,
    hintStyle: const TextStyle(fontFamily: 'cairo', color: _C.silverBlue, fontSize: 14),
    labelStyle: const TextStyle(fontFamily: 'cairo', color: _C.silverBlue, fontSize: 14),
    errorStyle: const TextStyle(fontFamily: 'cairo', color: _C.errorRed, fontSize: 12),
    prefixIconColor: _C.silverBlue,
    suffixIconColor: _C.silverBlue,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _C.mistBlue, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _C.mistBlue, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _C.skyMid, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _C.errorRed, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _C.errorRed, width: 1.5),
    ),
  ),

  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color(0x472CA8D5),
    selectionHandleColor: _C.skyMid,
    cursorColor: _C.skyMid,
  ),

  // ── Card ──────────────────────────────────────────────────────────────────
  cardTheme: CardThemeData(
    color: _C.cloudWhite,
    elevation: 2,
    margin: const EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: _C.mistBlue, width: 0.5),
    ),
  ),

  // ── ListTile ──────────────────────────────────────────────────────────────
  listTileTheme: const ListTileThemeData(
    iconColor: _C.skyMid,
    textColor: _C.inkNavy,
    subtitleTextStyle: TextStyle(fontFamily: 'cairo', color: _C.silverBlue, fontSize: 12),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
  ),

  // ── Switch / Checkbox / Radio ─────────────────────────────────────────────
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith(
      (s) => s.contains(WidgetState.selected) ? _C.skyDeep : _C.silverBlue,
    ),
    trackColor: WidgetStateProperty.resolveWith(
      (s) => s.contains(WidgetState.selected) ? _C.skyMist : _C.mistBlue,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith(
      (s) => s.contains(WidgetState.selected) ? _C.skyDeep : Colors.transparent,
    ),
    checkColor: WidgetStateProperty.all(_C.cloudWhite),
    side: const BorderSide(color: _C.skyMid, width: 1.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith(
      (s) => s.contains(WidgetState.selected) ? _C.skyDeep : _C.silverBlue,
    ),
  ),

  // ── Chip ──────────────────────────────────────────────────────────────────
  chipTheme: ChipThemeData(
    backgroundColor: _C.mistBlue,
    selectedColor: _C.skyDeep,
    disabledColor: _C.mistBlue,
    labelStyle: const TextStyle(fontFamily: 'cairo', color: _C.inkNavy, fontSize: 13),
    secondaryLabelStyle: const TextStyle(fontFamily: 'cairo', color: _C.cloudWhite, fontSize: 13),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    side: BorderSide.none,
  ),

  // ── BottomNavigationBar ───────────────────────────────────────────────────
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: _C.cloudWhite,
    selectedItemColor: _C.skyDeep,
    unselectedItemColor: _C.silverBlue,
    elevation: 8,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(fontFamily: 'cairo', fontSize: 12, fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontFamily: 'cairo', fontSize: 11),
  ),

  // ── TabBar ────────────────────────────────────────────────────────────────
  tabBarTheme: const TabBarThemeData(
    labelColor: _C.skyDeep,
    unselectedLabelColor: _C.silverBlue,
    indicatorColor: _C.skyDeep,
    labelStyle: TextStyle(fontFamily: 'cairo', fontSize: 14, fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontFamily: 'cairo', fontSize: 14),
  ),

  // ── Dialog ────────────────────────────────────────────────────────────────
  dialogTheme: DialogThemeData(
    backgroundColor: _C.cloudWhite,
    elevation: 8,
    titleTextStyle: const TextStyle(
      fontFamily: 'cairo',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _C.inkNavy,
    ),
    contentTextStyle: const TextStyle(fontFamily: 'cairo', fontSize: 14, color: _C.inkNavy),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),

  // ── BottomSheet ───────────────────────────────────────────────────────────
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: _C.cloudWhite,
    elevation: 8,
    modalElevation: 16,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
  ),

  // ── Drawer ────────────────────────────────────────────────────────────────
  drawerTheme: const DrawerThemeData(
    backgroundColor: _C.cloudWhite,
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
    ),
  ),

  // ── SnackBar ──────────────────────────────────────────────────────────────
  snackBarTheme: SnackBarThemeData(
    backgroundColor: _C.inkNavy,
    contentTextStyle: const TextStyle(fontFamily: 'cairo', color: _C.pearlWhite, fontSize: 14),
    actionTextColor: _C.skyLight,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    behavior: SnackBarBehavior.floating,
  ),

  // ── ProgressIndicator ─────────────────────────────────────────────────────
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: _C.skyMid,
    linearTrackColor: _C.mistBlue,
    circularTrackColor: _C.mistBlue,
  ),

  // ── PopupMenu ─────────────────────────────────────────────────────────────
  popupMenuTheme: PopupMenuThemeData(
    color: _C.cloudWhite,
    elevation: 4,
    textStyle: const TextStyle(fontFamily: 'cairo', color: _C.inkNavy, fontSize: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // ── Tooltip ───────────────────────────────────────────────────────────────
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(color: _C.inkNavy, borderRadius: BorderRadius.circular(8)),
    textStyle: const TextStyle(fontFamily: 'cairo', color: _C.pearlWhite, fontSize: 12),
  ),

  // ── Cupertino / TimePicker ────────────────────────────────────────────────
  cupertinoOverrideTheme: const CupertinoThemeData(primaryColor: _C.skyMid),
  timePickerTheme: TimePickerThemeData(
    backgroundColor: _C.skyDeep,
    dialBackgroundColor: _C.dawnWhite,
    dialHandColor: _C.skyBright,
    dialTextColor: const Color(0xBF0C1E35),
    entryModeIconColor: const Color(0xB3EBF4FA),
    hourMinuteTextColor: const Color(0xE6EBF4FA),
    dayPeriodTextColor: const Color(0xE6EBF4FA),
    cancelButtonStyle: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(_C.nightSteel),
      foregroundColor: WidgetStateProperty.all(_C.pearlWhite),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      textStyle: WidgetStateProperty.all(const TextStyle(fontFamily: 'cairo', fontSize: 16)),
    ),
    confirmButtonStyle: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(_C.skyBright),
      foregroundColor: WidgetStateProperty.all(_C.cloudWhite),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      textStyle: WidgetStateProperty.all(const TextStyle(fontFamily: 'cairo', fontSize: 16)),
    ),
  ),
);

// ═══════════════════════════════════════════════════════════════════════════════
// 🌙 DARK THEME
// ═══════════════════════════════════════════════════════════════════════════════

final ThemeData darkTheme = ThemeData.dark(useMaterial3: false).copyWith(
  // ── ColorScheme ───────────────────────────────────────────────────────────
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: _C.skyMid, // ElevatedButton، AppBar، Switch، ProgressIndicator
    onPrimary: _C.pearlWhite, // النص فوق primary
    secondary: _C.goldSoft, // FAB، Chip selected
    onSecondary: _C.nightAbyss,
    surface: _C.nightDeep, // Card، Dialog، BottomSheet، Drawer
    onSurface: _C.pearlWhite, // ✅ النص الافتراضي لكل Text() في التطبيق
    error: _C.errorLight,
    onError: _C.nightAbyss,
    inversePrimary: _C.skyLight,
    inverseSurface: _C.goldSoft,
    onInverseSurface: _C.nightAbyss,
    primaryContainer: _C.nightSteel,
    onPrimaryContainer: _C.skyLight,
    surfaceContainer: _C.nightAbyss,
    secondaryContainer: _C.nightSteel,
    onSecondaryContainer: _C.pearlWhite,
  ),

  // ── Scaffold & Card ───────────────────────────────────────────────────────
  scaffoldBackgroundColor: _C.nightAbyss,
  cardColor: _C.nightDeep,
  canvasColor: _C.nightDeep,

  // ── Divider ───────────────────────────────────────────────────────────────
  dividerColor: _C.nightMid,
  dividerTheme: const DividerThemeData(color: _C.nightMid, thickness: 1, space: 1),

  // ── Icons ─────────────────────────────────────────────────────────────────
  iconTheme: const IconThemeData(color: _C.skyLight),
  primaryIconTheme: const IconThemeData(color: _C.pearlWhite),

  // ── Disabled & Hint ───────────────────────────────────────────────────────
  disabledColor: _C.nightSteel,
  hintColor: _C.silverBlue,

  // ── Interaction ───────────────────────────────────────────────────────────
  highlightColor: const Color(0x2462C8E8),
  hoverColor: const Color(0x14EBF4FA),
  focusColor: const Color(0x1F62C8E8),
  splashColor: const Color(0x1F62C8E8),

  // ── Text ──────────────────────────────────────────────────────────────────
  textTheme: _textTheme(_C.pearlWhite, _C.silverBlue),
  primaryTextTheme: _textTheme(_C.pearlWhite, _C.skyMist),

  // ── AppBar ────────────────────────────────────────────────────────────────
  appBarTheme: const AppBarTheme(
    backgroundColor: _C.nightDeep,
    foregroundColor: _C.pearlWhite,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: _C.pearlWhite),
    titleTextStyle: TextStyle(
      fontFamily: 'cairo',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _C.pearlWhite,
    ),
  ),

  // ── ElevatedButton ────────────────────────────────────────────────────────
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _C.skyMid,
      foregroundColor: _C.pearlWhite,
      disabledBackgroundColor: _C.nightSteel,
      disabledForegroundColor: _C.silverBlue,
      elevation: 2,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontFamily: 'cairo', fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),

  // ── TextButton ────────────────────────────────────────────────────────────
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: _C.skyLight,
      textStyle: const TextStyle(fontFamily: 'cairo', fontSize: 14, fontWeight: FontWeight.w600),
    ),
  ),

  // ── OutlinedButton ────────────────────────────────────────────────────────
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: _C.skyLight,
      side: const BorderSide(color: _C.skyLight, width: 1.5),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontFamily: 'cairo', fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),

  // ── FloatingActionButton ──────────────────────────────────────────────────
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: _C.goldSoft,
    foregroundColor: _C.nightAbyss,
    elevation: 4,
  ),

  // ── TextField ─────────────────────────────────────────────────────────────
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: _C.nightSteel,
    hintStyle: const TextStyle(fontFamily: 'cairo', color: _C.silverBlue, fontSize: 14),
    labelStyle: const TextStyle(fontFamily: 'cairo', color: _C.silverBlue, fontSize: 14),
    errorStyle: const TextStyle(fontFamily: 'cairo', color: _C.errorLight, fontSize: 12),
    prefixIconColor: _C.silverBlue,
    suffixIconColor: _C.silverBlue,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _C.nightMid, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _C.nightMid, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _C.skyLight, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _C.errorLight, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _C.errorLight, width: 1.5),
    ),
  ),

  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color(0x4062C8E8),
    selectionHandleColor: _C.skyLight,
    cursorColor: _C.skyLight,
  ),

  // ── Card ──────────────────────────────────────────────────────────────────
  cardTheme: CardThemeData(
    color: _C.nightDeep,
    elevation: 2,
    margin: const EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: _C.nightMid, width: 0.5),
    ),
  ),

  // ── ListTile ──────────────────────────────────────────────────────────────
  listTileTheme: const ListTileThemeData(
    iconColor: _C.skyLight,
    textColor: _C.pearlWhite,
    subtitleTextStyle: TextStyle(fontFamily: 'cairo', color: _C.silverBlue, fontSize: 12),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
  ),

  // ── Switch / Checkbox / Radio ─────────────────────────────────────────────
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith(
      (s) => s.contains(WidgetState.selected) ? _C.skyLight : _C.silverBlue,
    ),
    trackColor: WidgetStateProperty.resolveWith(
      (s) => s.contains(WidgetState.selected) ? _C.nightSteel : _C.nightMid,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith(
      (s) => s.contains(WidgetState.selected) ? _C.skyMid : Colors.transparent,
    ),
    checkColor: WidgetStateProperty.all(_C.pearlWhite),
    side: const BorderSide(color: _C.skyLight, width: 1.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith(
      (s) => s.contains(WidgetState.selected) ? _C.skyLight : _C.silverBlue,
    ),
  ),

  // ── Chip ──────────────────────────────────────────────────────────────────
  chipTheme: ChipThemeData(
    backgroundColor: _C.nightSteel,
    selectedColor: _C.skyMid,
    disabledColor: _C.nightMid,
    labelStyle: const TextStyle(fontFamily: 'cairo', color: _C.pearlWhite, fontSize: 13),
    secondaryLabelStyle: const TextStyle(fontFamily: 'cairo', color: _C.pearlWhite, fontSize: 13),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    side: BorderSide.none,
  ),

  // ── BottomNavigationBar ───────────────────────────────────────────────────
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: _C.nightDeep,
    selectedItemColor: _C.skyLight,
    unselectedItemColor: _C.silverBlue,
    elevation: 8,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(fontFamily: 'cairo', fontSize: 12, fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontFamily: 'cairo', fontSize: 11),
  ),

  // ── TabBar ────────────────────────────────────────────────────────────────
  tabBarTheme: const TabBarThemeData(
    labelColor: _C.skyLight,
    unselectedLabelColor: _C.silverBlue,
    indicatorColor: _C.skyLight,
    labelStyle: TextStyle(fontFamily: 'cairo', fontSize: 14, fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontFamily: 'cairo', fontSize: 14),
  ),

  // ── Dialog ────────────────────────────────────────────────────────────────
  dialogTheme: DialogThemeData(
    backgroundColor: _C.nightDeep,
    elevation: 8,
    titleTextStyle: const TextStyle(
      fontFamily: 'cairo',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _C.pearlWhite,
    ),
    contentTextStyle: const TextStyle(fontFamily: 'cairo', fontSize: 14, color: _C.pearlWhite),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),

  // ── BottomSheet ───────────────────────────────────────────────────────────
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: _C.nightDeep,
    elevation: 8,
    modalElevation: 16,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
  ),

  // ── Drawer ────────────────────────────────────────────────────────────────
  drawerTheme: const DrawerThemeData(
    backgroundColor: _C.nightDeep,
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
    ),
  ),

  // ── SnackBar ──────────────────────────────────────────────────────────────
  snackBarTheme: SnackBarThemeData(
    backgroundColor: _C.nightSteel,
    contentTextStyle: const TextStyle(fontFamily: 'cairo', color: _C.pearlWhite, fontSize: 14),
    actionTextColor: _C.skyLight,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    behavior: SnackBarBehavior.floating,
  ),

  // ── ProgressIndicator ─────────────────────────────────────────────────────
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: _C.skyLight,
    linearTrackColor: _C.nightSteel,
    circularTrackColor: _C.nightSteel,
  ),

  // ── PopupMenu ─────────────────────────────────────────────────────────────
  popupMenuTheme: PopupMenuThemeData(
    color: _C.nightDeep,
    elevation: 4,
    textStyle: const TextStyle(fontFamily: 'cairo', color: _C.pearlWhite, fontSize: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // ── Tooltip ───────────────────────────────────────────────────────────────
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(color: _C.nightSteel, borderRadius: BorderRadius.circular(8)),
    textStyle: const TextStyle(fontFamily: 'cairo', color: _C.pearlWhite, fontSize: 12),
  ),

  // ── Cupertino / TimePicker ────────────────────────────────────────────────
  cupertinoOverrideTheme: const CupertinoThemeData(primaryColor: _C.skyLight),
  timePickerTheme: TimePickerThemeData(
    backgroundColor: _C.nightMid,
    dialBackgroundColor: _C.nightSteel,
    dialHandColor: _C.skyLight,
    dialTextColor: const Color(0xBFEBF4FA),
    entryModeIconColor: const Color(0x99EBF4FA),
    hourMinuteTextColor: const Color(0xD9EBF4FA),
    dayPeriodTextColor: const Color(0xD9EBF4FA),
    dayPeriodColor: _C.nightSteel,
    cancelButtonStyle: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(const Color(0x1AEBF4FA)),
      foregroundColor: WidgetStateProperty.all(_C.pearlWhite),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      textStyle: WidgetStateProperty.all(const TextStyle(fontFamily: 'cairo', fontSize: 16)),
    ),
    confirmButtonStyle: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(_C.skyLight),
      foregroundColor: WidgetStateProperty.all(_C.nightAbyss),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      textStyle: WidgetStateProperty.all(const TextStyle(fontFamily: 'cairo', fontSize: 16)),
    ),
  ),
);
