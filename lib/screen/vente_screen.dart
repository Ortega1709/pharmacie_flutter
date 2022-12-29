import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pharmacie/model/detail_vente_model.dart';
import 'package:pharmacie/model/vente_model.dart';
import 'package:pharmacie/repository/vente_repository.dart';

import '../model/produit_model.dart';
import '../style/color.dart';
import '../style/text.dart';

/// vente screen
class VenteScreen extends StatefulWidget {
  const VenteScreen({Key? key}) : super(key: key);

  @override
  State<VenteScreen> createState() => _VenteScreenState();
}

class _VenteScreenState extends State<VenteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: PrimaryText(text: AppLocalizations.of(context)!.ventes)),

      /// floating action buttons
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: AppColors.blue,
            onPressed: () {
              _refresh();
            },
            child: const Icon(Icons.refresh, color: AppColors.white,),
          ),

          const SizedBox(width: 5.0),
          FloatingActionButton.extended(
            backgroundColor: AppColors.blue,
            onPressed: () async {
              _vendreDialog();
            },
            icon: const Icon(Icons.article, color: AppColors.white),
            label: const SecondaryText(text: "Vendre"),
          ),
        ],
      )
    );
  }

  /// refresh state
  _refresh() {
    setState(() {});
  }

  /// methode
  _vendreDialog() async {

  }

}
