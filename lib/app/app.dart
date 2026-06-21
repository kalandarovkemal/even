import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/di/injector.dart';
import '../core/i18n/locale_cubit.dart';
import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../ui/splash/splash_screen.dart';

class EvenApp extends StatelessWidget {
  const EvenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleCubit>(
      create: (_) => LocaleCubit(sl())..start(),
      child: BlocBuilder<LocaleCubit, Locale?>(
        builder: (context, locale) {
          return MaterialApp(
            title: 'Even',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.dark,
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
