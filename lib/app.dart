import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'ui/sections/about_section.dart';
import 'ui/sections/projects_section.dart';
import 'ui/sections/offer_section.dart';
import 'ui/sections/contact_section.dart';
import 'ui/sections/faq_section.dart';
import 'widgets/lang_switcher.dart';
import 'widgets/section_shell.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _aboutKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _offerKey = GlobalKey();
  final _contactKey = GlobalKey();
  final _faqKey = GlobalKey();

  final _scrollCtrl = ScrollController();

  double _offset = 0;
  bool get _isMobile => MediaQuery.of(context).size.width < 900;

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(() {
      setState(() => _offset = _scrollCtrl.offset);
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
      alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);

    // Opacity i cień AppBar po scrollu (0..1)
    final appBarOpacity = (_offset / 180).clamp(0, 1).toDouble();
    final blurSigma = 12.0 * appBarOpacity;
    final elevation = 8.0 * appBarOpacity;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: _isMobile,
        elevation: elevation,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Text('WD Design Studio',
                  style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              if (!_isMobile)
                Row(children: [
                  _NavBtn(label: t.about, onTap: () => _scrollTo(_aboutKey)),
                  _NavBtn(
                      label: t.projects, onTap: () => _scrollTo(_projectsKey)),
                  _NavBtn(label: t.offer, onTap: () => _scrollTo(_offerKey)),
                  _NavBtn(
                      label: t.contact, onTap: () => _scrollTo(_contactKey)),
                  _NavBtn(label: t.faq, onTap: () => _scrollTo(_faqKey)),
                ]),
              const SizedBox(width: 8),
              const LangSwitcher(),
              const SizedBox(width: 16),
            ],
          ),
        ),
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context)
                        .colorScheme
                        .surface
                        .withOpacity(0.38 * appBarOpacity),
                    Theme.of(context)
                        .colorScheme
                        .surface
                        .withOpacity(0.24 * appBarOpacity),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                color: Colors.transparent, // nic nie narzuca, czysty glass
              ),
            ),
          ),
        ),
      ),
      drawer: _isMobile
          ? _MobileDrawer(onSelect: _scrollTo, keys: {
              'about': _aboutKey,
              'projects': _projectsKey,
              'offer': _offerKey,
              'contact': _contactKey,
              'faq': _faqKey,
            })
          : null,
      body: Stack(
        children: [
          const FuturisticBackground(),
          SingleChildScrollView(
            controller: _scrollCtrl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Odstęp, bo AppBar jest "behind"
                SizedBox(height: MediaQuery.of(context).padding.top + 72),
                _HeroSection(
                  onProjects: () => _scrollTo(_projectsKey),
                  scrollOffset: _offset,
                ),
                SectionShell(
                    key: _aboutKey,
                    title: t.about,
                    child: const AboutSection()),
                SectionShell(
                    key: _projectsKey,
                    title: t.projects,
                    child: const ProjectsSection()),
                SectionShell(
                    key: _offerKey,
                    title: t.offer,
                    child: const OfferSection()),
                SectionShell(
                    key: _contactKey,
                    title: t.contact,
                    child: const ContactSection()),
                SectionShell(
                    key: _faqKey, title: t.faq, child: const FaqSection()),
                const _Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBtn extends StatefulWidget {
  const _NavBtn({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  State<_NavBtn> createState() => _NavBtnState();
}

class _NavBtnState extends State<_NavBtn> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    final text = Text(
      widget.label,
      style: Theme.of(context).textTheme.titleSmall,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color:
                  _hover ? Colors.black.withOpacity(.04) : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: text,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  height: 2,
                  width: _hover ? 24 : 0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileDrawer extends StatelessWidget {
  const _MobileDrawer({required this.onSelect, required this.keys});
  final void Function(GlobalKey) onSelect;
  final Map<String, GlobalKey> keys;
  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    return Drawer(
      child: SafeArea(
        child: ListView(children: [
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text('WD Design Studio'),
            subtitle: Text(t.heroPill),
          ),
          const Divider(),
          ListTile(
              title: Text(t.about),
              onTap: () {
                Navigator.pop(context);
                onSelect(keys['about']!);
              }),
          ListTile(
              title: Text(t.projects),
              onTap: () {
                Navigator.pop(context);
                onSelect(keys['projects']!);
              }),
          ListTile(
              title: Text(t.offer),
              onTap: () {
                Navigator.pop(context);
                onSelect(keys['offer']!);
              }),
          ListTile(
              title: Text(t.contact),
              onTap: () {
                Navigator.pop(context);
                onSelect(keys['contact']!);
              }),
          ListTile(
              title: Text(t.faq),
              onTap: () {
                Navigator.pop(context);
                onSelect(keys['faq']!);
              }),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: LangSwitcher(),
          ),
        ]),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.onProjects, required this.scrollOffset});
  final VoidCallback onProjects;
  final double scrollOffset;

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final size = MediaQuery.of(context).size;
    final bool isNarrow = size.width < 900;

    // Parallax: subtelne przesunięcie tła przy scrollu
    final parallax = (scrollOffset * 0.08).clamp(0, size.height);

    return SizedBox(
      width: double.infinity,
      height: size.height, // fullscreen
      child: Stack(
        fit: StackFit.expand,
        children: [
          // TŁO: obraz z parallax
          Transform.translate(
            offset: Offset(0, -parallax.toDouble()),
            child: Image.asset(
              'assets/images/hero.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),

          // FUTURYSTYCZNY OVERLAY: diagonalny gradient + subtelny radial
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xCC0A0A0A),
                  Color(0x660A0A0A),
                ],
              ),
            ),
          ),
          IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.6, -0.6),
                  radius: 1.1,
                  colors: [
                    Colors.white.withOpacity(0.06),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),

          // GLOW BLOBS
          Positioned(
            top: -80,
            left: -60,
            child: _GlowCircle(
              size: 260,
              color: Theme.of(context).colorScheme.primary.withOpacity(.25),
            ),
          ),
          Positioned(
            bottom: -120,
            right: -80,
            child: _GlowCircle(
              size: 320,
              color: Theme.of(context).colorScheme.secondary.withOpacity(.18),
            ),
          ),

          // TREŚĆ
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isNarrow ? 22 : 64),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // PILL
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: Colors.white.withOpacity(.14),
                        border:
                            Border.all(color: Colors.white.withOpacity(.28)),
                      ),
                      child: Text(
                        t.heroPill.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),

                    // TYTUŁ
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: .92, end: 1),
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOutBack,
                      builder: (context, value, child) => Transform.scale(
                        scale: value,
                        child: child,
                      ),
                      child: Text(
                        t.heroTitle,
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: -1.5,
                                ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // PODTYTUŁ
                    Text(
                      t.heroSubtitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white.withOpacity(.92),
                            fontSize: 20,
                            height: 1.45,
                          ),
                    ),
                    const SizedBox(height: 44),

                    // CTA
                    Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: [
                        // Primary CTA (jasny, z cieniem)
                        FilledButton.icon(
                          onPressed: onProjects,
                          icon: const Icon(Icons.work_outline),
                          label: Text(t.ctaProjects),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 34, vertical: 18),
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 10,
                            shadowColor: Colors.black45,
                          ),
                        ),
                        // Secondary CTA (glass outline)
                        OutlinedButton.icon(
                          onPressed: () => Scrollable.ensureVisible(
                            context
                                .findRootAncestorStateOfType<
                                    _LandingPageState>()!
                                ._contactKey
                                .currentContext!,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOutCubic,
                          ),
                          icon: const Icon(Icons.mail_outline),
                          label: Text(t.ctaContact),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: Colors.white70, width: 2),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 16),
                            textStyle: const TextStyle(fontSize: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Scroll hint (animowany)
                    _ScrollHint(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FuturisticBackground extends StatelessWidget {
  const FuturisticBackground({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFAF6F1), // beż
            Color(0xFFFDFBF8), // prawie biały
          ],
        ),
      ),
      child: Stack(children: [
        Positioned(
          top: -120,
          left: -80,
          child: _GlowCircle(
            size: 260,
            color: const Color(0xFFD7BFA7).withOpacity(.25), // jasny brąz
          ),
        ),
        Positioned(
          bottom: -160,
          right: -120,
          child: _GlowCircle(
            size: 360,
            color: const Color(0xFF8B5E3C).withOpacity(.18), // ciemny brąz
          ),
        ),
      ]),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.size, required this.color});
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: color, blurRadius: 120, spreadRadius: 80),
        ],
      ),
    );
  }
}

class _ScrollHint extends StatefulWidget {
  @override
  State<_ScrollHint> createState() => _ScrollHintState();
}

class _ScrollHintState extends State<_ScrollHint>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat(reverse: true);
  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: .4, end: 1.0).animate(
        CurvedAnimation(parent: _c, curve: Curves.easeInOut),
      ),
      child: Column(
        children: const [
          Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 28),
          SizedBox(height: 4),
          Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 28),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();
  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year.toString();
    final t = S.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
      alignment: Alignment.center,
      child: Column(children: [
        const Divider(height: 32),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 14,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text('© $year WD Design Studio',
                style: Theme.of(context).textTheme.bodyMedium),
            const Text('•'),
            Text(t.privacy),
            const Text('•'),
            const Text('Cookies'),
          ],
        ),
      ]),
    );
  }
}
