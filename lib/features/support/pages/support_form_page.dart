import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joyflo_project/shared/constants/icon_size.dart';
import 'package:joyflo_project/shared/constants/spacing.dart';
import 'package:joyflo_project/shared/constants/radius_values.dart';
import 'package:joyflo_project/shared/constants/padding_values.dart';
import 'package:joyflo_project/shared/widgets/bg_scaffold.dart';
import 'package:joyflo_project/shared/custom/action_buttons.dart';

class SupportFormPage extends StatelessWidget {
  final TextEditingController _questionController = TextEditingController();

  final List<String> _sections = ["Pagamenti", "Ordini", "Altro"];

  SupportFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themes = Theme.of(context).colorScheme;

    String? selectedSection;

    return BackgroundScaffold(
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---- MAIN IMAGE + TEXT ----
                Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/main_icon_lg.svg',
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: Spacing.v16),
                      SizedBox(
                        width: Spacing.h280,
                        child: Text(
                          "Ciao, come possiamo aiutarti?",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: themes.surfaceDim),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: Spacing.v24),

                // ---- DROPDOWN LABEL ----
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Seleziona una sezione o argomento",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: themes.surfaceDim),
                  ),
                ),
                const SizedBox(height: Spacing.v8),

                // ---- DROPDOWN ----
                StatefulBuilder(
                  builder: (context, setState) {
                    return SizedBox(
                      height: Spacing.v40,
                      width: Spacing.h320,
                      child: DropdownButtonFormField<String>(
                        initialValue: selectedSection,
                        hint: Text(
                          "Seleziona sezione o argomento",
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: themes.surfaceContainerHighest),
                        ),
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            CupertinoIcons.chevron_down,
                            color: themes.surfaceDim.withValues(alpha: 0.5),
                            size: IconSize.s20,
                          ),
                        ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: themes.surfaceDim,
                        ),
                        items: _sections.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: themes.surfaceDim),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedSection = val;
                          });
                        },
                      ),
                    );
                  },
                ),

                const SizedBox(height: Spacing.v20),

                // ---- TEXTAREA LABEL ----
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Formula la tua domanda",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: themes.surfaceDim),
                  ),
                ),
                const SizedBox(height: Spacing.v16),

                // ---- TEXTAREA ----
                Container(
                  padding: const EdgeInsets.all(PaddingValues.p12),
                  decoration: BoxDecoration(
                    color: themes.surface,
                    borderRadius: BorderRadius.circular(RadiusValues.r10),
                    border: Border.all(
                      color: themes.shadow.withValues(alpha: 0.8),
                      width: 0.1,
                    ),
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: Spacing.v150,
                      maxHeight: Spacing.v600,
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,
                      interactive: true,
                      trackVisibility: false,
                      child: TextField(
                        controller: _questionController,
                        maxLength: 10, // "counter""
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: themes.surfaceDim,
                        ),
                        decoration: InputDecoration(
                          hintText: "Inserisci qui la tua domanda",
                          hintStyle: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: themes.surfaceContainerHighest),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: Spacing.v20),

                // ---- ADD IMAGE LABEL ----
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PaddingValues.p12,
                  ),
                  child: Text(
                    "Aggiungi immagini",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: themes.surfaceDim),
                  ),
                ),
                const SizedBox(height: Spacing.v20),

                // ---- ADD IMAGE ----
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: themes.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(
                          RadiusValues.r20,
                        ), // angoli smussati
                      ),
                      child: const Center(
                        child: Icon(Icons.add, size: IconSize.s28),
                      ),
                    ),
                    const SizedBox(width: Spacing.h16),
                  ],
                ),
                const SizedBox(height: Spacing.v32),

                // ---- BUTTONS ----
                ActionButtons(
                  onCancel: () => Navigator.pop(context),
                  onSubmit: () {},
                  primaryColor: themes.primary,
                  cancelColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
