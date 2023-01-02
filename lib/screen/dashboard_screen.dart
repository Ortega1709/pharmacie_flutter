import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmacie/model/utilisateur_model.dart';
import 'package:pharmacie/repository/produit_repository.dart';
import 'package:pharmacie/repository/utilisateur_repository.dart';
import 'package:pharmacie/repository/vente_repository.dart';
import 'package:pharmacie/style/text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../style/color.dart';

/// dashboard screen
class DashboardScreen extends StatefulWidget {

  final UtilisateurModel utilisateurModel;

  const DashboardScreen({Key? key, required this.utilisateurModel}) : super(key: key);

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

      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32.0),
        child: Column(
            children: [
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FutureBuilder(
                        future: VenteRepository().amount(),
                        builder: (context, snapshot) {

                          // if connection is waiting show circular progress indicator
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(color: AppColors.blue));
                          }

                          // if there are one error
                          if (snapshot.hasError) {
                            return Center(
                                child: PrimaryText(text: AppLocalizations.of(context)!.oops));
                          }

                          return Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Container(
                              width: 250,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(16.0)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Icon(FontAwesomeIcons.coins, size: 32, color: AppColors.blue),
                                        SecondaryText(text: "Somme", color: AppColors.blue)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SecondaryText(text: "${snapshot.data} fc", color: AppColors.blue, fontSize: 16.0,)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      FutureBuilder(
                        future: VenteRepository().countSales(),
                        builder: (context, snapshot) {

                          // if connection is waiting show circular progress indicator
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(color: AppColors.blue));
                          }

                          // if there are one error
                          if (snapshot.hasError) {
                            return Center(
                                child: PrimaryText(text: AppLocalizations.of(context)!.oops));
                          }

                          return Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Container(
                              width: 250,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(16.0)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Icon(Icons.point_of_sale, size: 32, color: AppColors.blue),
                                        SecondaryText(text: "Ventes", color: AppColors.blue)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SecondaryText(text: "${snapshot.data}", color: AppColors.blue, fontSize: 16.0,)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      FutureBuilder(
                        future: ProduitRepository().countProduct(),
                        builder: (context, snapshot) {

                          // if connection is waiting show circular progress indicator
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(color: AppColors.blue));
                          }

                          // if there are one error
                          if (snapshot.hasError) {
                            return Center(
                                child: PrimaryText(text: AppLocalizations.of(context)!.oops));
                          }

                          return Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Container(
                              width: 250,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(16.0)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Icon(FontAwesomeIcons.prescriptionBottleMedical, size: 32, color: AppColors.blue),
                                        SecondaryText(text: "Produits", color: AppColors.blue)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SecondaryText(text: "${snapshot.data}", color: AppColors.blue, fontSize: 16.0,)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      FutureBuilder(
                        future: UtilisateurRepository().countUser(),
                        builder: (context, snapshot) {

                          // if connection is waiting show circular progress indicator
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(color: AppColors.blue));
                          }

                          // if there are one error
                          if (snapshot.hasError) {
                            return Center(
                                child: PrimaryText(text: AppLocalizations.of(context)!.oops));
                          }

                          return Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Container(
                              width: 250,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(16.0)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Icon(FontAwesomeIcons.users, size: 32, color: AppColors.blue),
                                        SecondaryText(text: "Utilisateurs", color: AppColors.blue)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SecondaryText(text: "${snapshot.data}", color: AppColors.blue, fontSize: 16.0,)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      FutureBuilder(
                        future: ProduitRepository().countProduct(),
                        builder: (context, snapshot) {

                          // if connection is waiting show circular progress indicator
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(color: AppColors.blue));
                          }

                          // if there are one error
                          if (snapshot.hasError) {
                            return Center(
                                child: PrimaryText(text: AppLocalizations.of(context)!.oops));
                          }

                          return Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Container(
                              width: 250,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(16.0)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Icon(FontAwesomeIcons.dolly,   size: 32, color: AppColors.blue),
                                        SecondaryText(text: "Commandes", color: AppColors.blue)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: const [
                                        SecondaryText(text: "0", color: AppColors.blue, fontSize: 16.0)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
          ),
          const SizedBox(height: 16.0),
          Expanded(
              flex: 10,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16.0))
                ),
              )
          )
        ])),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blue,
        onPressed: () {
          _refresh();
        },
        child: const Icon(FontAwesomeIcons.refresh, color: AppColors.white, size: 18),
      ),
    );
  }

  /// refresh state
  _refresh() {
    setState(() {});
  }
}
