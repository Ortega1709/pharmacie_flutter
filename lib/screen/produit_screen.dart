import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../style/color.dart';
import '../style/text.dart';

/// produit screen
class ProduitScreen extends StatefulWidget {
  const ProduitScreen({Key? key}) : super(key: key);

  @override
  State<ProduitScreen> createState() => _ProduitScreenState();
}

class _ProduitScreenState extends State<ProduitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: true,
        title: PrimaryText(text: AppLocalizations.of(context)!.produits),
      ),
    );
  }

  /// refresh state
  _refresh() {
    setState(() {});
  }
}
