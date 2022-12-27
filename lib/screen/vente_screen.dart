import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        automaticallyImplyLeading: true,
        title: PrimaryText(text: AppLocalizations.of(context)!.ventes),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blue,
        onPressed: () {
          _refresh();
        },
        child: const Icon(Icons.refresh, color: AppColors.white,),
      ),
    );
  }

  /// refresh state
  _refresh() {
    setState(() {});
  }

}
