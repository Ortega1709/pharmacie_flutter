import 'package:bcrypt/bcrypt.dart';

/// utilisateur model
class UtilisateurModel {
  int id;
  String nom;
  String email;
  String mdp;
  String type;

  UtilisateurModel(
      {
        required this.id,
        required this.nom,
        required this.email,
        required this.mdp,
        required this.type});


  /// data fromJson
  factory UtilisateurModel.fromJson(Map<String, dynamic> json) => UtilisateurModel(
      id: json["id"],
      nom: json["nom"],
      email: json["email"],
      mdp: json["mdp"],
      type: json["type"]);
}