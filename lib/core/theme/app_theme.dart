import 'package:flutter/material.dart';
import 'tokens.dart';

ThemeData get appTheme {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: primaryTeal,
    brightness: Brightness.dark,
    surface: surfaceDark,
    onSurface: onSurfaceDark,
    error: errorRed,
  ).copyWith(
    primary: primaryTeal,
    onPrimary: backgroundDark,
    surface: surfaceDark,
    surfaceContainerHighest: surfaceVariantDark,
    onSurface: onSurfaceDark,
    onSurfaceVariant: onSurfaceMuted,
    error: errorRed,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: backgroundDark,
    cardColor: surfaceDark,
    dividerColor: surfaceVariantDark,
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundDark,
      foregroundColor: onSurfaceDark,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: onSurfaceDark,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
    ),
    cardTheme: CardThemeData(
      color: surfaceDark,
      elevation: elevationLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      margin: const EdgeInsets.symmetric(horizontal: spaceMd, vertical: spaceSm),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryTeal,
        foregroundColor: backgroundDark,
        disabledBackgroundColor: phaseLocked,
        disabledForegroundColor: onSurfaceMuted,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: spaceLg,
          vertical: spaceMd,
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: primaryTeal,
      unselectedItemColor: onSurfaceMuted,
      type: BottomNavigationBarType.fixed,
      elevation: elevationMid,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: surfaceVariantDark,
      labelStyle: TextStyle(color: onSurfaceDark, fontSize: 12),
      padding: const EdgeInsets.symmetric(horizontal: spaceSm, vertical: spaceXs),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusPill),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: onSurfaceDark,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        color: onSurfaceDark,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: onSurfaceDark,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: onSurfaceDark,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: onSurfaceDark,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyLarge: TextStyle(
        color: onSurfaceDark,
        fontSize: 16,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        color: onSurfaceDark,
        fontSize: 14,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        color: onSurfaceMuted,
        fontSize: 12,
        height: 1.4,
      ),
      labelLarge: TextStyle(
        color: onSurfaceDark,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        color: onSurfaceMuted,
        fontSize: 11,
        letterSpacing: 0.4,
        fontFamily: 'RobotoMono',
      ),
    ),
  );
}
