import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacie/model/utilisateur_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pharmacie/screen/information_screen.dart';
import 'package:pharmacie/screen/settings_screen.dart';
import 'package:pharmacie/screen/produit_screen.dart';
import 'package:pharmacie/screen/vente_screen.dart';

import '../style/color.dart';
import '../style/text.dart';

/// main screen
class MainScreenMedecin extends StatefulWidget {
  /// current user logged
  final UtilisateurModel utilisateurModel;

  const MainScreenMedecin({Key? key, required this.utilisateurModel})
      : super(key: key);

  @override
  State<MainScreenMedecin> createState() => _MainScreenMedecinState();
}

class _MainScreenMedecinState extends State<MainScreenMedecin> {
  /// current index of view pager
  int currentIndex = 0;

  /// controller of view pager
  PageController pageController = PageController();

  /// isExtend
  bool isExtend = false;

  @override
  void dispose() {
    /// free space for [pageController]
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [

            MouseRegion(

              onEnter: (_) => setState(() { isExtend = !isExtend; }),
              onExit: (_) => setState(() { isExtend = !isExtend; }),
              child: NavigationRail(

                extended: isExtend,
                indicatorColor: AppColors.blue,
                onDestinationSelected: (index) async => setState(() {
                  currentIndex = index;
                  pageController.jumpToPage(currentIndex);
                }),


                unselectedIconTheme: const IconThemeData(color: AppColors.blue),
                unselectedLabelTextStyle: GoogleFonts.inter(color: AppColors.grey, fontSize: 16.0, fontWeight: FontWeight.w500),
                selectedLabelTextStyle: GoogleFonts.inter(color: AppColors.blue, fontSize: 16.0, fontWeight: FontWeight.w500),
                groupAlignment: 0,

                destinations: [
                  NavigationRailDestination(icon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 18), label: Text((AppLocalizations.of(context)!.informations))),
                  NavigationRailDestination(icon: const Icon(FontAwesomeIcons.gears, size: 18), label: Text((AppLocalizations.of(context)!.parametre)))
                ],

                selectedIndex: currentIndex,
              ),
            ),

            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                children:  [
                  InformationScreen(utilisateurModel: widget.utilisateurModel),
                  SettingsScreen(utilisateurModel: widget.utilisateurModel)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
