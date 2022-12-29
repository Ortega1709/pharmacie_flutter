import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacie/component/row_produit_component.dart';import 'package:intl/intl.dart';

import '../component/form_field_component.dart';
import '../component/header_dialog_component.dart';
import '../component/search_bar_component.dart';
import '../model/produit_model.dart';
import '../style/color.dart';
import '../style/text.dart';

/// produit screen
class ProduitScreen extends StatefulWidget {
  const ProduitScreen({Key? key}) : super(key: key);

  @override
  State<ProduitScreen> createState() => _ProduitScreenState();
}

class _ProduitScreenState extends State<ProduitScreen> {

  /// form key
  final _formKey = GlobalKey<FormState>();

  /// text form controllers
  TextEditingController nomController = TextEditingController();
  TextEditingController puController = TextEditingController();
  TextEditingController qteController = TextEditingController();
  TextEditingController dateExpController = TextEditingController();

  @override
  void dispose() {

    /// free space for our controllers
    nomController.dispose();
    puController.dispose();
    qteController.dispose();
    dateExpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: PrimaryText(text: AppLocalizations.of(context)!.produits)),

      /// body of screen
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32.0),
        child: FutureBuilder(
          future: null,
          builder: (context, snapshot) {

            /// if connection is waiting show circular progress indicator
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: AppColors.blue));
            }

            /// if there are one error
            if (snapshot.hasError) {
              return Center(
                  child: PrimaryText(text: AppLocalizations.of(context)!.oops));
            }

            return true
                ? Center(
                child: PrimaryText(text: AppLocalizations.of(context)!.no_user))
                : SingleChildScrollView(
              child: Column(
                children: [
                  const SearchBar(hintText: "ex: ibuprofen"),
                  const SizedBox(height: 16.0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return RowProduit(
                        produit: ProduitModel(nom: "", pu: 4, qte: 4, dateExp: ""),
                        delete: () async {
                        },
                        more: () async {

                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              backgroundColor: AppColors.blue,
              onPressed: () async {
                _refresh();
              },
              child: const Icon(Icons.refresh, color: AppColors.white)),

          const SizedBox(width: 5),
          FloatingActionButton.extended(
            backgroundColor: AppColors.blue,
            icon: const Icon(Icons.add_rounded, color: AppColors.white),
            onPressed: () async {
              _addDialogue(context);
            },
            label: SecondaryText(
              text: AppLocalizations.of(context)!.ajouter,
            ),
          ),
        ],
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  /// refresh state
  _refresh() {
    setState(() {});
  }

  /// methode
  _addDialogue(BuildContext context) {

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: HeaderDialog(title: AppLocalizations.of(context)!.produit),
          content: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    CostumFormField(
                        hintText: AppLocalizations.of(context)!.nom,
                        icon: Icons.vaccines,
                        keyboardType: TextInputType.text,
                        controller: nomController),

                    const SizedBox(height: 12.0),
                    CostumFormField(
                        hintText: AppLocalizations.of(context)!.prix,
                        icon: Icons.price_change,
                        keyboardType: TextInputType.number,
                        controller: puController),

                    const SizedBox(height: 12.0),
                    CostumFormField(
                        hintText: AppLocalizations.of(context)!.qte,
                        icon: Icons.storage,
                        keyboardType: TextInputType.number,
                        controller: qteController),

                    const SizedBox(height: 12.0),

                    /// date form field
                   TextFormField(
                     controller: dateExpController,
                     style: GoogleFonts.inter(color: AppColors.blue),
                     cursorColor: AppColors.blue,
                     keyboardType: TextInputType.datetime,
                     readOnly: true,
                     onTap: () async {

                       DateTime? pickedDate = await showDatePicker(
                           context: context,
                           keyboardType: TextInputType.datetime,
                           initialDate: DateTime.now(),
                           firstDate: DateTime(DateTime.now().year),
                           lastDate: DateTime(3000));

                       /// check if date isn't null
                       if (pickedDate != null) {
                         setState(() {
                           dateExpController.text = DateFormat("dd-MM-yyyy")
                               .format(pickedDate);
                         });
                       }
                     },

                     decoration: InputDecoration(
                       filled: true,
                       fillColor: AppColors.white,
                       prefixIcon: const Icon(Icons.date_range, color: AppColors.blue),
                       border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(16.0),
                           borderSide: BorderSide.none),
                       hintText: AppLocalizations.of(context)!.date,
                       hintStyle: GoogleFonts.inter(color: AppColors.grey))),

                    const SizedBox(height: 16.0),
                    FloatingActionButton.extended(
                      onPressed: () async {
                        ProduitModel data = ProduitModel(
                            nom: nomController.text.trim(),
                            pu: int.parse(puController.text),
                            qte: int.parse(qteController.text),
                            dateExp: dateExpController.text.toString());

                        //ProduitRepository().save(produitModel: data);
                        _clearInput();
                        Navigator.of(context).pop();
                        _infoDialogue(AppLocalizations.of(context)!.ajouter_produit);

                      },
                      backgroundColor: AppColors.blue,
                      label: SecondaryText(text: AppLocalizations.of(context)!.enregistrer),
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

  /// methode
  _infoDialogue(String msg) {

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: HeaderDialog(title: AppLocalizations.of(context)!.informations),
          content: SecondaryText(
              text: msg,
              color: AppColors.blue),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                setState(() {});
              },
              child: SecondaryText(
                  text: AppLocalizations.of(context)!.d_accord,
                  color: AppColors.blue),
            )
          ],
        );
      },
    );
  }

  /// methode
  _updateDialogue(BuildContext context, String id, ProduitModel produitModel) {

    /// initialize our controllers with retrieved data
    nomController.text = produitModel.nom;
    puController.text = produitModel.pu.toString();
    qteController.text = produitModel.qte.toString();
    dateExpController.text = produitModel.dateExp;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: HeaderDialog(title: AppLocalizations.of(context)!.produit),
          content: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    CostumFormField(
                        hintText: AppLocalizations.of(context)!.nom,
                        icon: Icons.vaccines,
                        keyboardType: TextInputType.text,
                        controller: nomController),

                    const SizedBox(height: 12.0),
                    CostumFormField(
                        hintText: AppLocalizations.of(context)!.prix,
                        icon: Icons.price_change,
                        keyboardType: TextInputType.number,
                        controller: puController),

                    const SizedBox(height: 12.0),
                    CostumFormField(
                        hintText: AppLocalizations.of(context)!.qte,
                        icon: Icons.storage,
                        keyboardType: TextInputType.number,
                        controller: qteController),

                    const SizedBox(height: 12.0),

                    /// date form field
                    TextFormField(
                        controller: dateExpController,
                        style: GoogleFonts.inter(color: AppColors.blue),
                        cursorColor: AppColors.blue,
                        keyboardType: TextInputType.datetime,
                        readOnly: true,
                        onTap: () async {

                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              keyboardType: TextInputType.datetime,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year),
                              lastDate: DateTime(3000));

                          /// check if date isn't null
                          if (pickedDate != null) {
                            setState(() {
                              dateExpController.text = DateFormat("dd-MM-yyyy")
                                  .format(pickedDate);
                            });
                          }
                        },

                        decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.white,
                            prefixIcon: const Icon(Icons.date_range, color: AppColors.blue),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide.none),
                            hintText: AppLocalizations.of(context)!.date,
                            hintStyle: GoogleFonts.inter(color: AppColors.grey))),

                    const SizedBox(height: 16.0),
                    FloatingActionButton.extended(
                      onPressed: () async {
                        ProduitModel data = ProduitModel(
                            nom: nomController.text.trim(),
                            pu: int.parse(puController.text),
                            qte: int.parse(qteController.text),
                            dateExp: dateExpController.text.toString());

                        //ProduitRepository().update(id: id, produitModel: data);
                        _clearInput();
                        Navigator.of(context).pop();
                        _infoDialogue(AppLocalizations.of(context)!.modifier_produit);

                      },
                      backgroundColor: AppColors.blue,
                      label: SecondaryText(text: AppLocalizations.of(context)!.modifier),
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

  /// methode
  _deleteDialogue(BuildContext context, String id, String nom) {

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: HeaderDialog(title: AppLocalizations.of(context)!.supprimer),
          content: SecondaryText(
              text: "${AppLocalizations.of(context)!.confirmation_p} $nom",
              color: AppColors.blue),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: SecondaryText(text: AppLocalizations.of(context)!.annuler, color: AppColors.blue),
            ),
            TextButton(
                onPressed: () async {
                  //ProduitRepository().delete(id: id);
                  Navigator.of(context).pop();
                  _infoDialogue(AppLocalizations.of(context)!.supprimer_produit);
                },
                child: SecondaryText(
                    text: AppLocalizations.of(context)!.supprimer,
                    color: AppColors.red))
          ],
        );
      },
    );
  }

  /// clear methode
  _clearInput() {
    nomController.clear();
    qteController.clear();
    puController.clear();
    dateExpController.clear();
  }
}
