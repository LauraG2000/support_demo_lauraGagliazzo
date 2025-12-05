import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joyflo_project/shared/constants/spacing.dart';
import 'package:joyflo_project/shared/constants/padding_values.dart';

class BackgroundScaffold extends StatelessWidget {
  final Widget child;

  const BackgroundScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(Spacing.v100),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: SvgPicture.asset(
            'assets/icons/navbar.svg',
            fit: BoxFit.cover,
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
