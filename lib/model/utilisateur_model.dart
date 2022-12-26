import 'package:bcrypt/bcrypt.dart';

/// utilisateur model
class UtilisateurModel {
  late String nom;
  late String email;
  late String mdp;
  late String type;

  UtilisateurModel(
      {required this.nom,
        required this.email,
        required this.mdp,
        required this.type});

  /// data toJson
  Map<String, dynamic> toJson() => {
    "nom": nom,
    "email": email,
    "mdp": BCrypt.hashpw(mdp, BCrypt.gensalt()),
    "type": type
  };

  /// data fromJson
  factory UtilisateurModel.fromJson(Map<String, dynamic> json) => UtilisateurModel(
      nom: json["nom"],
      email: json["email"],
      mdp: json["mdp"],
      type: json["type"]);
}