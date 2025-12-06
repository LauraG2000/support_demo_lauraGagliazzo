import 'package:flutter/material.dart';
import 'package:joyflo_project/core/themes/custom_colors.dart';
import 'package:joyflo_project/shared/constants/icon_size.dart';
import 'package:joyflo_project/shared/constants/radius_values.dart';

class Themes {
  static final ThemeData mainTheme = ThemeData(
    useMaterial3: true,

    // ColorScheme 
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: CustomColors.primary,
      onPrimary: CustomColors.primary,
      secondary: CustomColors.secondary,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      onSurface: CustomColors.background,
      surfaceContainerHighest: CustomColors.textPrimary,
      surface: CustomColors.card,
      surfaceDim: CustomColors.textPrimary,
      shadow: CustomColors.cardBorder,
    ),
     splashFactory: NoSplash.splashFactory, 

    scaffoldBackgroundColor: CustomColors.background,

    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(color: CustomColors.primary),
    ),

    cardTheme: (
      CardThemeData(
        color: CustomColors.card,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusValues.r13),
        ),
        shadowColor: Colors.black26,
        margin: const EdgeInsets.symmetric(vertical: 8),
      )
    ),

    iconTheme: IconThemeData(
      size: IconSize.s32,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
    ),
  );
}
