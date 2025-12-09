import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joyflo_project/core/data/models/domain_model.dart';
import 'package:joyflo_project/core/data/services/api_service.dart';
import 'package:joyflo_project/core/domains/usecases/get_domains_usecase.dart';
import 'package:joyflo_project/features/cubit/support_cubit.dart';
import 'package:joyflo_project/shared/constants/icon_size.dart';
import 'package:joyflo_project/shared/constants/spacing.dart';
import 'package:joyflo_project/shared/constants/radius_values.dart';
import 'package:joyflo_project/shared/constants/padding_values.dart';
import 'package:joyflo_project/shared/widgets/bg_scaffold.dart';
import 'package:joyflo_project/shared/custom/action_buttons.dart';

class SupportFormPage extends StatefulWidget {
  final ApiService apiService;

  const SupportFormPage({super.key, required this.apiService});

  @override
  State<SupportFormPage> createState() => _SupportFormPageState();
}

class _SupportFormPageState extends State<SupportFormPage> {
  late final SupportCubit _supportCubit;

  final TextEditingController _dropdownController = TextEditingController();
  final TextEditingController _textareaController = TextEditingController();
  final ScrollController _textareaScrollController = ScrollController(
    initialScrollOffset: 0,
  );
  //lg
  List<DomainData> _domains = [];
  DomainData? selectedDomain;
  String? _errorMessage;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _supportCubit = SupportCubit(
      getDomainsUseCase: GetDomainsUseCase(apiService: widget.apiService),
    );
    _loadDomains();
  }

  Future<void> _loadDomains() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Recupero i dati tramite Cubit (solo chiamata)
      final result = await _supportCubit.getDomainsUseCase.execute();
      if (result.isSuccess) {
        setState(() {
          _domains = result.domains!;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = result.error ?? "Errore sconosciuto";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _supportCubit.close();
    _dropdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themes = Theme.of(context).colorScheme;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(child: Text("Errore: $_errorMessage"));
    }

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
                            child: DropdownButtonFormField2<DomainData>(
                              isExpanded: true,
                              value: selectedDomain,
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
                              items: _domains.map((e) {
                                return DropdownMenuItem<DomainData>(
                                  value: e,
                                  child: Text(
                                    (e.domValue ?? ""),
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: themes.surfaceDim),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  selectedDomain = val;
                                  _dropdownController.text =
                                      val?.domValue ?? '';
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
                                  right: Spacing.v10,
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
                                controller: _textareaScrollController,
                                thumbVisibility: true,
                                interactive: true,
                                trackVisibility: false,
                                child: SingleChildScrollView(
                                  controller: _textareaScrollController,
                                  child: TextField(
                                    controller: _textareaController,
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
