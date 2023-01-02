import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmacie/component/row_vente_component.dart';
import 'package:pharmacie/model/utilisateur_model.dart';
import 'package:pharmacie/repository/vente_repository.dart';
import '../component/row_utilisateur_component.dart';
import '../component/search_bar_component.dart';
import '../style/color.dart';
import '../style/text.dart';

/// vente screen
class VenteScreen extends StatefulWidget {

  final UtilisateurModel utilisateurModel;

  const VenteScreen({Key? key, required this.utilisateurModel}) : super(key: key);

  @override
  State<VenteScreen> createState() => _VenteScreenState();
}

class _VenteScreenState extends State<VenteScreen> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: PrimaryText(text: AppLocalizations.of(context)!.ventes)),

      /// body of screen
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32.0),
        child: FutureBuilder(
          future: VenteRepository().get(),
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
                child: PrimaryText(text: AppLocalizations.of(context)!.no_vente))
                : Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                        children: const [
                          SearchBar(hintText: "ex: 2020"),
                          SizedBox(height: 16.0)])),

                Expanded(
                  flex: 8,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return RowVente(
                          venteModel: snapshot.data![index],
                          more: () {});
                    },
                  ),)
              ],
            );
          },
        ),
      ),

      /// floating action buttons
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: AppColors.blue,
            onPressed: () {
              _refresh();
            },
            child: const Icon(FontAwesomeIcons.refresh, color: AppColors.white, size: 18),
          ),
        ],
      )
    );
  }

  /// refresh state
  _refresh() {
    setState(() {});
  }

  /// methode


}
