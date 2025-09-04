import 'package:flutter/material.dart';

enum AppLocale { pl, en, it }

extension AppLocaleX on AppLocale {
  Locale toLocale() => switch (this) {
        AppLocale.pl => const Locale('pl'),
        AppLocale.en => const Locale('en'),
        AppLocale.it => const Locale('it'),
      };
}

class LocaleController extends InheritedWidget {
  const LocaleController(
      {super.key,
      required this.value,
      required this.onChanged,
      required super.child});
  final AppLocale value;
  final void Function(AppLocale) onChanged;
  static LocaleController of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<LocaleController>()!;
  @override
  bool updateShouldNotify(LocaleController oldWidget) =>
      value != oldWidget.value;
}

class S {
  final AppLocale locale;
  const S(this.locale);
  static S of(BuildContext context) => S(LocaleController.of(context).value);

  String get about => _t('O mnie', 'About', 'Chi sono');
  String get projects => _t('Projekty', 'Projects', 'Progetti');
  String get offer => _t('Oferta', 'Offer', 'Offerta');
  String get contact => _t('Kontakt', 'Contact', 'Contatti');
  String get faq => _t('FAQ', 'FAQ', 'FAQ');

  String get heroPill => _t('Beautiful ◦ Functional ◦ Tailored',
      'Beautiful ◦ Functional ◦ Tailored', 'Beautiful ◦ Functional ◦ Tailored');
  String get heroTitle => _t(
      'Estetyczne i funkcjonalne wnętrza odzwierciedlające Twoją osobowość i styl życia',
      'Beautiful and functional interiors reflecting your personality and lifestyle',
      'Interni belli e funzionali che riflettono la tua personalità e il tuo stile di vita');
  String get heroSubtitle => _t(
        '',
        '',
        '',
      );
  String get ctaProjects =>
      _t('Zobacz projekty', 'View projects', 'Vedi progetti');
  String get ctaContact => _t('Skontaktuj się', 'Get in touch', 'Contattami');
  String get privacy =>
      _t('Polityka prywatności', 'Privacy Policy', 'Informativa sulla privacy');

