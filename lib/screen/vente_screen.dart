import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacie/component/row_vente_component.dart';
import 'package:pharmacie/model/utilisateur_model.dart';
import 'package:pharmacie/repository/vente_repository.dart';
import 'package:pharmacie/screen/detail_vente_screen.dart';
import '../component/header_dialog_component.dart';
import '../component/search_bar_component.dart';
import '../model/produit_model.dart';
import '../model/vente_model.dart';
import '../style/color.dart';
import '../style/text.dart';

/// vente screen
class VenteScreen extends StatefulWidget {

  final UtilisateurModel utilisateurModel;
  const VenteScreen({Key? key, required this.utilisateurModel}) : super(key: key);

  @override
  State<VenteScreen> createState() => _VenteScreenState();
}

class _VenteScreenState extends State<VenteScreen> {

  static List<VenteModel> main = [];

  // fetch data
  fetchData() async => main = await VenteRepository().get();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  // display list
  List<VenteModel> items = List.from(main);

  void updateList(String value) {
    setState(() {
      items = main.where((item) => item.date.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: PrimaryText(text: AppLocalizations.of(context)!.ventes)),

      /// body of screen
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
                      onChanged: (value) => updateList(value),
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
                              DataColumn(label: SecondaryText(text: "Vente", color: AppColors.blue, fontWeight: FontWeight.w600), tooltip: "Name of sale"),
                              DataColumn(label: SecondaryText(text: "Total", color: AppColors.blue, fontWeight: FontWeight.w600), tooltip: "Total of sale"),
                              DataColumn(label: SecondaryText(text: "Quantité", color: AppColors.blue, fontWeight: FontWeight.w600), tooltip: "Number of sale"),
                              DataColumn(label: SecondaryText(text: "Date", color: AppColors.blue, fontWeight: FontWeight.w600), tooltip: "Date of sale"),
                              DataColumn(label: SecondaryText(text: "Actions", color: AppColors.blue, fontWeight: FontWeight.w600), tooltip: "Actions"),
                            ],
                            rows: main.map((item) =>
                                DataRow(cells: [
                                  DataCell(SecondaryText(text: item.id.toString(), color: AppColors.blue)),
                                  DataCell(SecondaryText(text: "${item.total.toString()} fc", color: AppColors.blue)),
                                  DataCell(SecondaryText(text: item.qte.toString(), color: AppColors.blue)),
                                  DataCell(SecondaryText(text: item.date, color: AppColors.blue)),
                                  DataCell(
                                      Row(children: [
                                        IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.solidEye, color: AppColors.blue, size: 18), tooltip: "Voir détails"),
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

      /// floating action buttons
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              backgroundColor: AppColors.blue,
              heroTag: "btn2",
              onPressed: () {
                _refresh();
              },
              child: const Icon(FontAwesomeIcons.refresh, color: AppColors.white, size: 18)),

          const SizedBox(width: 5),
          FloatingActionButton.extended(
            backgroundColor: AppColors.blue,
            heroTag: "btn3",
            icon: const Icon(Icons.add_rounded, color: AppColors.white),
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DetailVenteScreen(utilisateurModel: widget.utilisateurModel))
              );
            },
            label: SecondaryText(
              text: AppLocalizations.of(context)!.ajouter,
            ),
          ),
        ],
      ),
    );
  }

  _vendreDialog(ProduitModel produitModel) async {

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: HeaderDialog(title: AppLocalizations.of(context)!.vente),
          content: SizedBox(
            width: 400,
            child: Container()
          ),
        );
      },
    );
  }

  /// refresh state
  _refresh() {
    setState(() {});
  }

  /// methode


}
