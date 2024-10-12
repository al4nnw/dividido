import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'const/colors.dart';
import 'firebase_options.dart';
import 'ui/screens/sign_in/sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('pt')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const ProviderScope(child: Root())),
  );
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.deepOrange, // Dark orange color for primary elements
          secondary: Colors.deepOrange, // Dark orange color for accent elements
        ),
        textTheme: GoogleFonts.notoSerifTextTheme(
          Theme.of(context).textTheme.copyWith(
                headlineLarge: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
                headlineSmall: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                bodySmall: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Color(0xff4A4A4A),
                ),
              ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: backgroundColor,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            surfaceTintColor: Colors.deepOrange, // Dark orange color for buttons
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Colors.deepOrange, // Dark orange color for FAB icon
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(90)),
          ),
        ),
      ),
      home: const SignIn(),
    );
  }
}
