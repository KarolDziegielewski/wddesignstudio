import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app.dart';
import 'theme.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const WDDesignStudioRoot());
}

/// Główny widget aplikacji, zarządza stanem lokalizacji
class WDDesignStudioRoot extends StatefulWidget {
  const WDDesignStudioRoot({super.key});

  @override
  State<WDDesignStudioRoot> createState() => _WDDesignStudioRootState();
}

class _WDDesignStudioRootState extends State<WDDesignStudioRoot> {
  // Aktualnie wybrana lokalizacja aplikacji
  AppLocale _locale = AppLocale.pl;

  // Aktualizuje lokalizację po zmianie
  void _onLocaleChanged(AppLocale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LocaleController(
      value: _locale,
      onChanged: _onLocaleChanged,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WD Design Studio',
        theme: buildTheme(Brightness.light), // Motyw jasny
        darkTheme: buildTheme(Brightness.dark), // Motyw ciemny
        themeMode: ThemeMode.light, // Wymuszony motyw jasny
        locale: _locale.toLocale(), // Ustawienie lokalizacji aplikacji
        supportedLocales: const [
          Locale('pl'),
          Locale('en'),
          Locale('it'),
        ], // Obsługiwane lokalizacje
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ], // Delegaty lokalizacyjne Fluttera
        home: const LandingPage(), // Strona startowa aplikacji
      ),
    );
  }
}
