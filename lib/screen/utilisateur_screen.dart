import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacie/model/utilisateur_model.dart';
import 'package:pharmacie/repository/utilisateur_repository.dart';

import '../component/form_field_component.dart';
import '../component/header_dialog_component.dart';
import '../component/row_utilisateur_component.dart';
import '../component/search_bar_component.dart';
import '../style/color.dart';
import '../style/text.dart';

/// utilisateur screen
class UtilisateurScreen extends StatefulWidget {

  final UtilisateurModel utilisateurModel;

  const UtilisateurScreen({Key? key, required this.utilisateurModel}) : super(key: key);

  @override
  State<UtilisateurScreen> createState() => _UtilisateurScreenState();
}

class _UtilisateurScreenState extends State<UtilisateurScreen> {

  /// form key
  final _formKey = GlobalKey<FormState>();

  /// main list product

  /// text form controllers
  TextEditingController nomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// initialize it with retrieved data

  @override
  void dispose() {

    /// free space for our controllers
    nomController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: PrimaryText(text: AppLocalizations.of(context)!.utilisateurs),
      ),

      /// body of screen
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32.0),
        child: FutureBuilder(
          future: UtilisateurRepository().get(),
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
              child: PrimaryText(text: AppLocalizations.of(context)!.no_user))
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
                            return RowUtilisateur(
                              utilisateur: snapshot.data![index],
                              delete: () async {
                                _deleteDialogue(context, snapshot.data![index].id, snapshot.data![index].email);
                              },
                              more: () async {
                                _updateDialogue(context, snapshot.data![index].id, snapshot.data![index]);
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
            backgroundColor: AppColors.blue,
            onPressed: () async {
              _refresh();
            },
            child: const Icon(FontAwesomeIcons.refresh, color: AppColors.white, size: 18)),

          const SizedBox(width: 5),
          FloatingActionButton.extended(
            backgroundColor: AppColors.blue,
            icon: const Icon(
              Icons.add_rounded,
              color: AppColors.white),
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

    /// default selected value for the dropdown
    String? currentSelectedValue = "médecin";

    /// options for the dropdown
    final options = ["admin", "médecin", "pharmacien"];

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: HeaderDialog(title: AppLocalizations.of(context)!.utilisateur),
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
                      icon: Icons.person_rounded,
                      keyboardType: TextInputType.text,
                      controller: nomController),

                    const SizedBox(height: 12.0),
                    CostumFormField(
                      hintText: AppLocalizations.of(context)!.email,
                      icon: Icons.email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController),

                    const SizedBox(height: 12.0),
                    CostumFormField(
                      hintText: AppLocalizations.of(context)!.mdp,
                      icon: Icons.lock_rounded,
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController),

                    const SizedBox(height: 12.0),
                    FormField(builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.white,
                          prefixIcon: const Icon(
                            Icons.admin_panel_settings_rounded,
                            color: AppColors.blue),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: BorderSide.none),
                          hintText: AppLocalizations.of(context)!.type_utilisateur,
                          hintStyle: GoogleFonts.inter(color: AppColors.grey)),

                        isEmpty: currentSelectedValue == "",
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: currentSelectedValue,
                            isDense: true,
                            onChanged: (newValue) {
                              setState(() {
                                currentSelectedValue = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: options.map((e) {
                              return DropdownMenuItem(
                                  value: e,
                                  child: SecondaryText(
                                      text: e, color: AppColors.blue));
                            }).toList(),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 16.0),
                    FloatingActionButton.extended(
                      onPressed: () async {
                        UtilisateurModel data = UtilisateurModel(
                            id: 0,
                            nom: nomController.text.trim(),
                            email: emailController.text.toLowerCase().trim(),
                            mdp: passwordController.text.trim(),
                            type: currentSelectedValue!);

                        UtilisateurRepository().save(utilisateurModel: data);
                        _clearInput();
                        Navigator.of(context).pop();
                        _infoDialogue(AppLocalizations.of(context)!.ajouter_utilisateur);

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
  _updateDialogue(BuildContext context, int id, UtilisateurModel utilisateur) {

    /// initialize our controllers with retrieved data
    nomController.text = utilisateur.nom;
    emailController.text = utilisateur.email;
    passwordController.clear();
    String? currentSelectedValue = utilisateur.type;

    final options = ["admin", "médecin", "pharmacien"];

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: HeaderDialog(title: AppLocalizations.of(context)!.modifier),
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
                      icon: Icons.person_rounded,
                      keyboardType: TextInputType.text,
                      controller: nomController),

                    const SizedBox(height: 12.0),
                    CostumFormField(
                      hintText: AppLocalizations.of(context)!.email,
                      icon: Icons.email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController),

                    const SizedBox(height: 12.0),
                    CostumFormField(
                      hintText: AppLocalizations.of(context)!.mdp,
                      icon: Icons.lock_rounded,
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController),

                    const SizedBox(height: 12.0),
                    FormField(builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.white,
                          prefixIcon: const Icon(
                            Icons.admin_panel_settings_rounded,
                            color: AppColors.blue),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: BorderSide.none),
                          hintText: AppLocalizations.of(context)!.type_utilisateur,
                          hintStyle: GoogleFonts.inter(color: AppColors.grey),
                        ),

                        isEmpty: currentSelectedValue == "",
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: currentSelectedValue,
                            isDense: true,
                            onChanged: (newValue) {
                              setState(() {
                                currentSelectedValue = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: options.map((e) {
                              return DropdownMenuItem(
                                  value: e,
                                  child: SecondaryText(
                                      text: e, color: AppColors.blue));
                            }).toList(),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 16.0),
                    FloatingActionButton.extended(
                      onPressed: () async {
                        UtilisateurModel data = UtilisateurModel(
                            id: id,
                            nom: nomController.text.trim(),
                            email: emailController.text.toLowerCase().trim(),
                            mdp: passwordController.text.trim(),
                            type: currentSelectedValue!);

                        UtilisateurRepository().update(utilisateurModel: data);
                        _clearInput();
                        Navigator.of(context).pop();
                        _infoDialogue(AppLocalizations.of(context)!.modifier_utilisateur);
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
  _deleteDialogue(BuildContext context, int id, String email) {

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: HeaderDialog(title: AppLocalizations.of(context)!.supprimer),
          content: SecondaryText(
            text: "${AppLocalizations.of(context)!.confirmation} $email",
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
                UtilisateurRepository().delete(id: id);
                Navigator.of(context).pop();
                _infoDialogue(AppLocalizations.of(context)!.supprimer_utilisateur);
              },
              child: SecondaryText(
                text: AppLocalizations.of(context)!.supprimer,
                color: AppColors.red))
          ],
        );
      },
    );
  }

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
                color: AppColors.blue))
          ],
        );
      },
    );
  }

  /// methode
  _clearInput() {
    nomController.clear();
    emailController.clear();
    passwordController.clear();
  }


}
