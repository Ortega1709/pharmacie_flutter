import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacie/component/detail_commande_component.dart';
import 'package:pharmacie/model/commande_model.dart';
import 'package:pharmacie/model/detail_commande_model.dart';
import 'package:pharmacie/model/utilisateur_model.dart';
import 'package:pharmacie/repository/commande_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../component/form_field_component.dart';
import '../component/header_dialog_component.dart';
import '../component/search_bar_component.dart';
import '../style/color.dart';
import '../style/text.dart';


class DetailCommandeScreen extends StatefulWidget {

  final UtilisateurModel utilisateurModel;

  const DetailCommandeScreen({Key? key, required this.utilisateurModel}) : super(key: key);

  @override
  State<DetailCommandeScreen> createState() => _DetailCommandeScreenState();
}

class _DetailCommandeScreenState extends State<DetailCommandeScreen> {

  final _formKey = GlobalKey<FormState>();
  late SharedPreferences sharedPreferences;


  // text editing controller item add
  TextEditingController nomController = TextEditingController();
  TextEditingController puController = TextEditingController();
  TextEditingController qteController = TextEditingController();

  // text editing controller order add
  TextEditingController fournisseurController = TextEditingController();
  TextEditingController ad_fournisseurController = TextEditingController();
  TextEditingController num_fournisseurController = TextEditingController();

  // check length list
  List<DetailCommandeModel> check = [];


  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    nomController.dispose();
    puController.dispose();
    qteController.dispose();

    fournisseurController.dispose();
    ad_fournisseurController.dispose();
    num_fournisseurController.dispose();

