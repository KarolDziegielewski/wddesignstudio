import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app.dart';
import 'theme.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const WDDesignStudioRoot());
}

class WDDesignStudioRoot extends StatefulWidget {
  const WDDesignStudioRoot({super.key});
  @override
  State<WDDesignStudioRoot> createState() => _WDDesignStudioRootState();
}

class _WDDesignStudioRootState extends State<WDDesignStudioRoot> {
  AppLocale _locale = AppLocale.pl; // domyślnie PL

  void _onLocaleChanged(AppLocale locale) => setState(() => _locale = locale);

  @override
  Widget build(BuildContext context) {
    return LocaleController(
      value: _locale,
      onChanged: _onLocaleChanged,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WD Design Studio',
        theme: buildTheme(Brightness.light),
        darkTheme: buildTheme(Brightness.dark),
        themeMode: ThemeMode.light,
        // Minimalna integracja z systemem lokalizacji Fluttera
        locale: _locale.toLocale(),
        supportedLocales: const [
          Locale('pl'), Locale('en'), Locale('it')
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const LandingPage(),
      ),
    );
  }
}