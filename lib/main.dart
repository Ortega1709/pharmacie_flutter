import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmacie/style/color.dart';

/// main function
void main() async {

  /// initialize fire store project
  /// fire store for save our data
  Firestore.initialize("pharmadb-50464");
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

      /// title app, and all configurations
      title: 'Pharmacie',
      debugShowCheckedModeBanner: false,

      /// app theme
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.white,
          primarySwatch: Colors.blue,
          useMaterial3: true),

      /// screen we will launch on start app
      home: Placeholder(),
    );
  }
}
