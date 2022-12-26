import 'package:flutter/material.dart';
import 'package:pharmacie/style/color.dart';
import 'package:pharmacie/style/text.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../component/form_field_component.dart';

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

                            /*List<Document> documents =
                            await UtilisateurRepository().get();

                            final data = documents
                                .map((e) => Utilisateur.fromJson(e.map))
                                .toList();

                            for (int i = 0; i < data.length; i++) {
                              if (data[i].email == emailController.text.trim() &&
                                  BCrypt.checkpw(passwordController.text.trim(),
                                      data[i].mdp)) {
                                emailController.clear();
                                passwordController.clear();

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        MainScreen(utilisateur: data[i])));

                                setState(() {
                                  isLoading = false;
                                });

                                return;
                              }
                            }

                            setState(() {
                              isLoading = false;
                            });*/

                            //banner("Erreur d'authentification");
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
}
