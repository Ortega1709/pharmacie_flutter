import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacie/component/commande_component.dart';
import 'package:pharmacie/model/detail_commande_model.dart';
import 'package:pharmacie/model/utilisateur_model.dart';
import 'package:pharmacie/screen/detail_commande_screen_old.dart';
import 'package:pharmacie/style/color.dart';

import '../component/search_bar_component.dart';
import '../model/commande_model.dart';
import '../repository/commande_repository.dart';
import '../style/text.dart';

/// commande screen
class CommandeScreen extends StatefulWidget {
  final UtilisateurModel utilisateurModel;

  const CommandeScreen({Key? key, required this.utilisateurModel})
      : super(key: key);

  @override
  State<CommandeScreen> createState() => _CommandeScreenState();
}

class _CommandeScreenState extends State<CommandeScreen> {

  // main list
  List<CommandeModel> main = [];

  fetchData() async {
    main = await CommandeRepository().get();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: PrimaryText(text: AppLocalizations.of(context)!.commandes),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32.0),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    TextField(
                      style: GoogleFonts.inter(color: AppColors.blue),
                      cursorColor: AppColors.blue,
                      /*onChanged: (value) => updateList(value),*/

                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.white,
                        prefixIcon: const Icon(
                            CupertinoIcons.search,
                            color: AppColors.blue),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide.none),
                        hintText: "ex: ibuprofen",
                        hintStyle: GoogleFonts.inter(color: AppColors.grey),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                )),
            Expanded(
                flex: 8,
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16.0))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                          child: DataTable(
                            decoration: const BoxDecoration(
                                color: AppColors.white
                            ),
                            columns: const [
                              DataColumn(label: SecondaryText(text: "Nom", color: AppColors.blue, fontWeight: FontWeight.w600), tooltip: "Name of supplier"),
                              DataColumn(label: SecondaryText(text: "Adresse", color: AppColors.blue, fontWeight: FontWeight.w600), tooltip: "Address of supplier"),
                              DataColumn(label: SecondaryText(text: "Quantité", color: AppColors.blue, fontWeight: FontWeight.w600), tooltip: "Number of product"),
                              DataColumn(label: SecondaryText(text: "Total", color: AppColors.blue, fontWeight: FontWeight.w600), tooltip: "Money"),
                              DataColumn(label: SecondaryText(text: "Date", color: AppColors.blue, fontWeight: FontWeight.w600), tooltip: "Date of order"),
                              DataColumn(label: SecondaryText(text: "Actions", color: AppColors.blue, fontWeight: FontWeight.w600), tooltip: "Actions"),
                            ],
                            rows: main.map((item) =>
                                DataRow(cells: [
                                  DataCell(SecondaryText(text: item.fournisseur, color: AppColors.blue)),
                                  DataCell(SecondaryText(text: item.adresseFournisseur, color: AppColors.blue)),
                                  DataCell(SecondaryText(text: main.length.toString(), color: AppColors.blue)),
                                  DataCell(SecondaryText(text: item.total.toString(), color: AppColors.blue)),
                                  DataCell(SecondaryText(text: item.date, color: AppColors.blue)),
                                  DataCell(
                                      Row(children: [
                                        IconButton(onPressed: () async {}, icon: const Icon(FontAwesomeIcons.solidEye, color: AppColors.blue, size: 18), tooltip: "Voir les détails"),
                                        IconButton(onPressed: () async {}, icon: const Icon(FontAwesomeIcons.solidFilePdf, color: AppColors.blue, size: 18), tooltip: "Génerer un pdf"),
                                      ],)),

                                ])
                            ).toList(),
                          )
                      ),
                    )
                )
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: "btn1",
              backgroundColor: AppColors.blue,
              onPressed: () async {
                _refresh();
              },
              child: const Icon(FontAwesomeIcons.refresh,
                  color: AppColors.white, size: 18)),
          const SizedBox(width: 5),
          FloatingActionButton.extended(
            heroTag: "btn2",
            backgroundColor: AppColors.blue,
            icon: const Icon(Icons.add_rounded, color: AppColors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailCommandeScreen(
                      utilisateurModel: widget.utilisateurModel)));
            },
            label: SecondaryText(
              text: AppLocalizations.of(context)!.ajouter,
            ),
          ),
        ],
      ),
    );
  }

  /// refresh state
  _refresh() {
    setState(() {});
  }
}
