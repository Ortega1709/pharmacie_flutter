import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacie/component/row_produit_component.dart';import 'package:intl/intl.dart';
import 'package:pharmacie/model/detail_vente_model.dart';
import 'package:pharmacie/model/vente_model.dart';
import 'package:pharmacie/repository/produit_repository.dart';
import 'package:pharmacie/repository/vente_repository.dart';

import '../component/form_field_component.dart';
import '../component/form_field_number_component.dart';
import '../component/header_dialog_component.dart';
import '../component/search_bar_component.dart';
import '../model/produit_model.dart';
import '../model/utilisateur_model.dart';
import '../style/color.dart';
import '../style/text.dart';

/// produit screen
class ProduitScreen extends StatefulWidget {

  final UtilisateurModel utilisateurModel;

  const ProduitScreen({Key? key, required this.utilisateurModel}) : super(key: key);

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
  /// controllers
  TextEditingController numberController = TextEditingController();
  TextEditingController montantController = TextEditingController();

  @override
  void dispose() {

    /// free space for our controllers
    nomController.dispose();
    puController.dispose();
    qteController.dispose();
    dateExpController.dispose();
    numberController.dispose();
    montantController.dispose();
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
          future: ProduitRepository().get(),
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

            return snapshot.data!.isEmpty
                ? Center(
                child: PrimaryText(text: AppLocalizations.of(context)!.no_produit))
                : Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: const [
                            SearchBar(hintText: "ex: ibuprofen"),
                            SizedBox(height: 16.0),
                      ],
                    )),
                    Expanded(
                      flex: 8,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return RowProduit(
                            produit: snapshot.data![index],
                            delete: () async {
                              _deleteDialogue(context, snapshot.data![index].id, snapshot.data![index].nom);
                            },
                            more: () async {
                              _updateDialogue(context, snapshot.data![index].id, snapshot.data![index]);
                            },
                            vente: snapshot.data![index].qte == 0 ? null : () async {
                              _vendreDialog(snapshot.data![index]);
                            },
                          );
                        },
                      ),
                    ),
                  ],
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
              child: const Icon(FontAwesomeIcons.refresh, color: AppColors.white, size: 18)),

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
                            id: 0,
                            nom: nomController.text.trim(),
                            pu: int.parse(puController.text),
                            qte: int.parse(qteController.text),
                            dateExp: dateExpController.text.toString());

                        ProduitRepository().save(produitModel: data);
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
  _updateDialogue(BuildContext context, int id, ProduitModel produitModel) {

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
                            id: id,
                            nom: nomController.text.trim(),
                            pu: int.parse(puController.text),
                            qte: int.parse(qteController.text),
                            dateExp: dateExpController.text.toString());

                        ProduitRepository().update(produitModel: data);
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
  _deleteDialogue(BuildContext context, int id, String nom) {

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
                  ProduitRepository().delete(id: id);
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

  /// methode
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
                    FormFieldNumber(max: produitModel.qte, controller: numberController, montant: produitModel.pu, montantController: montantController),

                    const SizedBox(height: 16.0),
                    FloatingActionButton.extended(
                      onPressed: () async {

                        // rest of the initial quantity - the quantity inserted
                        int reste = produitModel.qte - int.parse(numberController.text);
                        
                        // create model of detail vante
                        DetailVenteModel detailVenteModel = DetailVenteModel(
                            idProduit: produitModel.id, 
                            idVente: 0, 
                            qte: int.parse(numberController.text));

                        // create model of vente
                        VenteModel venteModel = VenteModel(
                            id: 0, 
                            idUtilisateur: widget.utilisateurModel.id, 
                            total: int.parse(montantController.text),
                            date: DateFormat("dd-MM-yyyy").format(DateTime.now()),
                            detailVenteModel: detailVenteModel);

                        VenteRepository().create(venteModel: venteModel, rest: reste);
                        Navigator.of(context).pop();
                        _infoDialogue(AppLocalizations.of(context)!.vendre_produit);

                      },
                      backgroundColor: AppColors.blue,
                      label: SecondaryText(text: AppLocalizations.of(context)!.vendre),
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

  /// clear methode
  _clearInput() {
    nomController.clear();
    qteController.clear();
    puController.clear();
    dateExpController.clear();
  }
}
