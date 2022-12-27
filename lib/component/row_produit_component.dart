import 'package:flutter/material.dart';

import '../model/produit_model.dart';
import '../style/color.dart';
import '../style/text.dart';

/// row product component
class RowProduit extends StatelessWidget {

  /// attribute
  final ProduitModel produit;
  final void Function() delete;
  final void Function() more;

  const RowProduit({Key? key, required this.produit, required this.delete, required this.more}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      surfaceTintColor: AppColors.white,
      elevation: 0,
      child: Column(
        children: [
          ListTile(
            title: SecondaryText(
              text: produit.nom,
              color: AppColors.blue),
            subtitle: ThirdText(text: produit.pu.toString()),
            trailing: IconButton(
              onPressed: more,
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: AppColors.blue))),

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
                      child: SecondaryText(text: produit.qte.toString(), color: AppColors.blue),
                    ),
                  ),

                  Card(
                    shadowColor: AppColors.blue,
                    surfaceTintColor: AppColors.white,
                    elevation: 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SecondaryText(
                          text: produit.dateExp.toString(),
                          color: AppColors.blue))),

                  Card(
                    shadowColor: AppColors.blue,
                    surfaceTintColor: AppColors.white,
                    elevation: 0.6,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: IconButton(
                        onPressed: delete,
                        icon: const Icon(
                            Icons.delete,
                            size: 18,
                            color: AppColors.blue)))),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
