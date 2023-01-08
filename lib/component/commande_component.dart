import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmacie/model/commande_model.dart';
import 'package:pharmacie/model/detail_commande_model.dart';
import 'package:doc_widget/doc_widget.dart';

import '../model/utilisateur_model.dart';
import '../style/color.dart';
import '../style/text.dart';

@docWidget
class RowCommande extends StatelessWidget {

  // attributes
  final CommandeModel commandeModel;
  final void Function() delete;
  final void Function() pdf;

  const RowCommande(
      {Key? key,
        required this.commandeModel,
        required this.delete,
        required this.pdf})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      surfaceTintColor: AppColors.white,
      elevation: 0,
      child: Column(
        children: [
          ListTile(
            title: SecondaryText(text: commandeModel.fournisseur, color: AppColors.blue),
            subtitle: ThirdText(text: commandeModel.adresseFournisseur.toString()),
            trailing: IconButton(
              onPressed: pdf,
              icon: const Icon(
                  FontAwesomeIcons.filePdf,
                  size: 16,
                  color: AppColors.blue),
            ),
          ),
          const Divider(
              thickness: 1.0,
              endIndent: 13.5,
              indent: 13.5,
              color: AppColors.lightBlue),
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0,
                right: 12.0,
                top: 6.0,
                bottom: 12.0),
            child: SingleChildScrollView(
              child: Row(
                children: [

                  Card(
                    shadowColor: AppColors.blue,
                    surfaceTintColor: AppColors.white,
                    elevation: 0.6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SecondaryText(
                          text: commandeModel.total.toString(),
                          color: AppColors.blue),
                    ),
                  ),

                  Card(
                    shadowColor: AppColors.blue,
                    surfaceTintColor: AppColors.white,
                    elevation: 0.6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SecondaryText(
                          text: commandeModel.date,
                          color: AppColors.blue),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
