
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmacie/model/utilisateur_model.dart';
import 'package:pharmacie/style/text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../component/header_dialog_component.dart';
import '../model/action_model.dart';
import '../repository/action_repository.dart';
import '../style/color.dart';
import '../utils/custom_actions.dart';
import '../utils/custom_date.dart';

class SettingsScreen extends StatefulWidget {

  final UtilisateurModel utilisateurModel;

  const SettingsScreen({Key? key, required this.utilisateurModel}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          height: 600,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(16.0))
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    flex: 0,
                    child: ListTile(
                      leading: ProfilePicture(name: widget.utilisateurModel.nom, radius: 31, fontsize: 15, tooltip: true),
                      title: SecondaryText(text: widget.utilisateurModel.email, color: AppColors.blue, fontWeight: FontWeight.w700),
                      subtitle: SecondaryText(text: widget.utilisateurModel.type, color: AppColors.blue, fontSize: 15),
                    )),
                Expanded(
                    flex: 5,
                    child: Column(
                      children: [],
                    )),
                Expanded(
                    flex: 0,
                    child: FloatingActionButton(
                      backgroundColor: AppColors.blue,
                      child: const SecondaryText(text: "Déconnexion"),
                      onPressed: () async {
                        ActionRepository().save(actionModel: ActionModel(
                            id: 0,
                            email: widget.utilisateurModel.email,
                            action: CustomActions.deconnexion,
                            date: CustomDate.now()));
                        Navigator.of(context).pop();
                      }
                    )
                ),

                const SizedBox(height: 10.0),
                const Center(child: ThirdText(text: "version 1.0", color: AppColors.grey))
              ],
            ),
          ),
        ),
      )
    );
  }

}


