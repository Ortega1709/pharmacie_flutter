
import 'package:flutter/material.dart';
import 'package:pharmacie/model/utilisateur_model.dart';
import 'package:pharmacie/style/text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../style/color.dart';

class SettingsScreen extends StatefulWidget {

  final UtilisateurModel utilisateurModel;

  const SettingsScreen({Key? key, required this.utilisateurModel}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: SecondaryText(text: AppLocalizations.of(context)!.deconnection, color: AppColors.red))
        ],
      ),
    );
  }
}
