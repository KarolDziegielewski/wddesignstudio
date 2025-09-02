import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class LangSwitcher extends StatelessWidget {
  const LangSwitcher({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = LocaleController.of(context);
    final current = controller.value;
    Widget chip(String label, AppLocale locale) => ChoiceChip(
      label: Text(label),
      selected: current == locale,
      onSelected: (_) => controller.onChanged(locale),
    );
    return Row(mainAxisSize: MainAxisSize.min, children: [
      chip('PL', AppLocale.pl), const SizedBox(width: 6),
      chip('EN', AppLocale.en), const SizedBox(width: 6),
      chip('IT', AppLocale.it),
    ]);
  }
}