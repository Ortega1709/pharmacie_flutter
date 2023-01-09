import 'package:flutter/material.dart';
import 'package:pharmacie/model/action_model.dart';
import 'package:pharmacie/model/utilisateur_model.dart';
import 'package:pharmacie/repository/action_repository.dart';
import 'package:pharmacie/repository/utilisateur_repository.dart';
import 'package:pharmacie/screen/main_screen_medecin.dart';
import 'package:pharmacie/screen/main_screen_pharmacien.dart';
import 'package:pharmacie/style/color.dart';
import 'package:pharmacie/style/text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pharmacie/utils/custom_actions.dart';
import 'package:pharmacie/utils/custom_date.dart';

import '../component/form_field_component.dart';
import 'main_screen_admin.dart';

/// authentication screen.
class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {

  /// boolean for circular indicator
  bool isLoading = false;
  final formKey = GlobalKey<State>();

  /// text controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      /// body of screen 
      body: Center(
        child: AlertDialog(
          backgroundColor: AppColors.background,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// header of login
              PrimaryText(
                  text: AppLocalizations.of(context)!.bienvenue, fontSize: 30),
              SecondaryText(
                  text: AppLocalizations.of(context)!.authentification,
                  fontSize: 17,
                  color: AppColors.blue),
            ],
          ),
          /// body of login
          content: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12.0),
                    CostumFormField(
                      hintText: AppLocalizations.of(context)!.email,
                      icon: Icons.email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    const SizedBox(height: 12.0),
                    CostumFormField(
                      hintText: AppLocalizations.of(context)!.mdp,
                      icon: Icons.lock_rounded,
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          onPressed: () async {
                            if (isLoading) return;
                            setState(() {
                              isLoading = true;
                            });


                            UtilisateurModel? utilisateur = await UtilisateurRepository()
                                .authentication(email: emailController.text, mdp: passwordController.text);

                            if (utilisateur != null) {
                              switch(utilisateur.type) {
                                case "médecin":
                                  _initialize();
                                  ActionRepository().save(actionModel: ActionModel(
                                      id: 0,
                                      email: utilisateur.email,
                                      action: CustomActions.connexion,
                                      date: CustomDate.now()));
                                  Navigator
                                      .of(context)
                                      .push(MaterialPageRoute(builder: (context) => MainScreenMedecin(utilisateurModel: utilisateur)));
                                  break;
                                case "pharmacien":
                                  _initialize();
                                  ActionRepository().save(actionModel: ActionModel(
                                      id: 0,
                                      email: utilisateur.email,
                                      action: CustomActions.connexion,
                                      date: CustomDate.now()));
                                  Navigator
                                      .of(context)
                                    .push(MaterialPageRoute(builder: (context) => MainScreenPharmacie(utilisateurModel: utilisateur)));
                                  break;
                                case "admin":
                                  _initialize();
                                  ActionRepository().save(actionModel: ActionModel(
                                      id: 0,
                                      email: utilisateur.email,
                                      action: CustomActions.connexion,
                                      date: CustomDate.now()));
                                  Navigator
                                  .of(context)
                                  .push(MaterialPageRoute(builder: (context) => MainScreenAdmin(utilisateurModel: utilisateur)));
                                  break;
                              }

                            } else {

                              setState(() {
                                isLoading = false;
                              });

                              /// if user not exist, return message
                              _banner(AppLocalizations.of(context)!.erreur_au);

                            }

                          },
                          backgroundColor: AppColors.blue,
                          child: isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : const Icon(
                            Icons.east_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// initialize
  _initialize() {

    emailController.clear();
    passwordController.clear();

    setState(() {
      isLoading = false;
    });

  }

  /// message banner
  _banner(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 5,
        backgroundColor: AppColors.blue,
        dismissDirection: DismissDirection.horizontal,
        content: ListTile(
          dense: true,
          title: SecondaryText(text: text),
          trailing: IconButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
