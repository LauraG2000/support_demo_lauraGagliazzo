import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joyflo_project/shared/widgets/bg_scaffold.dart';
import 'package:joyflo_project/shared/constants/spacing.dart';
import 'package:joyflo_project/shared/constants/radius_values.dart';
import 'support_form_page.dart';

class SupportHomePage extends StatelessWidget {
  const SupportHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      showBackButton: false,
      child: Column(
        children: [
          _SupportCard(
            assetPath: 'assets/icons/main_icon.svg',
            title: "Supporto tecnico",
            onTap: () {
              // ---- NAVIGATE TO SUPPORT FORM PAGE ----
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SupportFormPage()),
              );
            },
          ),
          const SizedBox(height: Spacing.v20),
          _SupportCard(
            assetPath: 'assets/icons/message_icon.svg',
            title: "Dicci cosa ne pensi",
            onTap: () {},
          ),
          const SizedBox(height: Spacing.v20),
          _SupportCard(
            assetPath: 'assets/icons/error_icon.svg',
            title: "Segnala un errore",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SupportCard extends StatelessWidget {
  final String assetPath;
  final String title;
  final VoidCallback onTap;

  const _SupportCard({
    required this.assetPath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = SvgPicture.asset(
      assetPath,
      width: Spacing.h80,
      height: Spacing.v80,
    );

    return Material(
      color: Theme.of(context).colorScheme.surface,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusValues.r10),
        side: BorderSide(
          color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.8),
          width: 0.1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(RadiusValues.r10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Spacing.v20,
            horizontal: Spacing.h5,
          ),
          child: Row(
            children: [
              imageWidget,
              const SizedBox(width: Spacing.h20),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.surfaceDim,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
