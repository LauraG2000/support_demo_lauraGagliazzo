import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joyflo_project/core/data/services/api_service.dart';
import 'package:joyflo_project/features/cubit/support_cubit.dart';
import 'package:joyflo_project/features/cubit/state/support_state.dart';
import 'package:joyflo_project/core/data/models/user_contact_request.dart';
import 'package:joyflo_project/core/data/models/domain_model.dart';
import 'package:joyflo_project/shared/constants/icon_size.dart';
import 'package:joyflo_project/shared/constants/padding_values.dart';
import 'package:joyflo_project/shared/constants/spacing.dart';
import 'package:joyflo_project/shared/constants/radius_values.dart';
import 'package:joyflo_project/features/support/pages/support_home_page.dart';
import 'package:joyflo_project/shared/custom/action_buttons.dart';

class AssistanceImageSection extends StatefulWidget {
  final SupportCubit supportCubit;
  final TextEditingController textareaController;
  final DomainData? selectedDomain;
  final ApiService apiService;

  const AssistanceImageSection({
    super.key,
    required this.supportCubit,
    required this.textareaController,
    required this.selectedDomain,
    required this.apiService,
  });

  @override
  State<AssistanceImageSection> createState() => _AssistanceImageSectionState();
}

class _AssistanceImageSectionState extends State<AssistanceImageSection> {
  List<AssistanceImage> attachments = [];

  @override
  Widget build(BuildContext context) {
    final themes = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- ADD IMAGE LABEL----
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Aggiungi immagini", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: themes.surfaceDim)),
              const SizedBox(width: Spacing.h5),
              Text("(Massimo 5)", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: themes.surfaceDim)),
            ],
          ),
        ),
        const SizedBox(height: Spacing.v20),
        Align(
          alignment: Alignment.centerLeft,
          child: BlocBuilder<SupportCubit, SupportState>(
            builder: (context, state) {
              attachments = List<AssistanceImage>.from(state.images);

              return Wrap(
                spacing: PaddingValues.p8,
                runSpacing: PaddingValues.p8,
                children: [
                  // --- SHOW IMAGES ---
                  ...state.images.map((img) {
                    return Stack(
                      children: [
                        // img:
                        Container(
                          width: Spacing.h100,
                          height: Spacing.v100,
                          decoration: BoxDecoration(
                            color: themes.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(RadiusValues.r10),
                            image: DecorationImage(image: MemoryImage(base64Decode(img.img)), fit: BoxFit.cover),
                          ),
                        ),

                        // Remove img
                        Positioned(
                          top: PaddingValues.p2,
                          right: PaddingValues.p2,
                          child: GestureDetector(
                            onTap: () {
                              context.read<SupportCubit>().removeImage(img);
                            },
                            child: Container(
                              width: Spacing.h20,
                              height: Spacing.v20,
                              decoration: BoxDecoration(color: themes.surface.withValues(alpha: 0.8), shape: BoxShape.circle),
                              child: Center(
                                child: Icon(Icons.remove, size: IconSize.s16, color: themes.primary),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),

                  // Button ADD
                  if (state.canAddImage)
                    Material(
                      color: themes.onPrimary,
                      borderRadius: BorderRadius.circular(RadiusValues.r10),
                      child: Builder(
                        builder: (context) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(RadiusValues.r10),
                            onTap: () async {
                              final result = await context.read<SupportCubit>().pickImageFromCamera(context);
                              if (result.isNotEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                              }
                            },
                            child: SizedBox(
                              width: Spacing.h100,
                              height: Spacing.v100,
                              child: Center(
                                child: Icon(CupertinoIcons.add, size: IconSize.s48, color: themes.surfaceContainerHighest),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        ),

        const SizedBox(height: Spacing.v32),

        // Buttons
        ActionButtons(
          onCancel: () => Navigator.pop(context),
          onSubmit: () async {
            if (widget.selectedDomain == null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Seleziona un argomento"), backgroundColor: Theme.of(context).colorScheme.onError));
              return;
            }
            if (widget.textareaController.text.trim().isEmpty) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Inserisci un messaggio"), backgroundColor: Theme.of(context).colorScheme.onError));
              return;
            }
            // User Request
            final request = UserContactRequest(
              userId: 1, // Not having a login -> ID is setted as a constant
              typeRequest: 19785, // Defaulted to 19785 -> not documented
              typeQuestion: widget.selectedDomain!.idDomain,
              message: widget.textareaController.text.trim(),
              images: attachments,
            );

            try {
              final _ = await widget.supportCubit.sendAssistanceRequest(request);
              // SUCCESS dialog
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(RadiusValues.r16)),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(PaddingValues.p24),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/dialog_ok.svg',
                                width: Spacing.h280,
                                height: Spacing.v370,
                                fit: BoxFit.contain,
                              ),
                              Text(
                                "La tua domanda è stata inviata con successo!",
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: themes.surfaceDim),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                              const SizedBox(height: Spacing.h16),
                              Text(
                                "Verrai ricontattato presto tramite mail",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: themes.surfaceDim.withValues(alpha: 0.7)),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                              const SizedBox(height: Spacing.h24),
                              // Button OK
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: themes.primary),
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => SupportHomePage(apiService: widget.apiService)),
                                      (route) => false, // remove other pages
                                    );
                                  },
                                  child: Text("OK", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: themes.surface)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Icon close
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          icon: Icon(Icons.close, size: IconSize.s34, color: themes.surfaceDim),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => SupportHomePage(apiService: widget.apiService)),
                              (route) => false,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } catch (e) {
              // ---- Dialog ERROR ----
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(RadiusValues.r16)),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(PaddingValues.p24),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // ---- SizedBox al posto dell'immagine ----
                              SvgPicture.asset(
                                'assets/icons/dialog_error.svg',
                                width: Spacing.h280,
                                height: Spacing.v370,
                                fit: BoxFit.contain,
                              ),

                              // ---- Testo con colore dal tema ----
                              Text(
                                "Errore nell'invio della richiesta.",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.error),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: Spacing.v24),
                              // ---- Button RETRY ----
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    side: BorderSide(color: themes.primary),
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("RIPROVA"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Icon close
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          icon: Icon(Icons.close, size: IconSize.s34, color: themes.surfaceDim),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
          primaryColor: themes.primary,
          cancelColor: Colors.transparent,
        ),
      ],
    );
  }
}
