import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fadePhoto;
  late final Animation<Offset> _slidePhoto;
  late final Animation<double> _fadeText;
  late final Animation<Offset> _slideText;

  bool _hoveringPhoto = false;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadePhoto = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );
    _slidePhoto = Tween<Offset>(
      begin: const Offset(-0.12, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
      ),
    );
    _fadeText = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.35, 1.0, curve: Curves.easeOut),
    );
    _slideText = Tween<Offset>(
      begin: const Offset(0.12, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.35, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => _c.forward());
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final theme = Theme.of(context);
    final onGlass = theme.colorScheme.onSurface
        .withOpacity(0.92); // prosty, czytelny kolor tekstu

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.10),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Colors.white.withOpacity(0.22),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.14),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
              // subtelne biało-brązowe szkło
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFFFFFFF).withOpacity(0.16),
                  const Color(0xFF6B4F3A).withOpacity(0.08), // ciepły brąz
                ],
              ),
            ),
            child: LayoutBuilder(
              builder: (context, c) {
                final isMobile = c.maxWidth < 760;
                return isMobile
                    ? Column(
                        children: [
                          // limit szerokości, żeby foto nie dominowało na mobile
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 380),
                            child: _AnimatedPhoto(
                              fade: _fadePhoto,
                              slide: _slidePhoto,
                              hovering: _hoveringPhoto,
                              onHoverChanged: (v) =>
                                  setState(() => _hoveringPhoto = v),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _AnimatedTextBlock(
                            text: t.aboutPlaceholder,
                            fade: _fadeText,
                            slide: _slideText,
                            textColor: onGlass,
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // zmniejszone z 5 do 4, żeby zdjęcie było trochę mniejsze
                          const SizedBox(width: 4),
                          Expanded(
                            flex: 4,
                            child: _AnimatedPhoto(
                              fade: _fadePhoto,
                              slide: _slidePhoto,
                              hovering: _hoveringPhoto,
                              onHoverChanged: (v) =>
                                  setState(() => _hoveringPhoto = v),
                            ),
                          ),
                          const SizedBox(width: 32),
                          Expanded(
                            flex: 8, // więcej miejsca na treść
                            child: _AnimatedTextBlock(
                              text: t.aboutPlaceholder,
                              fade: _fadeText,
                              slide: _slideText,
                              textColor: onGlass,
                            ),
                          ),
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedPhoto extends StatelessWidget {
  const _AnimatedPhoto({
    required this.fade,
    required this.slide,
    required this.hovering,
    required this.onHoverChanged,
  });

  final Animation<double> fade;
  final Animation<Offset> slide;
  final bool hovering;
  final ValueChanged<bool> onHoverChanged;

  @override
  Widget build(BuildContext context) {
    final photo = ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: AspectRatio(
        aspectRatio:
            3 / 4, // pionowe, duże — ale całość zmniejszona flexem/constraints
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset("assets/images/weronika.jpg", fit: BoxFit.cover),
            // delikatny brązowy „premium” gradient na krawędziach
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    const Color(0xFF3A2A20).withOpacity(0.18),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final photoWithHover = kIsWeb
        ? MouseRegion(
            onEnter: (_) => onHoverChanged(true),
            onExit: (_) => onHoverChanged(false),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              scale: hovering ? 1.02 : 1.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                transform: Matrix4.identity()
                  ..translate(0.0, hovering ? -2.0 : 0.0),
                child: photo,
              ),
            ),
          )
        : photo;

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: slide,
        child: photoWithHover,
      ),
    );
  }
}

class _AnimatedTextBlock extends StatelessWidget {
  const _AnimatedTextBlock({
    required this.text,
    required this.fade,
    required this.slide,
    this.textColor,
  });

  final String text;
  final Animation<double> fade;
  final Animation<Offset> slide;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final scale = MediaQuery.textScaleFactorOf(context);
    final isPhone = w < 420; // ciasne telefony
    final isTablet = w >= 420 && w < 760;

    // typografia dopasowana do skali systemowej, ale bez przeskalowania „za dużo”
    double baseSize = isPhone
        ? 16.0
        : isTablet
            ? 17.0
            : 18.0;
    baseSize *= scale.clamp(1.0, 1.15);

    final lineHeight = isPhone ? 1.7 : 1.65;
    final letter = isPhone ? 0.15 : 0.1;

    final scheme = Theme.of(context).colorScheme;
    final Color fg = (textColor ?? scheme.onSurface.withOpacity(0.96));

    // Na telefonie ZERO gradientów i mocnych cieni – czysta karta.
    final BoxDecoration decoPhone = BoxDecoration(
      color: Colors.white.withOpacity(0.92),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.black.withOpacity(0.04), width: 1),
    );

    // Na większych ekranach lekki „glass”, ale stonowany.
    final BoxDecoration decoLarger = BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.white.withOpacity(0.18), width: 1),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.46),
          Colors.white.withOpacity(0.28),
        ],
      ),
      boxShadow: [
        BoxShadow(
          blurRadius: 14,
          spreadRadius: -8,
          color: Colors.black.withOpacity(0.10),
          offset: const Offset(0, 8),
        ),
      ],
    );

    final content = Center(
      child: ConstrainedBox(
        // wąski i wygodny blok czytania
        constraints: BoxConstraints(
          maxWidth: isPhone ? 560 : 720,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isPhone ? 14 : 20,
            vertical: isPhone ? 12 : 18,
          ),
          decoration: isPhone ? decoPhone : decoLarger,
          child: Text(
            text,
            softWrap: true,
            textAlign: isPhone ? TextAlign.start : TextAlign.justify,
            textHeightBehavior: const TextHeightBehavior(
              applyHeightToFirstAscent: false,
              applyHeightToLastDescent: true,
            ),
            style: (Theme.of(context).textTheme.bodyLarge ?? const TextStyle())
                .copyWith(
              fontSize: baseSize,
              height: lineHeight,
              letterSpacing: letter,
              fontWeight: FontWeight.w500, // spokojny, niekrzyczący
              color: fg,
              // bez cieni – czysto i nowocześnie
              shadows: const [],
            ),
          ),
        ),
      ),
    );

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: slide,
        child: content,
      ),
    );
  }
}