    super.dispose();
  }

  Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future fetch() async {
    check = (await _showCommande())!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        automaticallyImplyLeading: false,
        title: const PrimaryText(text: "Ajout d' articles de commande"),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back, color: AppColors.blue))),

      // body of screen
      body: Padding(
        padding: const EdgeInsets.only(left: 64.0, right: 64.0, bottom: 32.0),
        child: FutureBuilder(
          future: _showCommande(),
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
                child: PrimaryText(text: AppLocalizations.of(context)!.no_commande))
                : Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                        children: const [
                          SearchBar(hintText: "ex: ortega"),
                          SizedBox(height: 16.0)])),

                Expanded(
                  flex: 8,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return RowDetailCommande(
                        detailCommandeModel: snapshot.data![index],
                        delete: () async {
                          _deleteDialogue(context, index, snapshot.data![index].nom);
                        },
                        more: () async {
                          _updateDialogue(context, index, snapshot.data![index]);
                        },
                      );
                    },
                  ),)
              ],
            );
          },
        ),
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: "btn1",
              backgroundColor: AppColors.blue,
              onPressed: () async {
                setState(() {

                });
              },
              child: const Icon(FontAwesomeIcons.refresh, color: AppColors.white, size: 18)),

          const SizedBox(width: 5),
          FloatingActionButton(
            heroTag: "btn2",
            backgroundColor: AppColors.blue,
            child: const Icon(Icons.add_rounded, color: AppColors.white),
            onPressed: () async {
              _addDialogue(context);
            },
          ),

          const SizedBox(width: 5),
          FloatingActionButton.extended(
            heroTag: "btn3",
            backgroundColor: AppColors.blue,
            onPressed: () async => _confirmCommande(),
            label: SecondaryText(
              text: AppLocalizations.of(context)!.commander,
            ),
          ),
        ],
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  // refresh
  _refresh() async {

    setState(() {
      fetch();
    });

  }

  // add commande
  _addCommende({required DetailCommandeModel detailCommandeModel}) async {

    List<Map<String, dynamic>> detailsMap = [];
    List<DetailCommandeModel>? details = await _showCommande();

    if (details == null) {
      detailsMap.add(detailCommandeModel.toJson());
      sharedPreferences.setString("details", json.encode(detailsMap));
    } else {

      details.add(detailCommandeModel);
      for (var element in details) {
        detailsMap.add(
          element.toJson()
        );
      }
      sharedPreferences.setString("details", json.encode(detailsMap));
    }

  }

  // show commande
  Future<List<DetailCommandeModel>?> _showCommande() async {

    List<DetailCommandeModel> details = [];
    String? dataShared = sharedPreferences.getString("details");

    if (dataShared == null) { return details; }
    else {

      List<dynamic> all = json.decode(dataShared);
      for(var element in all) {
        details.add(
          DetailCommandeModel.fromJson(element)
        );
      }

      return details;
    }
  }

  // show delete
  _deleteCommande({required int id}) async {

    List<Map<String, dynamic>> detailsMap = [];
    List<DetailCommandeModel>? details = await _showCommande();

    if (details == null) {
      
    } else {

      details.removeAt(id);
      for (var element in details) {
        detailsMap.add(
            element.toJson()
        );
      }
      sharedPreferences.setString("details", json.encode(detailsMap));
    }
    
  }

  _updateCommande({required DetailCommandeModel detailCommandeModel, required int id}) async {

    List<Map<String, dynamic>> detailsMap = [];
    List<DetailCommandeModel>? details = await _showCommande();

    if (details == null) {

    } else {

      for (var i = 0; i < details.length; i++) {
        if (i == id) {
          details[i] = DetailCommandeModel(
              nom: detailCommandeModel.nom,
              qte: detailCommandeModel.qte,
              prix: detailCommandeModel.prix,
              total: detailCommandeModel.total);
        }
      }

      for (var element in details) {
        detailsMap.add(
            element.toJson()
        );
      }
      sharedPreferences.setString("details", json.encode(detailsMap));
    }

  }

  // update detail commande
  _updateDialogue(BuildContext context, int id, DetailCommandeModel detailCommandeModel) async {

    List<DetailCommandeModel>? details = await _showCommande();

    nomController.text = details![id].nom;
    puController.text = details![id].prix.toString();
    qteController.text = details![id].qte.toString();


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

                    const SizedBox(height: 16.0),
                    FloatingActionButton.extended(
                      onPressed: () {
                        DetailCommandeModel detailCommandeModel = DetailCommandeModel(
                            nom: nomController.text,
                            qte: int.parse(qteController.text),
                            prix: int.parse(puController.text),
                            total: int.parse(qteController.text) * int.parse(puController.text));

                        _updateCommande(detailCommandeModel: detailCommandeModel, id: id);
                        _clearInput();
                        Navigator.of(context).pop();
                        _infoDialogue(AppLocalizations.of(context)!.modifier_produit); },
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

  // delete detail commande
  _deleteDialogue(BuildContext context, int id, String nom) {

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: HeaderDialog(title: AppLocalizations.of(context)!.supprimer),
          content: SecondaryText(
              text: AppLocalizations.of(context)!.q_ca,
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
                  _deleteCommande(id: id);
                  Navigator.of(context).pop();
                  _infoDialogue(AppLocalizations.of(context)!.confirmation_ac);
                },
                child: SecondaryText(
                    text: AppLocalizations.of(context)!.supprimer,
                    color: AppColors.red))
          ],
        );
      },
    );
  }

  // info dialogue
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
                  _refresh();
                  },
                child: SecondaryText(
                    text: AppLocalizations.of(context)!.d_accord,
                    color: AppColors.blue))
          ],
        );
      },
    );
  }

  // calculate total of items
  _total(List<DetailCommandeModel> detailCommandes) {

    num total = 0;
    for(var items in detailCommandes) {
      total = total + items.total;
    }
    return total;
  }

  // dialogue for confirmation order
  _confirmCommande() {

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: HeaderDialog(title: AppLocalizations.of(context)!.informations),
          content: SecondaryText(
            text: AppLocalizations.of(context)!.confCommande,
              color: AppColors.blue),
          actions: [
            TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  _commanderDialogue(context);
                },
                child: SecondaryText(
                    text: AppLocalizations.of(context)!.oui,
                    color: AppColors.blue))
          ],
        );
      },
    );
  }

  // clear
  _clearInput() {
    nomController.clear();
    puController.clear();
    qteController.clear();
    fournisseurController.clear();
    ad_fournisseurController.clear();
    num_fournisseurController.clear();
  }

  // add dialogue
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

                    const SizedBox(height: 16.0),
                    FloatingActionButton.extended(
                      onPressed: () {
                        DetailCommandeModel detailCommandeModel = DetailCommandeModel(
                            nom: nomController.text,
                            qte: int.parse(qteController.text),
                            prix: int.parse(puController.text),
                            total: int.parse(qteController.text) * int.parse(puController.text));

                        _addCommende(detailCommandeModel: detailCommandeModel);
                        _clearInput();
                        Navigator.of(context).pop();
                        _infoDialogue(AppLocalizations.of(context)!.ajouter_produit); },
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

  // commander dialogue
  _commanderDialogue(BuildContext context) async {

    List<DetailCommandeModel>? items = await _showCommande();
    print(items);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: HeaderDialog(title: AppLocalizations.of(context)!.commander),
          content: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    CostumFormField(
                        hintText: AppLocalizations.of(context)!.nomf,
                        icon: Icons.person,
                        keyboardType: TextInputType.text,
                        controller: fournisseurController),

                    const SizedBox(height: 12.0),
                    CostumFormField(
                        hintText: AppLocalizations.of(context)!.adressef,
                        icon: FontAwesomeIcons.solidAddressBook,
                        keyboardType: TextInputType.number,
                        controller: ad_fournisseurController),

                    const SizedBox(height: 12.0),
                    CostumFormField(
                        hintText: AppLocalizations.of(context)!.numerof,
                        icon: FontAwesomeIcons.phone,
                        keyboardType: TextInputType.number,
                        controller: num_fournisseurController),

                    const SizedBox(height: 16.0),
                    FloatingActionButton.extended(
                      onPressed: () {
                        print(_total(items!));

                        CommandeModel commandeModel = CommandeModel(
                            id: 1,
                            idUtilisateur: widget.utilisateurModel.id,
                            fournisseur: fournisseurController.text,
                            adresseFournisseur: ad_fournisseurController.text,
                            numeroFournisseur: num_fournisseurController.text,
                            total: _total(items!),
                            date: DateFormat("dd-MM-yyyy").format(DateTime.now()));


                        CommandeRepository().save(commandeModel: commandeModel, detailCommandeModel: items);
                        sharedPreferences.remove("details");
                        _clearInput();

                        Navigator.of(context).pop();
                        _infoDialogue(AppLocalizations.of(context)!.commande_p);
                        },
                      backgroundColor: AppColors.blue,
                      label: SecondaryText(text: AppLocalizations.of(context)!.commander),
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
}

