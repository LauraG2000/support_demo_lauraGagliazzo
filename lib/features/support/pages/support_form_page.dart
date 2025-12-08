import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joyflo_project/shared/constants/icon_size.dart';
import 'package:joyflo_project/shared/constants/spacing.dart';
import 'package:joyflo_project/shared/constants/radius_values.dart';
import 'package:joyflo_project/shared/constants/padding_values.dart';
import 'package:joyflo_project/shared/widgets/bg_scaffold.dart';
import 'package:joyflo_project/shared/custom/action_buttons.dart';

class SupportFormPage extends StatefulWidget {
  const SupportFormPage({super.key});

  @override
  State<SupportFormPage> createState() => _SupportFormPageState();
}

class _SupportFormPageState extends State<SupportFormPage> {
  final TextEditingController _questionController = TextEditingController();

  final List<String> _sections = [
    "Pagamenti",
    "Ordini",
    "Altro",
    "Assistenza Tecnica",
    "Resi",
    "Account",
    "Spedizioni",
    "Promozioni, Offerte",
    "Feedback",
    "Collaborazioni",
    "Bug Segnalazioni",
    "Suggerimenti",
    "Domande Frequenti",
    "Informazioni Prodotti",
    "Politiche e Termini",
    "Supporto Generale",
  ];

  String? selectedSection;

  @override
  Widget build(BuildContext context) {
    final themes = Theme.of(context).colorScheme;

    return BackgroundScaffold(
      showBackButton: true, 
      child: Stack(
        children: [
          CustomScrollView(
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
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: themes.surfaceDim,
                        ),
                      ),
                    ),
                    const SizedBox(height: Spacing.v8),

                    // ---- DROPDOWN ----
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: Spacing.v40,
                            width: Spacing.h320,
                            child: DropdownButtonFormField2<String>(
                              isExpanded: true,
                              value: selectedSection,
                              hint: Text(
                                "Seleziona sezione o argomento",
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: themes.secondary),
                                textAlign: TextAlign.start, 
                              ),
                              decoration: InputDecoration(
                                fillColor: themes.surface,
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: Spacing.v10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    RadiusValues.r20,
                                  ),
                                  borderSide: BorderSide(
                                    color: themes.shadow.withValues(alpha: 0.5),
                                  ),
                                ),
                              ),
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: themes.surfaceDim),
                              items: _sections.map((e) {
                                return DropdownMenuItem<String>(
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
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 250,
                                decoration: BoxDecoration(
                                  color: themes.surface,
                                  borderRadius: BorderRadius.circular(
                                    RadiusValues.r20,
                                  ),
                                ),
                                elevation: 0,
                                scrollbarTheme: ScrollbarThemeData(
                                  thickness: WidgetStatePropertyAll(0),
                                ),
                                offset: const Offset(0, -1),
                              ),
                              iconStyleData: IconStyleData(
                                icon: Icon(
                                  CupertinoIcons.chevron_down,
                                  color: themes.secondary,
                                ),
                                iconSize: IconSize.s20,
                              ),
                              buttonStyleData: ButtonStyleData(
                                padding: const EdgeInsets.only(
                                  right:
                                      Spacing.v10,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: Spacing.v20),

                          // ---- TEXTAREA LABEL ----
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Formula la tua domanda",
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(color: themes.surfaceDim),
                            ),
                          ),
                          const SizedBox(height: Spacing.v16),

                          // ---- TEXTAREA ----
                          Container(
                            padding: const EdgeInsets.all(PaddingValues.p12),
                            decoration: BoxDecoration(
                              color: themes.surface,
                              borderRadius: BorderRadius.circular(
                                RadiusValues.r10,
                              ),
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
                                  maxLength: 2000,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: themes.surfaceDim),
                                  decoration: InputDecoration(
                                    hintText: "Inserisci qui la tua domanda",
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: themes.secondary),
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
                            Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                              horizontal: PaddingValues.p12,
                              ),
                              child: Text(
                              "Aggiungi immagini",
                              style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: themes.surfaceDim),
                              ),
                            ),
                            ),
                            const SizedBox(height: Spacing.v20),

                          // ---- ADD IMAGE ----
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: Spacing.h100,
                                height: Spacing.v100,
                                decoration: BoxDecoration(
                                  color: themes.onPrimary,
                                  borderRadius: BorderRadius.circular(
                                    RadiusValues.r20,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    CupertinoIcons.add,
                                    size: IconSize.s48,
                                    color: themes.surfaceContainerHighest,
                                  ),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
