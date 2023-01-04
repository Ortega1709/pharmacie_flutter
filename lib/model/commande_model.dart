
import 'package:pharmacie/model/detail_commande_model.dart';

// commande model
class CommandeModel {

  final int id;
  final int idUtilisateur;
  final String fournisseur; // name of supplier
  final String adresseFournisseur;
  final String numeroFournisseur;
  final String date;
  final int total;
  final DetailCommandeModel? detailCommandeModel;

  // constructor
  CommandeModel({
    required this.id,
    required this.idUtilisateur,
    required this.fournisseur,
    required this.adresseFournisseur,
    required this.numeroFournisseur,
    required this.total,
    this.detailCommandeModel,
    required this.date
  });

  // toJson
  Map<String, dynamic> toJson() => {
    "id": id,
    "id_utilisateur": idUtilisateur,
    "fournisseur": fournisseur,
    "adresse_fournisseur": adresseFournisseur,
    "numero_fournisseur": numeroFournisseur,
    "total": total,
    "detail_commande": DetailCommandeModel(nom: '', qte: 0, prix: 0, total: 0).toJson()
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