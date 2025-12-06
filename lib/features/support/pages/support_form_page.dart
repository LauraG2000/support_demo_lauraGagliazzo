import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joyflo_project/shared/constants/spacing.dart';
import 'package:joyflo_project/shared/constants/radius_values.dart';
import 'package:joyflo_project/shared/constants/padding_values.dart';
import 'package:joyflo_project/shared/widgets/bg_scaffold.dart';

class SupportFormPage extends StatefulWidget {
  const SupportFormPage({super.key});

  @override
  State<SupportFormPage> createState() => _SupportFormPageState();
}

class _SupportFormPageState extends State<SupportFormPage> {
  final TextEditingController _questionController = TextEditingController();
  String? _selectedSection;
  bool _canSave = true;

  final List<String> _sections = ["Pagamenti", "Ordini", "Altro"];

  void _checkLength() {
    setState(() {
      _canSave = _questionController.text.length <= 10;
    });
  }

  @override
  void initState() {
    super.initState();
    _questionController.addListener(_checkLength);
  }

  @override
  void dispose() {
    _questionController.removeListener(_checkLength);
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themes = Theme.of(context).colorScheme;

    final ButtonStyle buttonStyle = OutlinedButton.styleFrom(
      minimumSize: const Size(PaddingValues.p100, PaddingValues.p36),
      padding: const EdgeInsets.symmetric(horizontal: Spacing.h20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusValues.r16),
      ),
      side: BorderSide(color: themes.shadow.withValues(alpha: 0.8), width: 0.2),
    );

    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusValues.r13),
      borderSide: BorderSide(
        color: themes.shadow.withValues(alpha: 0.8),
        width: 0.1,
      ),
    );

    return BackgroundScaffold(
      // ---- CONTENUTO ----
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(PaddingValues.p10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- MAIN IMAGE + TEXT ----
            Center(
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/icons/main_icon.svg',
                    width: Spacing.h100,
                    height: Spacing.v100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: Spacing.v16),
                  Text(
                    "Ciao, come possiamo aiutarti?",
                    textAlign: TextAlign.center,
                    style: Theme.of(context,
                    ).textTheme.bodyMedium?.copyWith(color: themes.surfaceDim),
                  ),
                ],
              ),
            ),

            const SizedBox(height: Spacing.v24),

            // ---- DROPDOWN ----
            Text(
              "Seleziona una sezione o un argomento",
              style: Theme.of(context,
              ).textTheme.bodyMedium?.copyWith(color: themes.surfaceDim),
            ),
            const SizedBox(height: Spacing.v16),

            DropdownButtonFormField<String>(
              initialValue: _selectedSection,
              decoration: InputDecoration(
                filled: true,
                fillColor: themes.surface,
                labelText: "Seleziona sezione",
                border: borderStyle,
                enabledBorder: borderStyle,
                focusedBorder: borderStyle,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
              ),
              items: _sections
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedSection = val;
                });
              },
            ),

            const SizedBox(height: Spacing.v20),

            // ---- TEXTFIELD ----
            Text(
              "Formula la tua domanda",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: themes.surfaceDim),
            ),
            const SizedBox(height: Spacing.v16),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: themes.surface,
                borderRadius: BorderRadius.circular(RadiusValues.r13),
                border: Border.all(
                  color: themes.shadow.withValues(alpha: 0.8),
                  width: 0.1,
                ),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 150,
                  maxHeight: 600,
                ),
                child: Scrollbar(
                  thumbVisibility: true,
                  interactive: true,
                  trackVisibility: false,
                  child: TextField(
                    controller: _questionController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    scrollPhysics: const ClampingScrollPhysics(),
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    decoration: const InputDecoration(
                      hintText: "Scrivi qui...",
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: Spacing.v20),

            // ---- ADD IMAGE ----
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: themes.surface.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(RadiusValues.r13),
                  ),
                  child: const Center(child: Icon(Icons.add, size: 28)),
                ),
                const SizedBox(width: Spacing.h16),
                Text(
                  "Aggiungi immagini",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: themes.surfaceDim),
                ),
              ],
            ),

            const SizedBox(height: Spacing.v32),
            // ---- BUTTONS ----
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: buttonStyle.copyWith(
                    backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                  ),
                  child: Text(
                    "Annulla",
                    style: TextStyle(color: themes.surfaceDim, fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: _canSave ? () {} : null,
                  style: buttonStyle.copyWith(
                    backgroundColor: WidgetStatePropertyAll(themes.primary),
                    foregroundColor: const WidgetStatePropertyAll(Colors.white),
                  ),
                  child: const Text("Invia"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// Todo: refactor dimensions and styles into constants and theme
// Todo: fix button add image alignment + text position
// Todo: split components