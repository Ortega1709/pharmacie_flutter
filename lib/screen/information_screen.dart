import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmacie/model/utilisateur_model.dart';

import '../style/color.dart';
import '../style/text.dart';

/// information screen
class InformationScreen extends StatefulWidget {

  final UtilisateurModel utilisateurModel;

  const InformationScreen({Key? key, required this.utilisateurModel}) : super(key: key);

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: PrimaryText(text: AppLocalizations.of(context)!.informations),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blue,
        onPressed: () {
          _refresh();
        },
        child: const Icon(FontAwesomeIcons.refresh, color: AppColors.white, size: 18),
      ),
    );
  }

  /// refresh state
  _refresh() {
    setState(() {});
  }
}
