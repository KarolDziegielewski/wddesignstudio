import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final data = <List<String>>[
      [t.faq1q, t.faq1a],
      [t.faq2q, t.faq2a],
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionPanelList.radio(
        expandedHeaderPadding: EdgeInsets.zero,
        children: List.generate(data.length, (i) {
          return ExpansionPanelRadio(
            value: i, // unikalna wartość
            headerBuilder: (context, isExpanded) =>
                ListTile(title: Text(data[i][0])),
            body: ListTile(title: Text(data[i][1])),
            canTapOnHeader: true,
          );
        }),
      ),
    );
  }
}