  String get offer1title => _t(
      'Konsultacje projektowe', 'Design Consultation', 'Consulenze di design');
  String get offer1desc => _t(
      'Spotkania online, podczas których odpowiadam na Twoje pytania dotyczące projektu i udzielam profesjonalnych wskazówek w zakresie układu, stylu i materiałów, abyś mógł podejmować świadome decyzje.',
      'Online meetings where I answer your design questions and give you professional guidance on layout, style, and materials to help you make confident decisions.',
      'Incontri online in cui rispondo alle tue domande di progettazione e ti fornisco una guida professionale su layout, stile e materiali, aiutandoti a prendere decisioni consapevoli.');
  String get offer2title => _t(
      'Planowanie przestrzeni i układ funkcjonalny',
      'Space Planning & Layouts',
      'Pianificazione degli spazi e layout funzionale');
  String get offer2desc => _t(
      'Optymalizacja pomieszczeń tak, aby były piękne i wygodne w codziennym użytkowaniu.',
      'Optimizing your rooms so they work beautifully in everyday life.',
      'Ottimizzazione degli ambienti affinché risultino belli e confortevoli nella vita quotidiana.');
  String get offer3title => _t(
      'Moodboardy i koncepcje', 'Moodboards & Concepts', 'Moodboard e concept');
  String get offer3desc => _t(
      'Określenie stylu poprzez kolory, faktury, moodboardy i inspiracje.',
      'Defining your style with colors, textures, moodboards, and inspirations.',
      'Definizione del tuo stile attraverso colori, texture, moodboard e ispirazioni.');
  String get offer4title => _t('Rysunki i dokumentacja',
      'Drawings & Documentation', 'Disegni e documentazione');
  String get offer4desc => _t(
      'Czytelne, precyzyjne rysunki 2D dla wykonawców i dostawców.',
      'Clear, precise 2D drawings for contractors and suppliers.',
      'Elaborati 2D chiari e precisi per imprese edili e fornitori.');
  String get offer5title =>
      _t('Wizualizacje 3D', '3D Visualizations', 'Visualizzazioni 3D');
  String get offer5desc => _t(
      'Realistyczny podgląd Twojego nowego wnętrza jeszcze przed podjęciem decyzji. Możliwość doświadczenia przyszłej przestrzeni zanim powstanie.',
      'A realistic preview of your new space before making decisions.A chance to experience your future interior before it’s built.',
      'Un’anteprima realistica del tuo nuovo spazio prima di prendere decisioni. L’opportunità di vivere l’interno futuro ancora prima della sua realizzazione.');
  String get offer6title =>
      _t('Listy zakupowe', 'Shopping Lists', 'Liste di acquisto');
  String get offer6desc => _t(
      'Spersonalizowany dobór produktów dopasowanych do budżetu i gustu. Ekskluzywne propozycje mebli, oświetlenia i wykończeń.',
      'Tailored product selections that fit your budget and taste. Exclusive selections of furniture, lighting, and finishes.',
      'Selezione personalizzata di prodotti in linea con il tuo budget e gusto. Proposte esclusive di arredi, illuminazione e finiture.');
  String get offer7title => _t(
      'Pakiety wykonawcze', 'Contractor Packages', 'Pacchetti per appaltatori');
  String get offer7desc => _t(
      'Kompleksowa dokumentacja umożliwiająca bezproblemową realizację projektu.',
      'Complete documentation for flawless project execution.',
      'Documentazione completa per garantire un’esecuzione impeccabile del progetto.');
  String get offer8title => _t('Wsparcie dla deweloperów', 'Developer Support',
      'Supporto per sviluppatori');
  String get offer8desc => _t(
      'Pakiety dla mieszkań pokazowych lub nieruchomości na wynajem, które zwiększają atrakcyjność dla kupujących i najemców.',
      'Packages for show apartments or rental properties to attract buyers and tenants.',
      'Pacchetti per appartamenti campione o immobili destinati alla locazione, pensati per attrarre acquirenti e inquilini.');

  String get offerDown => _t(
      'Proszę o kontakt w celu przygotowania spersonalizowanej wyceny. Ostateczna cena zależy od zakresu usług, poziomu szczegółowości oraz liczby proponowanych wariantów projektu.',
      'Please contact me for a personalized cost estimate. The final price depends on the scope of services, level of detail, and the number of design options.',
      'Contattami per un preventivo personalizzato. Il prezzo finale dipende dall’ambito dei servizi, dal livello di dettaglio e dal numero di opzioni progettuali proposte.');

