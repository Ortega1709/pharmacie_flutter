import 'package:flutter/material.dart';
import 'package:pharmacie/model/utilisateur_model.dart';

/// main screen
class MainScreen extends StatefulWidget {

  /// current user logged
  final UtilisateurModel utilisateurModel;
  const MainScreen({Key? key, required this.utilisateurModel}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(widget.utilisateurModel.email)),
    );
  }
}
