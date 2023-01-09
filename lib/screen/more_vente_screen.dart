import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmacie/model/vente_model.dart';
import 'package:pharmacie/repository/detail_vente_repository.dart';

import '../model/detail_vente_model.dart';
import '../style/color.dart';
import '../style/text.dart';


class MoreVenteScreen extends StatefulWidget {
  final VenteModel venteModel;
  const MoreVenteScreen({Key? key, required this.venteModel}) : super(key: key);

  @override
  State<MoreVenteScreen> createState() => _MoreVenteScreenState();
}

class _MoreVenteScreenState extends State<MoreVenteScreen> {

  List<DetailVenteModel> items = [];

  fetchData() async => items = await DetailVenteRepository().get(id: widget.venteModel.id);

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.background,
          title: PrimaryText(text: "Details vente")),

      /// body of screen
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32.0),
        child: Column(
          children: [
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
                              DataColumn(label: SecondaryText(text: "#", color: AppColors.blue, fontWeight: FontWeight.w600), tooltip: "id of details"),
                              DataColumn(label: SecondaryText(text: "#produit", color: AppColors.blue, fontWeight: FontWeight.w600), tooltip: "id of product"),
                              DataColumn(label: SecondaryText(text: "Quantité", color: AppColors.blue, fontWeight: FontWeight.w600), tooltip: "Number of product")],
                            rows: items.map((item) =>
                                DataRow(cells: [
                                  DataCell(SecondaryText(text: item.id.toString(), color: AppColors.blue)),
                                  DataCell(SecondaryText(text: item.idProduit.toString(), color: AppColors.blue)),
                                  DataCell(SecondaryText(text: item.qte.toString(), color: AppColors.blue)),
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

      /// floating action buttons
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              backgroundColor: AppColors.blue,
              heroTag: "btn2",
              onPressed: () {
                setState(() {

                });
              },
              child: const Icon(FontAwesomeIcons.refresh, color: AppColors.white, size: 18)),
        ],
      ),
    );
  }
}
