import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class OfferSection extends StatelessWidget {
  const OfferSection({super.key, this.onAsk});
  final void Function(String title)? onAsk;

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
        Text(t.offerHint, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, c) {
            // szerokie, NISKIE kafelki
            const maxTileWidth = 520.0;
            return GridView.builder(
              itemCount: offers.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: maxTileWidth,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 4.8, // szeroko i nisko
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
        const SizedBox(height: 10),
        Text(
          t.offerDown,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: const Color(0xFF6D4C41),
              ),
        ),
      ],
    );
  }
}

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
  bool _expanded = false; // desktop: hover; mobile: tap toggle

  // paleta biało-brązowa
  static const brown = Color(0xFF6D4C41);
  static const brownLight = Color(0xFFBCAAA4);
  static const brownLighter = Color(0xFFD7CCC8);

  void _openOverlay() => setState(() {
        _hover = true;
        _expanded = true;
      });
  void _closeOverlay() => setState(() {
        _hover = false;
        _expanded = false;
      });

  @override
  Widget build(BuildContext context) {
    final lift = _hover ? -1.0 : 0.0;

    return MouseRegion(
      onEnter: (_) => _openOverlay(),
      onExit: (_) => _closeOverlay(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        transform: Matrix4.translationValues(0, lift, 0),
        child: Stack(
          clipBehavior: Clip.none, // pozwala overlayowi wyjść poza kafelek
          children: [
            _BaseCard(
              title: widget.title,
              details: widget.details,
              onTap: () {
                // mobile: tap rozwinie/zwinie opis; jeśli chcesz akcję onAsk — wywołaj obie
                setState(() => _expanded = !_expanded);
                widget.onTileTap?.call();
              },
            ),
            // Overlay z pełnym opisem (nad kafelkiem)
            Positioned(
              left: -6, right: -6, bottom: 6,
              // wysuwa się do góry, żeby nie powiększać layoutu siatki
              child: IgnorePointer(
                ignoring: !_expanded,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 120),
                  opacity: _expanded ? 1 : 0,
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 120),
                    scale: _expanded ? 1 : 0.98,
                    child: _ExpandedOverlay(
                      title: widget.title,
                      details: widget.details,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
          // hairline gradient border
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [brown, brownLight],
              ),
            ),
          ),
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
                  // niska płytka → mały padding pionowy
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Row(
                    children: [
                      // lewy akcent
                      Container(
                        width: 3,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: brownLight,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 6),
                      // treść (nisko — tylko skrót)
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
                              maxLines: 1, // niski kafelek → 1 linia skrótu
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
                      // mała kropka akcentowa
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                            color: brownLight, shape: BoxShape.circle),
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
          // kompaktowa „chmurka”
          minHeight: 4,
          maxHeight: 150,
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
              // tytuł może być dłuższy (2 linie)
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
              // pełniejszy opis z przewijaniem, jeśli potrzeba
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

class _NoGlow extends ScrollBehavior {
  const _NoGlow();
  Widget buildViewportChrome(
          BuildContext context, Widget child, AxisDirection axisDirection) =>
      child;
}
