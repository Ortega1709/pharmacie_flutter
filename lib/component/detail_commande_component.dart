import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacie/model/detail_commande_model.dart';
import 'package:doc_widget/doc_widget.dart';

import '../model/utilisateur_model.dart';
import '../style/color.dart';
import '../style/text.dart';

@docWidget
class RowDetailCommande extends StatelessWidget {

  // attributes
  final DetailCommandeModel detailCommandeModel;
  final void Function() delete;
  final void Function() more;

  const RowDetailCommande(
      {Key? key,
        required this.detailCommandeModel,
        required this.delete,
        required this.more})
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
            title: SecondaryText(text: detailCommandeModel.nom, color: AppColors.blue),
            subtitle: ThirdText(text: detailCommandeModel.prix.toString()),
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
                          text: detailCommandeModel.qte.toString(),
                          color: AppColors.blue),
                    ),
                  ),

                  Card(
                    shadowColor: AppColors.blue,
                    surfaceTintColor: AppColors.white,
                    elevation: 0.6,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: IconButton(
                        onPressed: delete,
                        icon: const Icon(
                            CupertinoIcons.delete,
                            size: 18,
                            color: AppColors.blue),
                      ),
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
