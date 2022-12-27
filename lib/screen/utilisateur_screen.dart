import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../style/color.dart';
import '../style/text.dart';

/// utilisateur screen
class UtilisateurScreen extends StatefulWidget {
  const UtilisateurScreen({Key? key}) : super(key: key);

  @override
  State<UtilisateurScreen> createState() => _UtilisateurScreenState();
}

class _UtilisateurScreenState extends State<UtilisateurScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: true,
        title: PrimaryText(text: AppLocalizations.of(context)!.utilisateurs),
      ),
    );
  }

  /// refresh state
  _refresh() {
    setState(() {});
  }

}
