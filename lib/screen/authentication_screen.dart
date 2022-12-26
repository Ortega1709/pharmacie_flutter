import 'package:flutter/material.dart';
import 'package:pharmacie/style/color.dart';
import 'package:pharmacie/style/text.dart';

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
            children: const [

              /// header of login
              PrimaryText(text: "Bienvenue !", fontSize: 30),
              SecondaryText(
                  text:  "Authentifiez-vous afin d'accéder à l'interface d'accueil",
                  fontSize: 17,
                  color: AppColors.blue),

            ],
          ),
        ),
      ),
    );
  }
}
