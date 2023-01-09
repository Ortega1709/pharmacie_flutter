import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final formKey = GlobalKey<FormState>();
  bool passwordVisible = false;

  /// text controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    passwordVisible = false;
    super.initState();
  }

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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Entrer une adresse";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      obscureText: passwordVisible,
                      controller: passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: GoogleFonts.inter(color: AppColors.blue),
                      cursorColor: AppColors.blue,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.white,
                        prefixIcon: const Icon(
                          Icons.lock_rounded,
                          color: AppColors.blue,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(FontAwesomeIcons.solidEye,
                              size: 19, color: AppColors.blue),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide.none),
                        hintText: AppLocalizations.of(context)!.mdp,
                        hintStyle: GoogleFonts.inter(color: AppColors.grey),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Entrer un mot de passe";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (isLoading) return;
                              setState(() {
                                isLoading = true;
                              });

                              UtilisateurModel? utilisateur =
                                  await UtilisateurRepository().authentication(
                                      email: emailController.text,
                                      mdp: passwordController.text);

                              if (utilisateur != null) {
                                switch (utilisateur.type) {
                                  case "médecin":
                                    ActionRepository().save(
                                        actionModel: ActionModel(
                                            id: 0,
                                            email: utilisateur.email,
                                            action: CustomActions.connexion,
                                            date: CustomDate.now()));
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainScreenMedecin(
                                                    utilisateurModel:
                                                        utilisateur)));
                                    _initialize();
                                    break;
                                  case "pharmacien":
                                    ActionRepository().save(
                                        actionModel: ActionModel(
                                            id: 0,
                                            email: utilisateur.email,
                                            action: CustomActions.connexion,
                                            date: CustomDate.now()));
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainScreenPharmacie(
                                                    utilisateurModel:
                                                        utilisateur)));
                                    _initialize();
                                    break;
                                  case "admin":
                                    ActionRepository().save(
                                        actionModel: ActionModel(
                                            id: 0,
                                            email: utilisateur.email,
                                            action: CustomActions.connexion,
                                            date: CustomDate.now()));
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainScreenAdmin(
                                                    utilisateurModel:
                                                        utilisateur)));
                                    _initialize();
                                    break;
                                }
                              } else {
                                setState(() {
                                  isLoading = false;
                                });

                                /// if user not exist, return message
                                _banner(
                                    AppLocalizations.of(context)!.erreur_au);
                              }
                            } else {
                              _banner("Veuillez entrer les informations");
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