  String get contactForm => _t(
      'Wspólnie zaprojektujmy Twoje wymarzone wnętrze',
      'Let’s work together on your dream space',
      'Lavoriamo insieme al tuo spazio da sogno');
  // Sekcje
  String get aboutPlaceholder => _t('''Nazywam się Weronika Dzięgielewska. 
Jestem architektką wnętrz z wykształceniem zdobytym na University of the Arts w Londynie. Podczas półtorarocznej pracy w londyńskim studiu architektonicznym, specjalizującym się w projektach high-end dla klientów prywatnych, współtworzyłam w niewielkim zespole dwa złożone projekty modernizacji i rozbudowy domów jednorodzinnych w prestiżowej dzielnicy objętej ochroną konserwatorską. Po powrocie do Polski przez ostatni rok pracowałam w Warszawie przy różnorodnych projektach wnętrz dla dużej firmy, gdzie kluczowe były tempo pracy, kontakt z klientem i sprzedaż.

Studia oraz doświadczenie zawodowe w dwóch różnych środowiskach nauczyły mnie postrzegać projektowanie zarówno jako formę sztuki i wyraz tożsamości, jak i jako proces praktyczny, skupiony na funkcjonalności i realnych potrzebach użytkownika.
''', '''My name is Weronika Dziegielewska
I am an interior architect with a degree from the University of the Arts London. During my time in London, I spent a year and a half working at an architectural studio focused on high-end residential projects. As part of a close-knit team, I contributed to two complex refurbishments and extensions of single-family homes located in a conservation area in central London.
Over the past year, I have been working in Warsaw on a wide range of interior design projects for a large company, where I developed skills in fast-paced project delivery, client communication, and sales.
My academic background and professional experience have given me a multifaceted perspective on design - as a form of art, creativity, and identity, but also as a practical and user-focused discipline.
''', '''Mi chiamo Weronika Dzięgielewska.
Sono un’architetta d’interni laureata alla University of the Arts di Londra. Durante un anno e mezzo di esperienza in uno studio londinese specializzato in progetti residenziali di alto livello, ho collaborato, all’interno di un piccolo team, alla realizzazione di due complessi interventi di ristrutturazione e ampliamento di case unifamiliari situate in una zona tutelata del centro città.

Nell’ultimo anno ho lavorato a Varsavia per una grande azienda, partecipando a numerosi progetti diversi. Questo contesto mi ha permesso di sviluppare competenze nella gestione di ritmi intensi, nella comunicazione con il cliente e nel supporto alla vendita.

Il mio percorso accademico e professionale mi ha permesso di vedere il design da molteplici punti di vista — come espressione artistica, spazio creativo e identitario, ma anche come disciplina pratica, orientata alla funzionalità e alle esigenze reali delle persone.
''');
  String get enterName => _t('Podaj imię i nazwisko', 'Enter your full name',
      'Inserisci nome e cognome');
  String get enterEmail =>
      _t('Podaj e‑mail', 'Enter your e‑mail', 'Inserisci e‑mail');
  String get enterMessage =>
      _t('Napisz wiadomość', 'Enter your message', 'Scrivi un messaggio');
  String get incorrectEmail =>
      _t('Nieprawidłowy e‑mail', 'Incorrect e‑mail', 'E‑mail non valido');

  String get messageHint => _t(
      'Opisz krótko czego potrzebujesz',
      'Briefly describe what you need',
      'Descrivi brevemente di cosa hai bisogno');
  String get projectsHint =>
      _t('Dodaj projekt', 'Add project', 'Aggiungi progetto');
  String get offerHint => _t(
      '''Oferuję pełne spektrum usług projektowych dostosowanych do Twoich potrzeb - niezależnie od tego, czy szukasz profesjonalnej porady, kompleksowej koncepcji projektowej, czy szczegółowej dokumentacji dla wykonawców. Pracuję zdalnie z klientami na całym świecie, a wizyty na miejscu i spotkania osobiste są możliwe w Polsce, na Sycylii oraz w Londynie - po wcześniejszym uzgodnieniu.''',
      '''I provide a full spectrum of design services tailored to your needs - whether you’re looking for professional advice, a fully developed design concept, or detailed documentation ready for contractors. I work remotely worldwide. I work with clients worldwide, with site visits and in-person meetings available in Poland, Sicily and London upon agreement.''',
      '''Offro una gamma completa di servizi di interior design su misura per le tue esigenze - che tu stia cercando una consulenza professionale, un concept di progetto completo o una documentazione dettagliata per gli appaltatori. Lavoro a distanza con clienti in tutto il mondo, con possibilità di visite in loco e incontri di persona in Polonia, in Sicilia e a Londra previo accordo.''');
  String get name => _t('Imię i nazwisko *', 'Full name *', 'Nome e cognome *');
  String get email => _t('E‑mail *', 'E‑mail *', 'E‑mail *');
  String get message => _t('Wiadomość *', 'Message *', 'Messaggio *');
  String get send => _t('Wyślij', 'Send', 'Invia');
  String get phone => _t('Telefon', 'Phone', 'Telefono');
  String get address => _t('Adres', 'Address', 'Indirizzo');
  String get language => _t('Język', 'Language', 'Lingua');
  String get faq1q => _t(
      'Jak wygląda współpraca online?',
      'How does the design process work if we collaborate remotely?',
      'Come funziona la collaborazione a distanza?');

