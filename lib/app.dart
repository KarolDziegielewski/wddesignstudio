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

/// Main landing page widget with scrollable sections and navigation.
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // Keys for each section to enable scroll-to functionality.
  final _aboutKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _offerKey = GlobalKey();
  final _contactKey = GlobalKey();
  final _faqKey = GlobalKey();

  // Scroll controller for tracking scroll position.
  final _scrollCtrl = ScrollController();

  double _offset = 0;

  // Responsive breakpoints.
  bool get _isMobile => MediaQuery.of(context).size.width < 900;
  bool get _isPhone => MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    super.initState();
    // Listen to scroll changes to update AppBar appearance.
    _scrollCtrl.addListener(() {
      setState(() => _offset = _scrollCtrl.offset);
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  // Scrolls to the widget associated with the given key.
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

  // Shows language selection modal bottom sheet.
  void _showLangSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      showDragHandle: true,
      builder: (ctx) => const Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8),
            LangSwitcher(),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // Shows privacy policy modal bottom sheet.
  void _showPrivacySheet(BuildContext context) {
    final t = S.of(context);
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (_, controller) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: ListView(
            controller: controller,
            children: [
              Text(t.privacy, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                t.policy,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Zamknij'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Shows cookies information modal bottom sheet.
  void _showCookiesSheet(BuildContext context) {
    final t = S.of(context);
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.55,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (_, controller) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: ListView(
            controller: controller,
            children: [
              Text('Cookies', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                t.cookies,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Zamknij'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);

    // Calculate AppBar appearance based on scroll offset and device type.
    final appBarOpacity = (_offset / 180).clamp(0, 1).toDouble();
    final baseBlur = 12.0 * appBarOpacity;
    final blurSigma = _isMobile ? baseBlur * 0.6 : baseBlur;
    final elevation = (_isMobile ? 6.0 : 8.0) * appBarOpacity;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: _isMobile,
        elevation: elevation,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.only(left: _isMobile ? 8 : 16),
          child: Row(
            children: [
              if (!_isMobile) const SizedBox(width: 10),
              Expanded(
                child: Semantics(
                  header: true,
                  child: Text(
                    'WD Design Studio',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              if (!_isMobile) ...[
                const SizedBox(width: 24),
                // Desktop/tablet navigation buttons.
                Row(
                  children: [
                    _NavBtn(label: t.about, onTap: () => _scrollTo(_aboutKey)),
                    _NavBtn(
                        label: t.projects,
                        onTap: () => _scrollTo(_projectsKey)),
                    _NavBtn(label: t.offer, onTap: () => _scrollTo(_offerKey)),
                    _NavBtn(
                        label: t.contact, onTap: () => _scrollTo(_contactKey)),
                    _NavBtn(label: t.faq, onTap: () => _scrollTo(_faqKey)),
                  ],
                ),
                const SizedBox(width: 8),
                const LangSwitcher(),
                const SizedBox(width: 16),
              ],
            ],
          ),
        ),
        actions: _isMobile
            ? [
                IconButton(
                  tooltip: t.language,
                  icon: const Icon(Icons.language),
                  onPressed: () => _showLangSheet(context),
                ),
              ]
            : null,
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
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
      drawer: _isMobile
          ? _MobileDrawer(
              onSelect: _scrollTo,
              keys: {
                'about': _aboutKey,
                'projects': _projectsKey,
                'offer': _offerKey,
                'contact': _contactKey,
                'faq': _faqKey,
              },
            )
          : null,
      body: Stack(
        children: [
          // Background decoration.
          const FuturisticBackground(),
          // Main scrollable content.
          SingleChildScrollView(
            controller: _scrollCtrl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Spacer for AppBar overlay.
                SizedBox(
                  height: MediaQuery.of(context).padding.top +
                      (_isMobile ? 64 : 72),
                ),
                // Hero section with parallax and CTA.
                _HeroSection(
                  onProjects: () => _scrollTo(_projectsKey),
                  scrollOffset: _offset,
                  isMobile: _isMobile,
                  isPhone: _isPhone,
                ),
                // About section.
                SectionShell(
                  key: _aboutKey,
                  title: t.about,
                  child: const AboutSection(),
                ),
                // Projects section.
                SectionShell(
                  key: _projectsKey,
                  title: t.projects,
                  child: const ProjectsSection(),
                ),
                // Offer section.
                SectionShell(
                  key: _offerKey,
                  title: t.offer,
                  child: const OfferSection(),
                ),
                // Contact section.
                SectionShell(
                  key: _contactKey,
                  title: t.contact,
                  child: const ContactSection(),
                ),
                // FAQ section.
                SectionShell(
                  key: _faqKey,
                  title: t.faq,
                  child: const FaqSection(),
                ),
                // Footer with legal links.
                _Footer(
                  onPrivacyTap: () => _showPrivacySheet(context),
                  onCookiesTap: () => _showCookiesSheet(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Navigation button for AppBar with hover effect.
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
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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

/// Drawer for mobile navigation with section links and language switcher.
class _MobileDrawer extends StatelessWidget {
  const _MobileDrawer({required this.onSelect, required this.keys});
  final void Function(GlobalKey) onSelect;
  final Map<String, GlobalKey> keys;

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('WD Design Studio'),
              subtitle: Text(t.heroPill),
              visualDensity: VisualDensity.compact,
            ),
            const Divider(height: 1),
            ListTile(
              title: Text(t.about),
              onTap: () {
                Navigator.pop(context);
                onSelect(keys['about']!);
              },
            ),
            ListTile(
              title: Text(t.projects),
              onTap: () {
                Navigator.pop(context);
                onSelect(keys['projects']!);
              },
            ),
            ListTile(
              title: Text(t.offer),
              onTap: () {
                Navigator.pop(context);
                onSelect(keys['offer']!);
              },
            ),
            ListTile(
              title: Text(t.contact),
              onTap: () {
                Navigator.pop(context);
                onSelect(keys['contact']!);
              },
            ),
            ListTile(
              title: Text(t.faq),
              onTap: () {
                Navigator.pop(context);
                onSelect(keys['faq']!);
              },
            ),
            const Divider(height: 1),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: LangSwitcher(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Hero section with background, parallax, title, subtitle, and CTA buttons.
class _HeroSection extends StatelessWidget {
  const _HeroSection({
    required this.onProjects,
    required this.scrollOffset,
    required this.isMobile,
    required this.isPhone,
  });

  final VoidCallback onProjects;
  final double scrollOffset;
  final bool isMobile;
  final bool isPhone;

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final size = MediaQuery.of(context).size;

    // Parallax effect for background image.
    final parallaxFactor = isMobile ? 0.05 : 0.08;
    final parallax = (scrollOffset * parallaxFactor).clamp(0, size.height);

    // Responsive hero section height.
    final double heroHeight =
        isMobile ? (size.height * 0.86).clamp(560.0, 900.0) : size.height;

    // Responsive paddings and font sizes.
    final edgeH = isMobile ? (isPhone ? 18.0 : 22.0) : 64.0;
    final subtitleSize = isMobile ? 18.0 : 20.0;
    final ctaHPadPrimary = isMobile ? 26.0 : 34.0;
    final ctaVPadPrimary = isMobile ? 14.0 : 18.0;
    final ctaHPadSecondary = isMobile ? 24.0 : 30.0;
    final ctaVPadSecondary = isMobile ? 12.0 : 16.0;

    return SizedBox(
      width: double.infinity,
      height: heroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image with parallax.
          Transform.translate(
            offset: Offset(0, -parallax.toDouble()),
            child: Image.asset(
              'assets/images/hero.webp',
              fit: BoxFit.cover,
              alignment: Alignment.center,
              filterQuality: FilterQuality.medium,
            ),
          ),
          // Diagonal and radial gradient overlays.
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
          // Decorative glowing circles.
          Positioned(
            top: -80,
            left: -60,
            child: _GlowCircle(
              size: isMobile ? 220 : 260,
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(isMobile ? .20 : .25),
            ),
          ),
          Positioned(
            bottom: -120,
            right: -80,
            child: _GlowCircle(
              size: isMobile ? 280 : 320,
              color: Theme.of(context)
                  .colorScheme
                  .secondary
                  .withOpacity(isMobile ? .14 : .18),
            ),
          ),
          // Main hero content: pill, title, subtitle, CTA, scroll hint.
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: edgeH),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Hero pill.
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 14 : 18,
                        vertical: isMobile ? 6 : 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: Colors.white.withOpacity(.14),
                        border:
                            Border.all(color: Colors.white.withOpacity(.28)),
                      ),
                      child: Text(
                        t.heroPill.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1.2,
                          fontSize: isMobile ? 12 : 14,
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 20 : 26),
                    // Animated hero title.
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
                                  letterSpacing: -1.2,
                                  fontSize: isMobile
                                      ? (isPhone ? 34 : 42)
                                      : Theme.of(context)
                                              .textTheme
                                              .displayLarge
                                              ?.fontSize ??
                                          56,
                                ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Hero subtitle.
                    Text(
                      t.heroSubtitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white.withOpacity(.92),
                            fontSize: subtitleSize,
                            height: 1.45,
                            letterSpacing: 0.1,
                          ),
                    ),
                    SizedBox(height: isMobile ? 30 : 44),
                    // Call-to-action buttons.
                    Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        FilledButton.icon(
                          onPressed: onProjects,
                          icon: const Icon(Icons.work_outline),
                          label: Text(t.ctaProjects),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            padding: EdgeInsets.symmetric(
                              horizontal: ctaHPadPrimary,
                              vertical: ctaVPadPrimary,
                            ),
                            textStyle: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              fontWeight: FontWeight.bold,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: isMobile ? 8 : 10,
                            shadowColor: Colors.black45,
                          ),
                        ),
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
                              color: Colors.white70,
                              width: 2,
                            ),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: ctaHPadSecondary,
                              vertical: ctaVPadSecondary,
                            ),
                            textStyle: TextStyle(fontSize: isMobile ? 16 : 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? 28 : 40),
                    // Animated scroll down hint.
                    const _ScrollHint(),
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

/// Decorative background with gradients and glowing circles.
class FuturisticBackground extends StatelessWidget {
  const FuturisticBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return RepaintBoundary(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFAF6F1),
              Color(0xFFFDFBF8),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: isMobile ? -140 : -120,
              left: isMobile ? -100 : -80,
              child: _GlowCircle(
                size: isMobile ? 220 : 260,
                color:
                    const Color(0xFFD7BFA7).withOpacity(isMobile ? .20 : .25),
              ),
            ),
            Positioned(
              bottom: isMobile ? -180 : -160,
              right: isMobile ? -140 : -120,
              child: _GlowCircle(
                size: isMobile ? 320 : 360,
                color:
                    const Color(0xFF8B5E3C).withOpacity(isMobile ? .14 : .18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Glowing circle used for background decoration.
class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: color, blurRadius: 120, spreadRadius: 80),
          ],
        ),
      ),
    );
  }
}

/// Animated scroll down hint for hero section.
class _ScrollHint extends StatefulWidget {
  const _ScrollHint();

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
    return Semantics(
      label: 'Scroll down',
      child: FadeTransition(
        opacity: Tween(begin: .4, end: 1.0).animate(
          CurvedAnimation(parent: _c, curve: Curves.easeInOut),
        ),
        child: const Column(
          children: [
            Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 28),
            SizedBox(height: 4),
            Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 28),
          ],
        ),
      ),
    );
  }
}

/// Footer with copyright and legal links.
class _Footer extends StatelessWidget {
  const _Footer({
    required this.onPrivacyTap,
    required this.onCookiesTap,
  });

  final VoidCallback onPrivacyTap;
  final VoidCallback onCookiesTap;

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year.toString();
    final t = S.of(context);
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        isMobile ? 40 : 56,
        24,
        isMobile ? 40 : 56,
      ),
      child: Column(
        children: [
          const Divider(height: 32),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 6,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                '© $year WD Design Studio',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Text('•'),
              TextButton(
                onPressed: onPrivacyTap,
                child: Text(t.privacy),
              ),
              const Text('•'),
              TextButton(
                onPressed: onCookiesTap,
                child: const Text('Cookies'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
