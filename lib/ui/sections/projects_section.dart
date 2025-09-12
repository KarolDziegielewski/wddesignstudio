import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:wddesignstudio/l10n/app_localizations.dart';

/// Model pojedynczego projektu
class Project {
  final String title;
  final String? short; // Krótki opis na karcie
  final String? longDescription; // Dłuższy opis w detalu
  final String coverImage; // Obrazek główny (asset lub URL)
  final List<String> gallery; // Galeria zdjęć

  const Project({
    required this.title,
    this.short,
    this.longDescription,
    required this.coverImage,
    this.gallery = const [],
  });
}

/// Sekcja prezentująca projekty w formie siatki
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final cross = w < 600 ? 1 : (w < 1000 ? 2 : 3);

    // Pobranie tłumaczeń i zbudowanie listy projektów
    final t = S.of(context);
    final projects = <Project>[
      Project(
        title: t.prj1Title,
        short: t.prj1Short,
        longDescription: t.prj1Long,
        coverImage: 'assets/images/mini_proj1.jpg',
        gallery: const [
          'assets/images/mini_proj1.jpg',
          'assets/images/proj1_1.jpg',
          'assets/images/proj1_2.jpg',
          'assets/images/proj1_3.jpg',
          'assets/images/proj1_4.jpg',
          'assets/images/proj1_5.jpg',
        ],
      ),
      Project(
        title: t.prj2Title,
        short: t.prj2Short,
        longDescription: t.prj2Long,
        coverImage: 'assets/images/mini_proj2.jpg',
        gallery: const [
          'assets/images/mini_proj2.jpg',
          'assets/images/proj2_1.jpg',
          'assets/images/proj2_2.jpg',
          'assets/images/proj2_3.jpg',
        ],
      ),
      Project(
        title: t.prj3Title,
        short: t.prj3Short,
        longDescription: t.prj3Long,
        coverImage: 'assets/images/mini_proj3.jpg',
        gallery: const [
          'assets/images/mini_proj3.jpg',
          'assets/images/proj3_1.jpg',
          'assets/images/proj3_2.jpg',
          'assets/images/proj3_3.jpg',
        ],
      ),
      Project(
        title: t.prj4Title,
        short: t.prj4Short,
        longDescription: t.prj4Long,
        coverImage: 'assets/images/mini_proj4.jpg',
        gallery: const [
          'assets/images/mini_proj4.jpg',
          'assets/images/proj4_1.jpg',
          'assets/images/proj4_2.jpg',
          'assets/images/proj4_3.jpg',
          'assets/images/proj4_4.jpg',
          'assets/images/proj4_5.jpg',
          'assets/images/proj4_6.jpg',
          'assets/images/proj4_7.jpg',
        ],
      ),
      Project(
        title: t.prj13Title,
        coverImage: 'assets/images/mini_proj13.jpg',
        gallery: const [
          'assets/images/mini_proj13.jpg',
          'assets/images/hero.jpg',
          'assets/images/proj13_1.jpg',
        ],
      ),
      Project(
        title: t.prj5Title,
        coverImage: 'assets/images/mini_proj5.jpg',
        gallery: const [
          'assets/images/mini_proj5.jpg',
          'assets/images/proj5_1.jpg',
        ],
      ),
      Project(
        title: t.prj6Title,
        coverImage: 'assets/images/mini_proj6.jpg',
        gallery: const [
          'assets/images/mini_proj6.jpg',
          'assets/images/proj6_1.jpg',
        ],
      ),
      Project(
        title: t.prj7Title,
        coverImage: 'assets/images/mini_proj7.jpg',
        gallery: const [
          'assets/images/mini_proj7.jpg',
          'assets/images/proj7_1.jpg',
          'assets/images/proj7_2.jpg',
        ],
      ),
      Project(
        title: t.prj8Title,
        coverImage: 'assets/images/mini_proj8.jpg',
        gallery: const [
          'assets/images/mini_proj8.jpg',
          'assets/images/proj8_1.jpg',
        ],
      ),
      Project(
        title: t.prj9Title,
        coverImage: 'assets/images/mini_proj9.jpg',
        gallery: const [
          'assets/images/mini_proj9.jpg',
          'assets/images/proj9_1.jpg',
          'assets/images/proj9_2.jpg',
        ],
      ),
      Project(
        title: t.prj10Title,
        coverImage: 'assets/images/mini_proj10.jpg',
        gallery: const [
          'assets/images/mini_proj10.jpg',
          'assets/images/proj10_1.jpg',
        ],
      ),
      Project(
        title: t.prj11Title,
        coverImage: 'assets/images/mini_proj11.jpg',
        gallery: const [
          'assets/images/mini_proj11.jpg',
          'assets/images/proj11_1.jpg',
          'assets/images/proj11_2.jpg',
        ],
      ),
      Project(
        title: t.prj12Title,
        coverImage: 'assets/images/mini_proj12.jpg',
        gallery: const [
          'assets/images/mini_proj12.jpg',
          'assets/images/proj12_1.jpg',
          'assets/images/proj12_2.jpg',
          'assets/images/proj12_3.jpg',
        ],
      ),
    ];

    // Wyświetlenie siatki projektów
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cross,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 4 / 3,
          ),
          itemCount: projects.length,
          itemBuilder: (_, i) => _ProjectCard(
            project: projects[i],
            onTap: () => _openProject(context, projects[i]),
          ),
        ),
      ],
    );
  }

  /// Otwiera szczegóły projektu w dolnym arkuszu
  void _openProject(BuildContext context, Project p) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        showDragHandle: true,
        builder: (_) => _ProjectDetails(project: p),
      );
}

