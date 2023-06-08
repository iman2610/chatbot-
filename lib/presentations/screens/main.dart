import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/logic/cubit/auth_cubit.dart';
import 'package:firstapp/logic/cubit/change_pw_cubit.dart';
import 'package:firstapp/logic/cubit/chat_cubit.dart';
import 'package:firstapp/logic/cubit/regist_cubit.dart';
import 'package:firstapp/presentations/screens/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../logic/auth.dart';
import '../../logic/cubit/change_info_cubit.dart';
import '../providers/themeprovider.dart';
import 'LoginScreen.dart';
import 'home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  // await Auth().linitializeOnesignal();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
          child: LoginScreen(),
        ),
        BlocProvider<RegistCubit>(
          create: (context) => RegistCubit(),
        ),
        BlocProvider<ChangePwCubit>(
          create: (context) => ChangePwCubit(),
        ),
        BlocProvider<ChatCubit>(
          create: (context) => ChatCubit(),
        ),
        BlocProvider<ChangeInfoCubit>(
          create: (context) => ChangeInfoCubit(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('fr'),
              Locale('ar'),
            ],
            localeResolutionCallback: (locale, supportedlocales) {
              for (var supportedlocale in supportedlocales) {
                print(locale!.languageCode);
                if (supportedlocale.languageCode == locale.languageCode &&
                    supportedlocale.countryCode == locale.countryCode) {
                  return supportedlocale;
                }
                print("$supportedlocale ");
              }
              return supportedlocales.first;
            },
            debugShowCheckedModeBanner: false,
            theme: themeProvider.themeData(context),
            home: LoginScreen(),
          );
        },
      ),
    );
  }

  static void setLocale(BuildContext context, Locale locale) {}
}
