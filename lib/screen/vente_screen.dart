import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  void dispose() {
    super.dispose();
  }

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
            child: const Icon(FontAwesomeIcons.refresh, color: AppColors.white, size: 18),
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


}
