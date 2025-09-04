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

  // NEW: stan rozwinięcia na mobile
  bool _mobileExpanded = false;

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
    final size = MediaQuery.sizeOf(context);
    final isMobile = size.width < 760;

    // Na mobile nie rozmazujemy tła (oszczędzamy GPU i unikamy „mleka”)
    final blurSigma = isMobile ? 0.0 : 16.0;

    // Kolor tekstu na „szkle”
    final onGlass = theme.colorScheme.onSurface.withOpacity(0.92);

    final containerDecoration = isMobile
        ? BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black.withOpacity(0.05),
              width: 1,
            ),
          )
        : BoxDecoration(
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
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFFFFFFF).withOpacity(0.16),
                const Color(0xFF6B4F3A).withOpacity(0.08),
              ],
            ),
          );

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isMobile ? 20 : 32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            margin: EdgeInsets.all(isMobile ? 16 : 24),
            padding: EdgeInsets.all(isMobile ? 16 : 28),
            decoration: containerDecoration,
            child: LayoutBuilder(
              builder: (context, c) {
                final mobile = c.maxWidth < 760;
                return AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  child: mobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Foto – mniejsze w stanie zwiniętym
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: _mobileExpanded ? 420 : 180,
                              ),
                              child: _AnimatedPhoto(
                                fade: _fadePhoto,
                                slide: _slidePhoto,
                                hovering: _hoveringPhoto,
                                onHoverChanged: (v) =>
                                    setState(() => _hoveringPhoto = v),
                              ),
                            ),
                            const SizedBox(height: 14),
                            _MobileDivider(),
                            const SizedBox(height: 14),

                            // Tekst – 3 linie w stanie zwiniętym
                            _AnimatedTextBlock(
                              text: t.aboutPlaceholder,
                              fade: _fadeText,
                              slide: _slideText,
                              textColor: theme.brightness == Brightness.dark
                                  ? Colors.white.withOpacity(0.96)
                                  : Colors.black.withOpacity(0.86),
                              compact: true,
                              maxLines: _mobileExpanded ? null : 3,
                            ),

                            const SizedBox(height: 10),

                            // Przycisk Pokaż więcej/mniej
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: TextButton.icon(
                                key: ValueKey(_mobileExpanded),
                                onPressed: () => setState(
                                    () => _mobileExpanded = !_mobileExpanded),
                                icon: Icon(_mobileExpanded
                                    ? Icons.expand_less
                                    : Icons.expand_more),
                                label: Text(_mobileExpanded
                                    ? 'Pokaż mniej'
                                    : 'Pokaż więcej'),
                                style: TextButton.styleFrom(
                                  foregroundColor: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                              flex: 8,
                              child: _AnimatedTextBlock(
                                text: t.aboutPlaceholder,
                                fade: _fadeText,
                                slide: _slideText,
                                textColor: onGlass,
                              ),
                            ),
                          ],
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      width: 64,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.07),
        borderRadius: BorderRadius.circular(999),
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
    final isVeryNarrow = MediaQuery.sizeOf(context).width < 360;

    final photo = ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: AspectRatio(
        aspectRatio: 4 / 5, // trochę „grubiej” na mobile
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/images/weronika.jpg",
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
            // delikatny brązowy gradient
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    const Color(0xFF3A2A20).withOpacity(0.16),
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

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isVeryNarrow ? 0 : 4),
      child: FadeTransition(
        opacity: fade,
        child: SlideTransition(
          position: slide,
          child: photoWithHover,
        ),
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
    this.compact = false,
    this.maxLines, // NEW
  });

  final String text;
  final Animation<double> fade;
  final Animation<Offset> slide;
  final Color? textColor;
  final bool compact;
  final int? maxLines; // NEW

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final scale = MediaQuery.textScaleFactorOf(context);
    final isPhone = w < 420;
    final isTablet = w >= 420 && w < 760;

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

    final BoxDecoration decoPhone = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.black.withOpacity(0.05), width: 1),
    );

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
        constraints: BoxConstraints(
          // węższy blok na phone, wygodny do czytania
          maxWidth: isPhone ? 560 : 720,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isPhone ? 14 : 20,
            vertical: isPhone ? (compact ? 10 : 12) : (compact ? 14 : 18),
          ),
          decoration: isPhone ? decoPhone : decoLarger,
          child: Text(
            text,
            softWrap: true,
            // justowanie wyłączone na phone — lepsza czytelność
            textAlign: isPhone ? TextAlign.start : TextAlign.justify,
            textHeightBehavior: const TextHeightBehavior(
              applyHeightToFirstAscent: false,
              applyHeightToLastDescent: true,
            ),
            maxLines: maxLines,
            overflow:
                maxLines == null ? TextOverflow.visible : TextOverflow.ellipsis,
            style: (Theme.of(context).textTheme.bodyLarge ?? const TextStyle())
                .copyWith(
              fontSize: baseSize,
              height: lineHeight,
              letterSpacing: letter,
              fontWeight: FontWeight.w500,
              color: fg,
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
