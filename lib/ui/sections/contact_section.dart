import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../l10n/app_localizations.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});
  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  Uri _mailtoUri({
    required String to,
    String? subject,
    String? body,
  }) {
    return Uri(
      scheme: 'mailto',
      path: to,
      queryParameters: {
        if (subject != null && subject.isNotEmpty) 'subject': subject,
        if (body != null && body.isNotEmpty) 'body': body,
      },
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final msg = _msgCtrl.text.trim();

    final subject = 'Zapytanie ze strony ($name)';
    final signature = '\n\n— $name ($email)';
    final uri = _mailtoUri(
      to: 'kontakt@wddesignstudio.pl',
      subject: subject,
      body: '$msg$signature',
    );

    setState(() => _sending = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Przygotowuję wiadomość e-mail…')),
    );

    try {
      final ok = await canLaunchUrl(uri);
      if (!ok) throw 'Brak obsługi klienta e-mail.';
      final launched =
          await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched) throw 'Nie udało się otworzyć klienta e-mail.';
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Błąd: $e')),
      );
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _openWhatsApp() async {
    // numer bez plusa/spacji
    const phone = '48795186301';
    final url = Uri.parse('https://wa.me/$phone?text=');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Nie można otworzyć WhatsApp.';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Błąd: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    return LayoutBuilder(
      builder: (context, c) {
        final wide = c.maxWidth > 900;

        final form = Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.contactForm,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),

              // Imię i nazwisko
              TextFormField(
                controller: _nameCtrl,
                decoration: InputDecoration(
                  labelText: t.name,
                  hintText: t.enterName,
                ),
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.name],
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? t.enterName : null,
              ),
              const SizedBox(height: 12),

              // E-mail
              TextFormField(
                controller: _emailCtrl,
                decoration: InputDecoration(
                  labelText: t.email,
                  hintText: 'you@example.com',
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                validator: (v) {
                  final value = v?.trim() ?? '';
                  if (value.isEmpty) return t.enterEmail;
                  // prosty i bezpieczny regex (z escapami + domena)
                  final r = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
                  if (!r.hasMatch(value)) return t.incorrectEmail;
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Wiadomość
              TextFormField(
                controller: _msgCtrl,
                decoration: InputDecoration(
                  labelText: t.message,
                  hintText: t.messageHint,
                ),
                maxLines: 6,
                minLines: 4,
                textInputAction: TextInputAction.newline,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? t.enterMessage : null,
              ),
              const SizedBox(height: 16),

              // Wyślij
              SizedBox(
                width: 220,
                child: FilledButton.icon(
                  onPressed: _sending ? null : _submit,
                  icon: _sending
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send),
                  label: Text(t.send),
                ),
              ),
            ],
          ),
        );

        final info = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoCard(
              title: t.phone,
              leading: const FaIcon(
                FontAwesomeIcons.whatsapp,
                color: Color(0xFF25D366),
                size: 22,
              ),
              content: InkWell(
                onTap: _openWhatsApp,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    '+48 795 186 301',
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _InfoCard(
              title: 'E-mail',
              leading: const Icon(Icons.mail_outline, size: 22),
              content: SelectableText(
                'studio@dziegielewska.info',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                Chip(label: Text('PL / EN / IT')),
              ],
            ),
          ],
        );

        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 2,
                  child:
                      Padding(padding: const EdgeInsets.all(0), child: form)),
              const SizedBox(width: 24),
              Expanded(flex: 1, child: info),
            ],
          );
        } else {
          // MOBILE: wszystko w jednej kolumnie z oddzieleniem
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              form,
              const SizedBox(height: 20),
              const _MobileDivider(),
              const SizedBox(height: 20),
              info,
            ],
          );
        }
      },
    );
  }
}

class _MobileDivider extends StatelessWidget {
  const _MobileDivider();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 6,
        width: 64,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.06),
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
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
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardTheme.color ??
        Theme.of(context).colorScheme.surface;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(blurRadius: 20, spreadRadius: -8, color: Color(0x1A000000)),
        ],
        color: cardColor,
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
