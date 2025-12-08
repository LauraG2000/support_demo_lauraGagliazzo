import 'package:flutter/material.dart';
import 'package:joyflo_project/core/themes/custom_colors.dart';
import 'package:joyflo_project/shared/constants/radius_values.dart';

class Themes {
  static final ThemeData mainTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",

    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: CustomColors.primary,
      onPrimary: CustomColors.iconAddBg,
      secondary: CustomColors.textSecondary,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.red,
      onSurface: CustomColors.background,
      surfaceContainerHighest: CustomColors.iconAdd,
      surface: CustomColors.card,
      surfaceDim: CustomColors.textPrimary,
      shadow: CustomColors.cardBorder,
    ),

    splashFactory: NoSplash.splashFactory,
    scaffoldBackgroundColor: CustomColors.background,

    // TEXT THEME (globale Poppins)
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
      titleMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    ),

    // FORM GLOBAL STYLE
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: CustomColors.textPrimary, 
      hintStyle: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: CustomColors.textSecondary, 
      ),
     contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusValues.r20),
        borderSide: BorderSide(
          color: CustomColors.cardBorder.withValues(alpha: 0.8),
          width: 0.1,
        ),
      ), 
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusValues.r20),
        borderSide: BorderSide(
          color: CustomColors.cardBorder.withValues(alpha: 0.8),
          width: 0.1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusValues.r20),
        borderSide: BorderSide(
          color: CustomColors.cardBorder.withValues(alpha: 0.8),
          width: 0.1,
        ),
      ),
    ),

    // DROPDOWN STYLE GLOBALE
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: CustomColors.textPrimary,
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(CustomColors.card), 
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RadiusValues.r20),
            side: BorderSide(
              color: CustomColors.cardBorder.withValues(alpha: 0.8),
              width: 0.1,
            ),
          ),
        ),
      ),
    ),
  );
}
