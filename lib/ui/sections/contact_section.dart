import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../l10n/app_localizations.dart';


class ContactSection extends StatefulWidget {
  const ContactSection({super.key});
  @override State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();

  @override void dispose() { _nameCtrl.dispose(); _emailCtrl.dispose(); _msgCtrl.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final name = Uri.encodeComponent(_nameCtrl.text.trim());
    final email = Uri.encodeComponent(_emailCtrl.text.trim());
    final msg = Uri.encodeComponent(_msgCtrl.text.trim());
    const prefix = 'mailto:kontakt@wddesignstudio.pl?subject=Zapytanie%20ze%20strony%20(';
    const middle = ')&body=';
    const suffix = '%0D%0D—%20';
    final uri = Uri.parse('$prefix$name$middle$msg$suffix$name%20($email)');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Przygotowuję wiadomość e‑mail…')));
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    return LayoutBuilder(builder: (context, c) {
      final wide = c.maxWidth > 900;
      return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(flex: wide ? 2 : 1, child: Padding(
          padding: const EdgeInsets.all(0),
          child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(t.contactForm, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextFormField(controller: _nameCtrl, decoration: InputDecoration(labelText: t.name),
              validator: (v) => (v == null || v.trim().isEmpty) ? t.enterName : null),
            const SizedBox(height: 12),
            TextFormField(controller: _emailCtrl, decoration: InputDecoration(labelText: t.email),
              validator: (v) { final r = RegExp('^[^@s]+@[^@s]+.[^@s]+'); if (v == null || v.trim().isEmpty) return t.enterEmail; if (!r.hasMatch(v.trim())) return t.incorrectEmail; return null; }),
            const SizedBox(height: 12),
            TextFormField(controller: _msgCtrl, decoration: InputDecoration(labelText: t.message, hintText: t.messageHint),
              maxLines: 6, validator: (v) => (v == null || v.trim().isEmpty) ? t.enterMessage : null),
            const SizedBox(height: 16),
            FilledButton.icon(onPressed: _submit, icon: const Icon(Icons.send), label: Text(t.send)),
          ])),
        )),
        SizedBox(width: wide ? 24 : 0, height: wide ? null : 24),
        Expanded(flex: 1, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _InfoCard(
  title: S.of(context).phone,
  leading: const FaIcon(
    FontAwesomeIcons.whatsapp,
    color: Color(0xFF25D366), // brand green
    size: 22,
  ),
  content: GestureDetector(
    onTap: () async {
      const phone = '48795186301'; // bez + i spacji
      final url = Uri.parse("https://wa.me/$phone?text=");
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    },
    child: const Text(
      '+48 795 186 301',
      style: TextStyle(
        color: Colors.teal,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline,
      ),
    ),
  ),
),


          const SizedBox(height: 12),
         _InfoCard(
  title: 'E-mail',
  leading: const Icon(Icons.mail_outline, size: 22),
  content: const Text('studio@dziegielewska.info'),
),


          const SizedBox(height: 12),
          Wrap(spacing: 8, children: [
            const Chip(label: Text('PL / EN / IT')),
          ]),
        ])),
      ]);
    });
  }
}


class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.content,
    this.leading,
  });

  final String title;
  final Widget content;
  final Widget? leading; // <— nowy

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 20, spreadRadius: -8, color: Color(0x1A000000))],
        color: Theme.of(context).cardTheme.color,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (leading != null) leading!,
          if (leading != null) const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                content,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
