import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joyflo_project/core/data/models/domain_model.dart';
import 'package:joyflo_project/core/data/models/user_contact_request.dart';
import 'package:joyflo_project/core/data/services/api_service.dart';
import 'package:joyflo_project/core/domains/usecases/get_domains_usecase.dart';
import 'package:joyflo_project/core/domains/usecases/user_contact_usecase.dart';
import 'package:joyflo_project/features/cubit/support_cubit.dart';
import 'package:joyflo_project/features/support/pages/support_form_images_page.dart';
import 'package:joyflo_project/shared/constants/icon_size.dart';
import 'package:joyflo_project/shared/constants/spacing.dart';
import 'package:joyflo_project/shared/constants/radius_values.dart';
import 'package:joyflo_project/shared/constants/padding_values.dart';
import 'package:joyflo_project/shared/widgets/bg_scaffold.dart';

class SupportFormPage extends StatefulWidget {
  final ApiService apiService;

  const SupportFormPage({super.key, required this.apiService});

  @override
  State<SupportFormPage> createState() => SupportFormPageState();
}

class SupportFormPageState extends State<SupportFormPage> {
  late final SupportCubit supportCubit;

  final TextEditingController dropdownController = TextEditingController();
  final TextEditingController textareaController = TextEditingController();
  final ScrollController textareaScrollController = ScrollController();

  List<DomainData> _domains = [];
  List<AssistanceImage> attachments = [];
  DomainData? selectedDomain;
  String? _errorMessage;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    supportCubit = SupportCubit(
      getDomainsUseCase: GetDomainsUseCase(apiService: widget.apiService),
      userContactUseCase: UserContactUseCase(apiService: widget.apiService),
    );
    _loadDomains();
  }

  Future<void> _loadDomains() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Get data from cubit
      final result = await supportCubit.getDomainsUseCase.execute();
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
    supportCubit.close();
    dropdownController.dispose();
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

    return BlocProvider.value(
      value: supportCubit,
      child: BackgroundScaffold(
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
                            SvgPicture.asset('assets/icons/main_icon_lg.svg', fit: BoxFit.contain),
                            const SizedBox(height: Spacing.v16),
                            SizedBox(
                              width: Spacing.h280,
                              child: Text(
                                "Ciao, come possiamo aiutarti?",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: themes.surfaceDim),
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
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: themes.surfaceDim),
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
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: themes.secondary),
                                  textAlign: TextAlign.start,
                                ),
                                decoration: InputDecoration(
                                  fillColor: themes.surface,
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(vertical: Spacing.v10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(RadiusValues.r20),
                                    borderSide: BorderSide(color: themes.shadow.withValues(alpha: 0.5)),
                                  ),
                                ),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: themes.surfaceDim),
                                items: _domains.map((e) {
                                  return DropdownMenuItem<DomainData>(
                                    value: e,
                                    child: Text(
                                      (e.domValue ?? ""),
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: themes.surfaceDim),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    selectedDomain = val;
                                    dropdownController.text = val?.domValue ?? '';
                                  });
                                },
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: Spacing.v250,
                                  decoration: BoxDecoration(color: themes.surface, borderRadius: BorderRadius.circular(RadiusValues.r20)),
                                  elevation: 0,
                                  scrollbarTheme: ScrollbarThemeData(thickness: WidgetStatePropertyAll(0)),
                                  offset: const Offset(0, -1),
                                ),
                                iconStyleData: IconStyleData(
                                  icon: Icon(CupertinoIcons.chevron_down, color: themes.secondary),
                                  iconSize: IconSize.s20,
                                ),
                                buttonStyleData: ButtonStyleData(padding: const EdgeInsets.only(right: Spacing.v10)),
                              ),
                            ),

                            const SizedBox(height: Spacing.v20),

                            // ---- TEXTAREA LABEL ----
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Formula la tua domanda",
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: themes.surfaceDim),
                              ),
                            ),
                            const SizedBox(height: Spacing.v16),

                            // ---- TEXTAREA ----
                            Container(
                              padding: const EdgeInsets.all(PaddingValues.p12),
                              decoration: BoxDecoration(
                                color: themes.surface,
                                borderRadius: BorderRadius.circular(RadiusValues.r10),
                                border: Border.all(color: themes.shadow.withValues(alpha: 0.8), width: 0.1),
                              ),
                              child: TextField(
                                controller: textareaController,
                                maxLength: 2000,
                                maxLines: 10,
                                keyboardType: TextInputType.multiline,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: themes.surfaceDim),
                                decoration: InputDecoration(
                                  hintText: "Inserisci qui la tua domanda",
                                  hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: themes.secondary),
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: Spacing.v20),
                            // Rest of the page
                            AssistanceImageSection(
                              supportCubit: supportCubit,
                              textareaController: textareaController,
                              selectedDomain: selectedDomain,
                              apiService: widget.apiService,
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
      ),
    );
  }
}
