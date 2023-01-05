
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
  late List<DetailCommandeModel>? detailCommandeModel;

  // constructor
  CommandeModel({
    this.id,
    this.idUtilisateur,
    this.fournisseur,
    this.adresseFournisseur,
    this.numeroFournisseur,
    this.total,
    this.detailCommandeModel,
    this.date
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