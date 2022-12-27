import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pharmacie/style/color.dart';

import '../style/text.dart';

/// commande screen
class CommandeScreen extends StatefulWidget {
  const CommandeScreen({Key? key}) : super(key: key);

  @override
  State<CommandeScreen> createState() => _CommandeScreenState();
}

class _CommandeScreenState extends State<CommandeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: true,
        title: PrimaryText(text: AppLocalizations.of(context)!.commandes),
      ),
    );
  }

  /// refresh state
  _refresh() {
    setState(() {});
  }
}