/// Karta pojedynczego projektu w siatce
class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.project,
    required this.onTap,
  });

  final Project project;
  final VoidCallback onTap;

  /// Zwraca odpowiedni provider obrazu (asset lub sieć)
  ImageProvider _coverProvider(String path) {
    return path.startsWith('http')
        ? NetworkImage(path)
        : AssetImage(path) as ImageProvider;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: _coverProvider(project.coverImage),
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(
              Colors.black26,
              BlendMode.darken,
            ),
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 20,
              spreadRadius: -8,
              color: Color(0x1A000000),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Gradient na dole karty
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Tytuł i opcjonalny opis
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (project.short != null &&
                      project.short!.trim().isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      project.short!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Szczegóły projektu wyświetlane w dolnym arkuszu
class _ProjectDetails extends StatefulWidget {
  const _ProjectDetails({required this.project});

  final Project project;

  @override
  State<_ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<_ProjectDetails> {
  final PageController _page = PageController();
  int _i = 0;

  /// Provider obrazu (asset lub sieć)
  ImageProvider _imgProvider(String path) {
    return path.startsWith('http')
        ? NetworkImage(path)
        : AssetImage(path) as ImageProvider;
  }

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  /// Otwiera galerię w trybie pełnoekranowym
  void _openFullscreen(int index, List<String> images) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => _GalleryFullscreen(
          images: images,
          initialIndex: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final gallery = p.gallery;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nagłówek z tytułem i przyciskiem zamknięcia
            Row(
              children: [
                Expanded(
                  child: Text(
                    p.title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Galeria zdjęć projektu
            if (gallery.isNotEmpty) ...[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _page,
                        itemCount: gallery.length,
                        onPageChanged: (i) => setState(() => _i = i),
                        itemBuilder: (_, i) => Stack(
                          children: [
                            GestureDetector(
                              onTap: () => _openFullscreen(i, gallery),
                              child: Hero(
                                tag: 'gallery-hero-${gallery[i]}',
                                child: Ink.image(
                                  image: _imgProvider(gallery[i]),
                                  fit: BoxFit.cover,
                                  child: const SizedBox.expand(),
                                ),
                              ),
                            ),
                            // Przycisk pełnego ekranu
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Material(
                                color: Colors.black45,
                                shape: const CircleBorder(),
                                child: InkWell(
                                  customBorder: const CircleBorder(),
                                  onTap: () => _openFullscreen(i, gallery),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.open_in_full,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Nawigacja po zdjęciach
                      Positioned.fill(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _NavBtn(
                              icon: Icons.chevron_left,
                              onTap: () {
                                final prev = math.max(0, _i - 1);
                                _page.animateToPage(
                                  prev,
                                  duration: const Duration(milliseconds: 220),
                                  curve: Curves.easeOut,
                                );
                              },
                            ),
                            _NavBtn(
                              icon: Icons.chevron_right,
                              onTap: () {
                                final next =
                                    math.min(gallery.length - 1, _i + 1);
                                _page.animateToPage(
                                  next,
                                  duration: const Duration(milliseconds: 220),
                                  curve: Curves.easeOut,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Kropki pod galerią
              if (gallery.length > 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    gallery.length,
                    (i) => Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == _i
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              // Miniaturki zdjęć
              if (gallery.length > 1)
                SizedBox(
                  height: 72,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: gallery.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, idx) {
                      final selected = idx == _i;
                      return GestureDetector(
                        onTap: () {
                          _page.animateToPage(
                            idx,
                            duration: const Duration(milliseconds: 220),
                            curve: Curves.easeOut,
                          );
                        },
                        onDoubleTap: () => _openFullscreen(idx, gallery),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            children: [
                              Image(
                                image: _imgProvider(gallery[idx]),
                                width: 110,
                                height: 72,
                                fit: BoxFit.cover,
                              ),
                              if (selected)
                                Positioned.fill(
                                  child: IgnorePointer(
                                    ignoring: true,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),
            ],
            const SizedBox(height: 6),
            // Opis projektu
            if (p.longDescription != null &&
                p.longDescription!.trim().isNotEmpty)
              Text(
                p.longDescription!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
          ],
        ),
      ),
    );
  }
}

/// Przycisk nawigacyjny do zmiany zdjęcia w galerii
class _NavBtn extends StatelessWidget {
  const _NavBtn({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black45,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}

/// Pełnoekranowa galeria zdjęć projektu
class _GalleryFullscreen extends StatefulWidget {
  const _GalleryFullscreen({
    required this.images,
    this.initialIndex = 0,
  });

  final List<String> images;
  final int initialIndex;

  @override
  State<_GalleryFullscreen> createState() => _GalleryFullscreenState();
}

class _GalleryFullscreenState extends State<_GalleryFullscreen> {
  late final PageController _ctrl;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _ctrl = PageController(initialPage: _index);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  /// Provider obrazu (asset lub sieć)
  ImageProvider _provider(String path) {
    return path.startsWith('http')
        ? NetworkImage(path)
        : AssetImage(path) as ImageProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Przeglądarka zdjęć z możliwością powiększania
          PageView.builder(
            controller: _ctrl,
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (_, i) {
              final img = widget.images[i];
              final transformationController = TransformationController();

              return Center(
                child: Hero(
                  tag: 'gallery-hero-$img',
                  child: GestureDetector(
                    onDoubleTap: () {
                      final m = transformationController.value;
                      final isZoomed = m.getMaxScaleOnAxis() > 1.01;
                      if (isZoomed) {
                        transformationController.value = Matrix4.identity();
                      } else {
                        transformationController.value = Matrix4.identity()
                          ..scale(2.0);
                      }
                    },
                    child: InteractiveViewer(
                      transformationController: transformationController,
                      panEnabled: true,
                      minScale: 1.0,
                      maxScale: 5.0,
                      child: Image(
                        image: _provider(img),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // Pasek górny z przyciskiem zamknięcia i numeracją
          SafeArea(
            child: Row(
              children: [
                const SizedBox(width: 8),
                Material(
                  color: Colors.black54,
                  shape: const CircleBorder(),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${_index + 1} / ${widget.images.length}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // Nawigacja po zdjęciach w trybie pełnoekranowym
          if (widget.images.length > 1)
            Positioned.fill(
              child: IgnorePointer(
                ignoring: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _FsNavBtn(
                      icon: Icons.chevron_left,
                      onTap: () {
                        final prev = math.max(0, _index - 1);
                        _ctrl.animateToPage(
                          prev,
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOut,
                        );
                      },
                    ),
                    _FsNavBtn(
                      icon: Icons.chevron_right,
                      onTap: () {
                        final next =
                            math.min(widget.images.length - 1, _index + 1);
                        _ctrl.animateToPage(
                          next,
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOut,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Przycisk nawigacyjny w pełnoekranowej galerii
class _FsNavBtn extends StatelessWidget {
  const _FsNavBtn({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        color: Colors.black38,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(icon, color: Colors.white, size: 36),
          ),
        ),
      ),
    );
  }
}
