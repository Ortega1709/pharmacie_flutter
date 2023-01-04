import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmacie/model/detail_commande_model.dart';
import 'package:pharmacie/model/utilisateur_model.dart';
import 'package:pharmacie/screen/detail_commande_screen.dart';
import 'package:pharmacie/style/color.dart';

import '../style/text.dart';

/// commande screen
class CommandeScreen extends StatefulWidget {

  final UtilisateurModel utilisateurModel;

  const CommandeScreen({Key? key, required this.utilisateurModel}) : super(key: key);

  @override
  State<CommandeScreen> createState() => _CommandeScreenState();
}

class _CommandeScreenState extends State<CommandeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: PrimaryText(text: AppLocalizations.of(context)!.commandes),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: "btn1",
              backgroundColor: AppColors.blue,
              onPressed: () async {
                _refresh();
              },
              child: const Icon(FontAwesomeIcons.refresh, color: AppColors.white, size: 18)),

          const SizedBox(width: 5),
          FloatingActionButton.extended(
            heroTag: "btn2",
            backgroundColor: AppColors.blue,
            icon: const Icon(Icons.add_rounded, color: AppColors.white),
            onPressed: () {
              Navigator
                  .of(context)
                  .push(MaterialPageRoute(builder: (context) => DetailCommandeScreen(utilisateurModel: widget.utilisateurModel)));
            },
            label: SecondaryText(
              text: AppLocalizations.of(context)!.ajouter,
            ),
          ),
        ],
      ),
    );
  }

  /// refresh state
  _refresh() {
    setState(() {});
  }
}
