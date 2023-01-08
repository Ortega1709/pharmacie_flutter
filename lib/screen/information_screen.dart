import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacie/model/utilisateur_model.dart';

import '../component/action_component.dart';
import '../component/row_produit_component.dart';
import '../component/search_bar_component.dart';
import '../model/produit_model.dart';
import '../repository/produit_repository.dart';
import '../style/color.dart';
import '../style/text.dart';

/// information screen
class InformationScreen extends StatefulWidget {

  final UtilisateurModel utilisateurModel;

  const InformationScreen({Key? key, required this.utilisateurModel}) : super(key: key);

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {

  static List<ProduitModel> main = [];
  
  // fetch data
  fetchData() async => main = await ProduitRepository().get();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  // display list
  List<ProduitModel> items = List.from(main);

  void updateList(String value) {
    setState(() {
      items = main.where((item) => item.nom.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: PrimaryText(text: AppLocalizations.of(context)!.informations),
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
                            DataColumn(label: SecondaryText(text: "Nom", color: AppColors.blue, fontWeight: FontWeight.w600), tooltip: "Name of product"),
                            DataColumn(label: SecondaryText(text: "Prix unitaire", color: AppColors.blue, fontWeight: FontWeight.w600), tooltip: "price of product"),
                            DataColumn(label: SecondaryText(text: "Quantité", color: AppColors.blue, fontWeight: FontWeight.w600), tooltip: "Number of product"),
                            DataColumn(label: SecondaryText(text: "Date péremption", color: AppColors.blue, fontWeight: FontWeight.w600), tooltip: ""),
                          ],
                          rows: items.map((item) =>
                              DataRow(cells: [
                                DataCell(SecondaryText(text: item.nom, color: AppColors.blue)),
                                DataCell(SecondaryText(text: item.pu.toString(), color: AppColors.blue)),
                                DataCell(SecondaryText(text: item.qte.toString(), color: AppColors.blue)),
                                DataCell(SecondaryText(text: item.dateExp, color: AppColors.blue)),
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
    fetchData();
    setState(() {});
  }
}
