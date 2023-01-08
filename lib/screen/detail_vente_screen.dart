import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacie/model/action_model.dart';
import 'package:pharmacie/model/detail_vente_model.dart';
import 'package:pharmacie/model/utilisateur_model.dart';
import 'package:pharmacie/model/vente_model.dart';
import 'package:pharmacie/repository/action_repository.dart';
import 'package:pharmacie/repository/detail_vente_repository.dart';
import 'package:pharmacie/repository/produit_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pharmacie/repository/vente_repository.dart';
import 'package:pharmacie/utils/custom_actions.dart';
import 'package:pharmacie/utils/custom_date.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/form_field_component.dart';
import '../component/form_field_number_component.dart';
import '../component/header_dialog_component.dart';
import '../model/produit_model.dart';
import '../style/color.dart';
import '../style/text.dart';

class DetailVenteScreen extends StatefulWidget {
  final UtilisateurModel utilisateurModel;

  const DetailVenteScreen({Key? key, required this.utilisateurModel})
      : super(key: key);

  @override
  State<DetailVenteScreen> createState() => _DetailVenteScreenState();
}

class _DetailVenteScreenState extends State<DetailVenteScreen> {
  // key form
  final _formKey = GlobalKey<FormState>();
  late SharedPreferences sharedPreferences;

  // main list product
  static List<ProduitModel> main = [];

  // main list product for sale
  List<DetailVenteModel> mainSale = [];

  fetchData() async {
    main = await ProduitRepository().get();
  }

  // controllers
  TextEditingController nomController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController montantController = TextEditingController();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  // list update
  List<ProduitModel> displayList = List.from(main);

  @override
  void dispose() {
    super.dispose();
  }