  String get faq1a => _t(
      'Cała komunikacja odbywa się przez wideorozmowy i e-mail. Wystarczy, że prześlesz mi zdjęcia, wymiary lub rzut mieszkania, a ja przygotuję układ funkcjonalny, koncepcję i wizualizacje. Otrzymujesz dokumentację w formie cyfrowej, którą łatwo przekazać wykonawcom, więc cały proces przebiega sprawnie nawet bez spotkania na miejscu.',
      'All communication happens online via video calls and email. You send me photos, measurements, or floor plans of your space, and I prepare layouts, concepts, and visualizations. You receive digital documentation that’s easy to share with contractors, so the process is smooth even without an in-person visit.',
      'Tutta la comunicazione avviene tramite videochiamate ed e-mail. Mi invii foto, misure o la planimetria, e io preparo layout funzionali, concept e visualizzazioni 3D. Ricevi una documentazione digitale facile da condividere con imprese e fornitori, così il processo è fluido anche senza incontro in presenza.');

  String get faq2q => _t(
      'Czy musisz zobaczyć moje mieszkanie na żywo?',
      'Do you need to visit my space in person?',
      'È necessario che tu visiti lo spazio di persona?');

  String get faq2a => _t(
      'Nie jest to konieczne. Większość projektów realizuję w pełni online. Jeśli jednak projekt znajduje się w Polsce, Londynie lub na Sycylii, możemy umówić wizytę na miejscu. Koszty podróży ustalamy indywidualnie.',
      'Not necessarily. Most projects are completed fully online. However, if your project is in Poland, Sicily, or London we can arrange an on-site visit or meeting. Travel costs are agreed individually.',
      'Non sempre. La maggior parte dei progetti si realizza interamente online. Tuttavia, se il progetto si trova in Polonia, Londra o Sicilia, possiamo concordare una visita in loco. Le spese di viaggio vengono definite caso per caso.');

  String get faq3q => _t(
      'Jak wyceniany jest projekt?',
      'How is pricing calculated?',
      'Come viene calcolato il prezzo del progetto?');

  String get faq3a => _t(
      'Każdy projekt wyceniam indywidualnie. Cena zależy od wybranego zakresu usług (konsultacja, koncepcja, rysunki, dokumentacja wykonawcza), poziomu szczegółowości oraz liczby wizualizacji i proponowanych wariantów.',
      'Each project is priced individually. The final cost depends on the services you choose (consultation, concept, drawings, contractor package), the level of detail, and the number of visualizations or design options required.',
      'Ogni progetto viene preventivato individualmente. Il costo finale dipende dai servizi scelti (consulenza, concept, disegni, pacchetto tecnico), dal livello di dettaglio e dal numero di visualizzazioni o varianti progettuali richieste.');

  String get faq4q => _t(
      'Jakie materiały muszę przygotować na początek?',
      'What information do you need to start?',
      'Quali materiali devo fornire all’inizio?');

  String get faq4a => _t(
      'Na start proszę zazwyczaj o rzut mieszkania, wymiary pomieszczeń, zdjęcia i krótki opis Twoich potrzeb oraz stylu życia. Bardzo pomocne są również inspiracje, np. z Pinteresta - dzięki nim łatwiej zrozumiem Twój gust i oczekiwania.',
      'At the beginning, I usually ask for floor plans, room measurements, photos, and a short description of your needs and lifestyle. Any inspiration images or Pinterest boards are also welcome — they help me better understand your taste and expectations.',
      'Di solito chiedo la planimetria, le misure degli ambienti, alcune foto e una breve descrizione delle tue esigenze e del tuo stile di vita. Sono molto utili anche immagini di riferimento o bacheche Pinterest, perché aiutano a capire meglio i tuoi gusti.');

