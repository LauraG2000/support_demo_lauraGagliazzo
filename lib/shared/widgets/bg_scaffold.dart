import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joyflo_project/shared/constants/icon_size.dart';
import 'package:joyflo_project/shared/constants/spacing.dart';
import 'package:joyflo_project/shared/constants/padding_values.dart';
import 'package:joyflo_project/core/themes/custom_colors.dart';
import 'package:joyflo_project/shared/constants/radius_values.dart';

class BackgroundScaffold extends StatelessWidget {
  final Widget child;
  final bool showBackButton;

  const BackgroundScaffold({
    required this.child,
    this.showBackButton = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themes = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(Spacing.v100),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,

          flexibleSpace: Stack(
            children: [
              SvgPicture.asset('assets/icons/navbar.svg', fit: BoxFit.cover),
              // ---- BACK BUTTON ----
              if (showBackButton)
                Positioned(
                  left: PaddingValues.p20,
                  top: PaddingValues.p40,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 1,
                      borderRadius: BorderRadius.circular(RadiusValues.r50),
                      child: Container(
                        width: Spacing.h49,
                        height: Spacing.h49,
                        decoration: BoxDecoration(
                          color: themes.surface,
                          borderRadius: BorderRadius.circular(RadiusValues.r50),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          CupertinoIcons.back,
                          color: themes.surfaceDim,
                          size: IconSize.s34,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // ---- BG LEAF BOTTOM LEFT ----
          Positioned(
            bottom: 0,
            left: 0,
            child: SvgPicture.asset(
              'assets/icons/bg_leaf_small.svg',
              fit: BoxFit.contain,
            ),
          ),
          // ---- BG LEAF CENTER RIGHT ----
          Positioned(
            top: 1,
            right: 0,
            child: SvgPicture.asset(
              'assets/icons/bg_leaf_large.svg',
              fit: BoxFit.contain,
            ),
          ),
          // ---- CONTENT ----
          Padding(
            padding: const EdgeInsets.all(PaddingValues.p20),
            child: child,
          ),
        ],
      ),
    );
  }
}
