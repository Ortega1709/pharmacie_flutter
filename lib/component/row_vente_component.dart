import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacie/model/vente_model.dart';

import '../model/utilisateur_model.dart';
import '../style/color.dart';
import '../style/text.dart';

/// row user component
class RowVente extends StatelessWidget {

  /// attributes
  final VenteModel venteModel;
  final void Function() more;

  const RowVente(
      {Key? key,
        required this.venteModel, required this.more})
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
            title: SecondaryText(text: "ID-${venteModel.id}", color: AppColors.blue),
            subtitle: ThirdText(text: "${venteModel.total} fc"),
            trailing: IconButton(
              onPressed: more,
              icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
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
                          text: venteModel.date,
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
                          text: venteModel.detailVenteModel?.qte.toString(),
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
    ;
  }
}