import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

/// OfferSection displays a list of offer tiles with a price badge and description.
class OfferSection extends StatelessWidget {
  const OfferSection({super.key, this.onAsk});
  final void Function(String title)? onAsk;

  static const brown = Color(0xFF6D4C41);
  static const brownLight = Color(0xFFBCAAA4);
  static const brownLighter = Color(0xFFD7CCC8);

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final offers = [
      (t.offer1title, t.offer1desc),
      (t.offer2title, t.offer2desc),
      (t.offer3title, t.offer3desc),
      (t.offer4title, t.offer4desc),
      (t.offer5title, t.offer5desc),
      (t.offer6title, t.offer6desc),
      (t.offer7title, t.offer7desc),
      (t.offer8title, t.offer8desc),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Text(
          t.offerHint,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 14),
        // Price badge with gradient background and shimmer effect
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFF5E9E2),
                  Color(0xFFEAD1C0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6D4C41).withOpacity(0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  Color(0xFF8D6E63),
                  Color(0xFFD7CCC8),
                  Color(0xFF8D6E63),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                t.offerPrice,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  letterSpacing: 1.4,
                  color: const Color.fromARGB(255, 114, 69, 1),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: const Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Grid of offer tiles
        LayoutBuilder(
          builder: (context, c) {
            const maxTileWidth = 520.0;
            return GridView.builder(
              itemCount: offers.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: maxTileWidth,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 4.8,
              ),
              itemBuilder: (context, i) {
                final (title, desc) = offers[i];
                return _OfferTile(
                  title: title,
                  details: desc,
                  onTileTap: onAsk == null ? null : () => onAsk!(title),
                );
              },
            );
          },
        ),
        const SizedBox(height: 20),
        // Section footer description
        Text(
          t.offerDown,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: brown,
              ),
        ),
      ],
    );
  }
}

/// Interactive offer tile with hover and tap expansion.
class _OfferTile extends StatefulWidget {
  const _OfferTile({
    required this.title,
    required this.details,
    this.onTileTap,
  });

  final String title;
  final String details;
  final VoidCallback? onTileTap;

  @override
  State<_OfferTile> createState() => _OfferTileState();
}

class _OfferTileState extends State<_OfferTile> {
  bool _hover = false;
  bool _expanded = false;

  static const brown = OfferSection.brown;
  static const brownLight = OfferSection.brownLight;
  static const brownLighter = OfferSection.brownLighter;

  bool get _isMobileWidth {
    final w = MediaQuery.of(context).size.width;
    return w < 600;
  }

  void _openOverlay() {
    if (_isMobileWidth) return;
    setState(() {
      _hover = true;
      _expanded = true;
    });
  }

  void _closeOverlay() {
    if (_isMobileWidth) return;
    setState(() {
      _hover = false;
      _expanded = false;
    });
  }

  Future<void> _openMobileDialog() async {
    await showDialog<void>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.18),
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 10,
          child: _ExpandedOverlay(title: widget.title, details: widget.details),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lift = _hover ? -1.0 : 0.0;

    return WillPopScope(
      // Handles back navigation to close overlay first
      onWillPop: () async {
        if (_expanded && !_isMobileWidth) {
          _closeOverlay();
          return false;
        }
        return true;
      },
      child: MouseRegion(
        onEnter: (_) => _openOverlay(),
        onExit: (_) => _closeOverlay(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          transform: Matrix4.translationValues(0, lift, 0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Base card with tap/hover interaction
              _BaseCard(
                title: widget.title,
                details: widget.details,
                onTap: () async {
                  widget.onTileTap?.call();
                  if (_isMobileWidth) {
                    await _openMobileDialog();
                  } else {
                    setState(() => _expanded = !_expanded);
                  }
                },
              ),
              // Overlay with expanded details (desktop/web)
              if (_expanded && !_isMobileWidth)
                Positioned(
                  left: -6,
                  right: -6,
                  bottom: 6,
                  child: IgnorePointer(
                    ignoring: !_expanded,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 120),
                      opacity: _expanded ? 1 : 0,
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 120),
                        scale: _expanded ? 1 : 0.98,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {},
                          child: _ExpandedOverlay(
                            title: widget.title,
                            details: widget.details,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Card widget for offer tile with accent and summary.
class _BaseCard extends StatelessWidget {
  const _BaseCard({required this.title, required this.details, this.onTap});
  final String title;
  final String details;
  final VoidCallback? onTap;

  static const brown = _OfferTileState.brown;
  static const brownLight = _OfferTileState.brownLight;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          // Gradient border background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [brown, brownLight],
              ),
            ),
          ),
          // Inner white container with accent bar and dot
          Container(
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: brownLight, width: 1),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onTap,
                splashColor: brown.withOpacity(0.06),
                highlightColor: _OfferTileState.brownLighter.withOpacity(0.18),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Row(
                    children: [
                      // Left accent bar
                      Container(
                        width: 3,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: brownLight,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Title and summary
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontSize: 17,
                                    height: 1.05,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.1,
                                    color: Colors.black,
                                  ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              details,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: 13,
                                    height: 1.1,
                                    color: brown.withOpacity(0.9),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Accent dot
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: brownLight,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Overlay widget for expanded offer details.
class _ExpandedOverlay extends StatelessWidget {
  const _ExpandedOverlay({required this.title, required this.details});
  final String title;
  final String details;

  static const brown = _OfferTileState.brown;
  static const brownLight = _OfferTileState.brownLight;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: brown.withOpacity(0.18),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 4,
          maxHeight: 180,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: brownLight, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title (up to 2 lines)
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 17,
                      height: 1.15,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 6),
              // Scrollable details
              Expanded(
                child: ScrollConfiguration(
                  behavior: const _NoGlow(),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: Text(
                      details,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 13.5,
                            height: 1.35,
                            color: brown.withOpacity(0.95),
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ScrollBehavior that disables overscroll glow effect.
class _NoGlow extends ScrollBehavior {
  const _NoGlow();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
