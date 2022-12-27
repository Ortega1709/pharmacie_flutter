import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacie/style/text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../style/color.dart';

/// dashboard screen
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: PrimaryText(text: AppLocalizations.of(context)!.dashboard),
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
