import 'package:flutter/material.dart';
import 'package:joyflo_project/shared/constants/radius_values.dart';
import 'package:joyflo_project/shared/constants/spacing.dart';
import 'package:joyflo_project/shared/constants/padding_values.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSubmit;
  final Color primaryColor;
  final Color cancelColor;

  const ActionButtons({
    super.key,
    required this.onCancel,
    required this.onSubmit,
    required this.primaryColor,
    required this.cancelColor,
  });

  @override
  Widget build(BuildContext context) {
    final themes = Theme.of(context).colorScheme;

  final ButtonStyle baseButtonStyle = OutlinedButton.styleFrom(
  minimumSize: const Size(PaddingValues.p40, PaddingValues.p32), 
  padding: const EdgeInsets.symmetric(horizontal: PaddingValues.p12, vertical:PaddingValues.p8), 
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(RadiusValues.r20),
  ),
  side: BorderSide(
    color: themes.shadow.withValues(alpha: 0.8),
    width: 0.2,
  ),
);

return Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    SizedBox(
      width: Spacing.h90,
      child: OutlinedButton(
        onPressed: onCancel,
        style: baseButtonStyle.copyWith(
          backgroundColor: WidgetStatePropertyAll(cancelColor),
        ),
        child: Text(
          "Annulla",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: themes.surfaceDim),
        ),
      ),
    ),
    const SizedBox(width: Spacing.h130),
    SizedBox(
      width: Spacing.h90,
      child: ElevatedButton(
        onPressed: onSubmit,
        style: baseButtonStyle.copyWith(
          backgroundColor: WidgetStatePropertyAll(primaryColor),
        ),
        child: Text(
          "Invia",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: themes.surface),
        ),
      ),
    ),
  ],
);
  }
}