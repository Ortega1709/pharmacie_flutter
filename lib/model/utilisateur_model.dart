import 'package:bcrypt/bcrypt.dart';

/// utilisateur model
class UtilisateurModel {
  final int id;
  final String nom;
  final String email;
  final String mdp;
  final String type;

  UtilisateurModel(
      {
        required this.id,
        required this.nom,
        required this.email,
        required this.mdp,
        required this.type});


  /// data fromJson
  factory UtilisateurModel.fromJson(Map<dynamic, dynamic> json) => UtilisateurModel(
      id: json["id"],
      nom: json["nom"],
      email: json["email"],
      mdp: json["mdp"],
      type: json["type"]);
}