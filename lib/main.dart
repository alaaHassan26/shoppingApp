import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shoping/cache/cache_helper.dart';

import 'package:shoping/core/manger/app_lang_cubit/app_lang_cubit.dart';
import 'package:shoping/core/manger/app_theme_cubit/app_theme_cubit.dart';
import 'package:shoping/core/models/Enums/lang_event_type.dart';
import 'package:shoping/core/models/Enums/theme_state.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/app_router.dart';
import 'package:shoping/core/utils/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper().init();

  setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                AppLangCubit()..appLang(LangEventEnums.initialLang)),
        BlocProvider(
            create: (context) =>
                AppThemeCubit()..changeTheme(ThemeState.initial)),
      ],
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, themeState) {
          ThemeData themeData;
          if (themeState is AppLightTheme) {
            themeData = ThemeData.light();
          } else {
            themeData = ThemeData.dark();
          }
          return BlocBuilder<AppLangCubit, AppLangState>(
            builder: (context, langState) {
              if (langState is AppChangeLang) {
                return MaterialApp.router(
                  routerConfig: AppRouter.router,
                  debugShowCheckedModeBanner: false,
                  theme: themeData,
                  locale: Locale(langState.languageCode!),
                  supportedLocales: const [
                    Locale('en'),
                    Locale('ar'),
                  ],
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate
                  ],
                  localeResolutionCallback: (deviceLocal, supportedLocales) {
                    for (var local in supportedLocales) {
                      if (deviceLocal != null) {
                        if (deviceLocal.languageCode == local.languageCode) {
                          return deviceLocal;
                        }
                      }
                    }
                    return supportedLocales.first;
                  },
                );
              }
              return MaterialApp.router(
                routerConfig: AppRouter.router,
                debugShowCheckedModeBanner: false,
                theme: themeData,
                supportedLocales: const [
                  Locale('en'),
                  Locale('ar'),
                ],
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                localeResolutionCallback: (deviceLocal, supportedLocales) {
                  for (var local in supportedLocales) {
                    if (deviceLocal != null) {
                      if (deviceLocal.languageCode == local.languageCode) {
                        return deviceLocal;
                      }
                    }
                  }
                  return supportedLocales.first;
                },
              );
            },
          );
        },
      ),
    );
  }
}
