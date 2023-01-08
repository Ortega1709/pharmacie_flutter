
import 'package:pharmacie/model/detail_commande_model.dart';

// commande model
class CommandeModel {

  late int? id;
  late int? idUtilisateur;
  late String? fournisseur; // name of supplier
  late String? adresseFournisseur;
  late String? numeroFournisseur;
  late String? date;
  late int? total;

  // constructor
  CommandeModel({
    this.id,
    this.idUtilisateur,
    this.fournisseur,
    this.adresseFournisseur,
    this.numeroFournisseur,
    this.total,
    this.date
  });


  // toJson
  Map<String, dynamic> toJson() => {
    "id": id,
    "id_utilisateur": idUtilisateur,
    "fournisseur": fournisseur,
    "adresse_fournisseur": adresseFournisseur,
    "numero_fournisseur": numeroFournisseur,
    "date": date,
    "total": total
  };

  // fromJson
  factory CommandeModel.fromJson(Map<String, dynamic> json) => CommandeModel(
      id: json["id"],
      idUtilisateur: json["id_utilisateur"],
      fournisseur: json["fournisseur"],
      adresseFournisseur: json["adresse_fournisseur"],
      numeroFournisseur: json["numero_fournisseur"],
      total: json["total"],
      date: json["date"]);

}