  // update list
  void updateList(String value) {
    setState(() {
      displayList = main
          .where((item) => item.nom.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.transparent,
          automaticallyImplyLeading: false,
          title: const PrimaryText(text: "Ajout d' articles de vente"),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back, color: AppColors.blue))),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              TextField(
                                style: GoogleFonts.inter(color: AppColors.blue),
                                cursorColor: AppColors.blue,
                                onChanged: (value) => updateList(value),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.background,
                                  prefixIcon: const Icon(CupertinoIcons.search,
                                      color: AppColors.blue),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      borderSide: BorderSide.none),
                                  hintText: "ex: ibuprofen",
                                  hintStyle:
                                  GoogleFonts.inter(color: AppColors.grey),
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                        flex: 25,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                              color: AppColors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              child: DataTable(
                                decoration:
                                const BoxDecoration(color: AppColors.white),
                                columns: const [
                                  DataColumn(
                                      label: SecondaryText(
                                          text: "Nom",
                                          color: AppColors.blue,
                                          fontWeight: FontWeight.w600),
                                      tooltip: "Name of product"),
                                  DataColumn(
                                      label: SecondaryText(
                                          text: "Prix unitaire",
                                          color: AppColors.blue,
                                          fontWeight: FontWeight.w600),
                                      tooltip: "price of product"),
                                  DataColumn(
                                      label: SecondaryText(
                                          text: "Quantité",
                                          color: AppColors.blue,
                                          fontWeight: FontWeight.w600),
                                      tooltip: "Number of product"),
                                  DataColumn(
                                      label: SecondaryText(
                                          text: "Date péremption",
                                          color: AppColors.blue,
                                          fontWeight: FontWeight.w600),
                                      tooltip: "Peremption date"),
                                  DataColumn(
                                      label: SecondaryText(
                                          text: "Actions",
                                          color: AppColors.blue,
                                          fontWeight: FontWeight.w600),
                                      tooltip: "Actions"),
                                ],
                                rows: displayList
                                    .map(
                                      (item) =>
                                      DataRow(cells: [
                                        DataCell(SecondaryText(
                                            text: item.nom,
                                            color: AppColors.blue)),
                                        DataCell(SecondaryText(
                                            text: item.pu.toString(),
                                            color: AppColors.blue)),
                                        DataCell(SecondaryText(
                                            text: item.qte.toString(),
                                            color: AppColors.blue)),
                                        DataCell(SecondaryText(
                                            text: item.dateExp,
                                            color: AppColors.blue)),
                                        DataCell(
                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: item.qte == 0
                                                      ? null
                                                      : () async =>
                                                      _vendreDialog(item),
                                                  icon: const Icon(
                                                      FontAwesomeIcons
                                                          .cashRegister,
                                                      color: AppColors.blue,
                                                      size: 18),
                                                  tooltip: "Vendre"),
                                            ],
                                          ),
                                        ),
                                      ]),
                                )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15.0),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 25,
                          child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SingleChildScrollView(
                                    child: DataTable(
                                      decoration: const BoxDecoration(
                                          color: AppColors.white),
                                      columns: const [
                                        DataColumn(
                                            label: SecondaryText(
                                                text: "Nom",
                                                color: AppColors.blue,
                                                fontWeight: FontWeight.w600),
                                            tooltip: "Name of product"),
                                        DataColumn(
                                            label: SecondaryText(
                                                text: "Quantité",
                                                color: AppColors.blue,
                                                fontWeight: FontWeight.w600),
                                            tooltip: "Number  of product"),
                                        DataColumn(
                                            label: SecondaryText(
                                                text: "Total",
                                                color: AppColors.blue,
                                                fontWeight: FontWeight.w600),
                                            tooltip: "Total of product"),
                                        DataColumn(
                                            label: SecondaryText(
                                                text: "Actions",
                                                color: AppColors.blue,
                                                fontWeight: FontWeight.w600),
                                            tooltip: "Actions"),
                                      ],
                                      rows: mainSale
                                          .map((item) =>
                                          DataRow(cells: [
                                            DataCell(SecondaryText(
                                                text: item.produit,
                                                color: AppColors.blue)),
                                            DataCell(SecondaryText(
                                                text: item.qte.toString(),
                                                color: AppColors.blue)),
                                            DataCell(SecondaryText(
                                                text: item.total.toString(),
                                                color: AppColors.blue)),
                                            DataCell(Row(children: [
                                              IconButton(
                                                  onPressed: () async {
                                                    mainSale.removeAt(
                                                        mainSale.indexOf(item));
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                      FontAwesomeIcons.trash,
                                                      color: AppColors.blue,
                                                      size: 18),
                                                  tooltip: "Supprimer"),
                                            ])),
                                          ]))
                                          .toList(),
                                    )),
                              ))),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: "btn4",
              backgroundColor: AppColors.blue,
              onPressed: () async {
                setState(() {});
              },
              child: const Icon(FontAwesomeIcons.refresh,
                  color: AppColors.white, size: 18)),
          const SizedBox(width: 5),
          FloatingActionButton.extended(
            heroTag: "btn3",
            backgroundColor: AppColors.blue,
            onPressed: mainSale.isEmpty
                ? null
                : () async {
              _vente();
            },
            label: const SecondaryText(
              text: "Vendre",
            ),
          ),
        ],
      ),
    );
  }

  _vendreDialog(ProduitModel produitModel) async {
    nomController.text = produitModel.nom;
    montantController.text = produitModel.pu.toString();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: HeaderDialog(title: AppLocalizations.of(context)!.vente),
          content: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CostumFormField(
                      hintText: '',
                      icon: Icons.vaccines,
                      keyboardType: TextInputType.text,
                      controller: nomController,
                    ),
                    const SizedBox(height: 16.0),
                    FormFieldNumber(
                        max: produitModel.qte,
                        controller: numberController,
                        montant: produitModel.pu,
                        montantController: montantController),
                    const SizedBox(height: 16.0),
                    FloatingActionButton.extended(
                      onPressed: () async {
                        mainSale.add(DetailVenteModel(
                            idProduit: produitModel.id,
                            produit: produitModel.nom,
                            idVente: 0,
                            reste: produitModel.qte -
                                int.parse(numberController.text),
                            qte: int.parse(numberController.text),
                            total: int.parse(numberController.text) *
                                produitModel.pu));

                        setState(() {});

                        Navigator.of(context).pop();
                      },
                      backgroundColor: AppColors.blue,
                      label: SecondaryText(
                          text: AppLocalizations.of(context)!.vendre),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // vente
  _vente() async {
    final id = await VenteRepository().save(
        venteModel: VenteModel(
            id: 0,
            idUtilisateur: widget.utilisateurModel.id,
            total: totalPrice(),
            qte: mainSale.length,
            date: CustomDate.now(),
            detailVenteModel: null));

    for (var dVente in mainSale) {
      await DetailVenteRepository().save(
          detailVenteModel: DetailVenteModel(
              idProduit: dVente.idProduit,
              idVente: id!,
              qte: dVente.qte),
          reste: dVente.reste!);
    }

    mainSale.clear();
    ActionRepository().save(actionModel: ActionModel(id: 0,
        email: widget.utilisateurModel.email,
        action: CustomActions.vente,
        date: CustomDate.now()));
    setState(() {});
  }

  // total price
  int totalPrice() {
    int total = 0;
    for (var value in mainSale) {
      total += value.total!;
    }

    return total;
  }
}
