import 'package:flutter/material.dart';

class Project {
  final String title;
  final String short; // krótki opis – na karcie
  final String longDescription; // dłuższy opis – w detalu
  final String coverImage; // JEDNO zdjęcie na kartę (asset lub URL)
  final List<String> gallery; // 0..N zdjęć po kliknięciu

  const Project({
    required this.title,
    required this.short,
    required this.longDescription,
    required this.coverImage,
    this.gallery = const [],
  });
}

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});
  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  late List<Project> projects;

  @override
  void initState() {
    super.initState();
    projects = [
      const Project(
        title: 'Albion Drive',
        short: 'Renowacja i rozbudowa dwupiętrowego domu w stylu wiktoriańskim',
        longDescription:
            '''Projekt dotyczył renowacji i rozbudowy dwupiętrowego domu w stylu wiktoriańskim, położonego na końcu szeregowej zabudowy, zlokalizowanego w dzielnicy Albion Square Conservation Area.

Zakres prac obejmował:
• Budowę nowego parterowego przedłużenia boczno-tylnego w miejscu istniejącej rozbudowy.
• Wymianę świetlika dachowego oraz dodanie nowego okna dachowego na poddaszu.
• Ogólną renowację – stworzenie nowoczesnego, wysokiej jakości domu rodzinnego,
  przy jednoczesnym poszanowaniu istniejących walorów architektonicznych.''',
        coverImage: 'assets/images/mini_proj1.jpg',
        gallery: [
          'assets/images/proj1_1.jpg',
          'assets/images/proj1_2.jpg',
        ],
      ),
      const Project(
        title: 'Copper I',
        short: 'Projekt nowoczesnej łazienki',
        longDescription:
            '''Projekt nowoczesnej łazienki, w której połączenie miedzianych akcentów, matowej czerni oraz bieli tworzy wyrazisty, a zarazem ponadczasowy charakter.
Przygotowałam dwie propozycje tej łazienki (po lewej i prawej), aby dać klientowi możliwość wyboru i wspólnie wypracować najlepsze rozwiązanie. W swojej
pracy stawiam na otwartość, elastyczność i aktywny kontakt z inwestorem, tak aby projekt był w pełni dopasowany do jego potrzeb.
        ''',
        coverImage: 'assets/images/mini_proj2.jpg',
        gallery: [
          'assets/images/proj2_1.jpg',
          'assets/images/proj2_2.jpg',
          'assets/images/proj2_3.jpg',
        ],
      ),
      const Project(
        title: 'Copper II',
        short: 'Projekt nowoczesnej łazienki',
        longDescription:
            '''Projekt nowoczesnej łazienki, w której połączenie miedzianych akcentów, matowej czerni oraz bieli tworzy wyrazisty, a zarazem ponadczasowy charakter.
Przygotowałam dwie propozycje tej łazienki (po lewej i prawej), aby dać klientowi możliwość wyboru i wspólnie wypracować najlepsze rozwiązanie. W swojej
pracy stawiam na otwartość, elastyczność i aktywny kontakt z inwestorem, tak aby projekt był w pełni dopasowany do jego potrzeb.
        ''',
        coverImage: 'assets/images/mini_proj3.jpg',
        gallery: [
          'assets/images/proj3_1.jpg',
          'assets/images/proj3_2.jpg',
          'assets/images/proj3_3.jpg',
        ],
      ),
      const Project(
        title: 'Olive Green Elegance',
        short: 'Kuchnia dla dużej rodziny',
        longDescription:
            '''Kuchnia dla dużej rodziny. Oliwkowa zieleń w połączeniu ze szczotkowanym złotem i marmurowymi akcentami tworzy elegancką, ale i ciepłą atmosferę.
Wyspa łączy przestrzeń kuchni z salonem, sprzyjając wspólnemu spędzaniu czasu.
Na prośbę Klientki w projekcie znajdują się słupek z piekarnikiem oraz miejsce
na dwudrzwiową lodówkę, zapewniające maksymalną funkcjonalność i komfort.''',
        coverImage: 'assets/images/mini_proj4.jpg',
        gallery: [
          'assets/images/proj4_1.jpg',
          'assets/images/proj4_2.jpg',
          'assets/images/proj4_3.jpg',
          'assets/images/proj4_4.jpg',
          'assets/images/proj4_5.jpg',
          'assets/images/proj4_6.jpg',
          'assets/images/proj4_7.jpg',
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final cross = w < 600 ? 1 : (w < 1000 ? 2 : 3);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
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
            onTap: () => _openProject(projects[i]),
          ),
        ),
      ],
    );
  }

  void _openProject(Project p) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        showDragHandle: true,
        builder: (_) => _ProjectDetails(project: p),
      );
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project, required this.onTap});
  final Project project;
  final VoidCallback onTap;

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
            colorFilter:
                const ColorFilter.mode(Colors.black26, BlendMode.darken),
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
                  const SizedBox(height: 4),
                  Text(
                    project.short,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectDetails extends StatefulWidget {
  const _ProjectDetails({required this.project});
  final Project project;

  @override
  State<_ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<_ProjectDetails> {
  final PageController _page = PageController();
  int _i = 0;

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
            Row(children: [
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
            ]),
            const SizedBox(height: 16),
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
                        itemBuilder: (_, i) => Ink.image(
                          image: _imgProvider(gallery[i]),
                          fit: BoxFit.cover,
                          child: const SizedBox.expand(),
                        ),
                      ),
                      Positioned.fill(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _NavBtn(
                              icon: Icons.chevron_left,
                              onTap: () {
                                final prev =
                                    (_i - 1).clamp(0, gallery.length - 1);
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
                                    (_i + 1).clamp(0, gallery.length - 1);
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
              const SizedBox(height: 16),
            ],
            const SizedBox(height: 6),
            Text(
              p.longDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBtn extends StatelessWidget {
  const _NavBtn({required this.icon, required this.onTap});
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