  String get faq5q => _t(
      'Ile trwa realizacja projektu?',
      'How long does a project take?',
      'Quanto tempo serve per completare un progetto?');

  String get faq5a => _t(
      'To zależy od skali i zakresu prac. Prosta konsultacja czy układ funkcjonalny zajmuje zwykle 1–2 tygodnie, a pełen projekt z dokumentacją i wizualizacjami - około 4-8 tygodni. Zawsze podaję szacowany czas realizacji przed rozpoczęciem współpracy.',
      'It depends on the scope and size of the project. A simple consultation or layout plan can take 1–2 weeks, while a full design package with drawings and visualizations usually takes 4–8 weeks. I’ll always give you an estimated timeline before starting.',
      'Dipende dall’entità e dalla complessità. Una semplice consulenza o un layout funzionale richiede 1-2 settimane, mentre un progetto completo con disegni e visualizzazioni richiede in media 4-8 settimane. Prima di iniziare, fornisco sempre una stima dei tempi.');

  String get faq6q => _t(
      'Czy mogę zostawić dotychczasowe meble lub elementy wystroju?',
      'Can you work with my existing furniture or decor?',
      'Puoi integrare mobili o arredi che già possiedo?');

  String get faq6a => _t(
      'Oczywiście. Jeśli chcesz zachować wybrane meble lub dodatki, dopasuję projekt tak, aby je uwzględnić i wkomponować w nową koncepcję. Dzięki temu wnętrze zyskuje indywidualny charakter.',
      'Absolutely. If you’d like to keep certain pieces, I’ll design around them and integrate them into the new concept. This often adds a unique, personal character to the project.',
      'Certamente. Se desideri mantenere alcuni pezzi, li includerò nella nuova proposta e li valorizzerò nel contesto generale. Questo dona agli interni un carattere unico e personale.');

  String get faq7q => _t(
      'Czy przygotowujesz listy zakupów i pomagasz w wyborze produktów?',
      'Do you also provide shopping lists and help with sourcing?',
      'Offri anche liste d’acquisto e supporto nella scelta dei prodotti?');

  String get faq7a => _t(
      'Tak. Mogę przygotować spersonalizowaną listę mebli, oświetlenia i dodatków - z linkami do produktów i propozycjami alternatyw w różnych przedziałach cenowych. To znacznie ułatwia i przyspiesza zakupy.',
      'Yes. I can create tailored shopping lists with furniture, lighting, and accessories — including links to products and alternatives at different price points. This makes it easier and faster for you to shop.',
      'Sì. Posso creare liste personalizzate di mobili, illuminazione e accessori, con link diretti ai prodotti e alternative in diverse fasce di prezzo. In questo modo lo shopping è più semplice e veloce.');

  String get faq8q => _t(
      'Czy współpracujesz także z deweloperami i firmami?',
      'Do you work with developers and businesses?',
      'Lavori anche con sviluppatori immobiliari o aziende?');

  String get faq8a => _t(
      'Tak. Oprócz projektów prywatnych zajmuję się również aranżacją mieszkań pokazowych, lokali na wynajem oraz wybranych przestrzeni publicznych. Oferuję pełną dokumentację wykonawczą i wizualizacje, które zwiększają atrakcyjność nieruchomości na rynku.',
      'Yes. In addition to private residential projects, I also design show apartments, rental properties, and selected public spaces. I provide contractor-ready documentation and visualizations that help increase the market appeal of a property.',
      'Sì. Oltre ai progetti residenziali privati, realizzo anche interni per appartamenti campione, immobili destinati all’affitto e alcuni spazi pubblici. Fornisco documentazione tecnica completa e visualizzazioni che aumentano l’attrattiva della proprietà sul mercato.');

  String _t(String pl, String en, String it) => switch (locale) {
        AppLocale.pl => pl,
        AppLocale.en => en,
        AppLocale.it => it,
      };
}
