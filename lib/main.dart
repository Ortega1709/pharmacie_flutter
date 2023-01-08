import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pharmacie/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pharmacie/model/utilisateur_model.dart';
import 'package:pharmacie/screen/authentication_screen.dart';
import 'package:pharmacie/screen/produit_screen.dart';
import 'package:pharmacie/style/color.dart';

/// main function
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  /// screen orientations ...
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  /// constant app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      /// app title, and all configurations
      title: 'Pharmacie',
      debugShowCheckedModeBanner: false,

      /// app localization
      supportedLocales: L10n.all,

      /// localization delegates
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      /// app theme
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          useMaterial3: true),

      /// screen we will launch on start app
      home: const AuthenticationScreen()

    );
  }
}
