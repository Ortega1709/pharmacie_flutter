import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacie/model/utilisateur_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pharmacie/screen/commande_screen.dart';
import 'package:pharmacie/screen/dashboard_screen.dart';
import 'package:pharmacie/screen/information_screen.dart';
import 'package:pharmacie/screen/produit_screen.dart';
import 'package:pharmacie/screen/utilisateur_screen.dart';
import 'package:pharmacie/screen/vente_screen.dart';

import '../style/color.dart';
import '../style/text.dart';

/// main screen
class MainScreen extends StatefulWidget {

  /// current user logged
  final UtilisateurModel utilisateurModel;
  const MainScreen({Key? key, required this.utilisateurModel}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  /// current index of view pager
  int currentIndex = 0;

  /// controller of view pager
  PageController pageController = PageController();

  @override
  void dispose() {

    /// free space for [pageController]
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.blue,
              child: Column(
                children: [

                  /// navigation part
                  Expanded(
                    flex: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: MaterialButton(
                        onPressed: () {},
                        child: ListTile(
                          leading: const Icon(
                              Icons.admin_panel_settings,
                              color: Colors.white),
                          title: SecondaryText(
                              text: widget.utilisateurModel.email),
                          subtitle: ThirdText(
                              text: widget.utilisateurModel.type),
                        ),
                      ),
                    ),
                  ),

                  /// view part
                  Expanded(
                    flex: 6,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [

                            /// button one
                            MaterialButton(
                              onPressed: () async {
                                pageController.jumpToPage(0);
                              },
                              child: ListTile(
                                focusColor: AppColors.blue,
                                leading: const Icon(Icons.house,
                                    color: AppColors.white),
                                title: SecondaryText(
                                    text: AppLocalizations
                                        .of(context)!.dashboard),
                              ),
                            ),

                            /// button two
                            MaterialButton(
                              onPressed: () async {
                                pageController.jumpToPage(1);
                              },
                              child: ListTile(
                                leading: const Icon(Icons.point_of_sale,
                                    color: AppColors.white),
                                title: SecondaryText(
                                    text: AppLocalizations
                                        .of(context)!.ventes),
                              ),
                            ),

                            /// button three
                            MaterialButton(
                              onPressed: () async {
                                pageController.jumpToPage(2);
                              },
                              child: ListTile(
                                leading: const Icon(Icons.search,
                                    color: AppColors.white),
                                title: SecondaryText(text: AppLocalizations
                                    .of(context)!.informations),
                              ),
                            ),

                            /// button four
                            MaterialButton(
                              onPressed: () async {
                                pageController.jumpToPage(3);
                              },
                              child: ListTile(
                                leading: const Icon(Icons.vaccines,
                                    color: AppColors.white),
                                title: SecondaryText(text: AppLocalizations
                                    .of(context)!.produits),
                              ),
                            ),

                            /// button five
                            MaterialButton(
                              onPressed: () async {
                                pageController.jumpToPage(4);
                              },
                              child: ListTile(
                                leading: const Icon(Icons.group,
                                    color: AppColors.white),
                                title: SecondaryText(text: AppLocalizations
                                    .of(context)!.utilisateurs),
                              ),
                            ),

                            /// button six
                            MaterialButton(
                              onPressed: () async {
                                pageController.jumpToPage(5);
                              },
                              child: ListTile(
                                leading: const Icon(CupertinoIcons.list_bullet,
                                    color: AppColors.white),
                                title: SecondaryText(text: AppLocalizations
                                    .of(context)!.commandes),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          /// page view part
          Expanded(
            flex: 3,
            child: SafeArea(
              child: SizedBox.expand(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },


                  children: const [
                    DashboardScreen(),
                    VenteScreen(),
                    InformationScreen(),
                    ProduitScreen(),
                    UtilisateurScreen(),
                    CommandeScreen()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
