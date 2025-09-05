import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

/// A section displaying a list of frequently asked questions using expansion panels.
class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Get localized strings
    final t = S.of(context);

    // Prepare FAQ data as a list of [question, answer] pairs
    final data = <List<String>>[
      [t.faq1q, t.faq1a],
      [t.faq2q, t.faq2a],
      [t.faq3q, t.faq3a],
      [t.faq4q, t.faq4a],
      [t.faq5q, t.faq5a],
      [t.faq6q, t.faq6a],
      [t.faq7q, t.faq7a],
      [t.faq8q, t.faq8a],
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      // Display FAQ items as an expandable list
      child: ExpansionPanelList.radio(
        expandedHeaderPadding: EdgeInsets.zero,
        children: List.generate(
          data.length,
          (i) => ExpansionPanelRadio(
            value: i, // Unique value for each panel
            headerBuilder: (context, isExpanded) =>
                ListTile(title: Text(data[i][0])),
            body: ListTile(title: Text(data[i][1])),
            canTapOnHeader: true,
          ),
        ),
      ),
    );
  }
}
