import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../style/color.dart';
import '../style/text.dart';

/// information screen
class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

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
        child: const Icon(Icons.refresh, color: AppColors.white,),
      ),
    );
  }

  /// refresh state
  _refresh() {
    setState(() {});
  }
}
