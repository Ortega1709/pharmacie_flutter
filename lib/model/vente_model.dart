import 'detail_vente_model.dart';

/// vente model
class VenteModel {

  // attributes
  int id;
  int idUtilisateur;
  int total;
  int qte;
  dynamic date;
  DetailVenteModel? detailVenteModel;

  VenteModel({
    required this.id,
    required this.idUtilisateur,
    required this.total,
    required this.qte,
    required this.date,
    this.detailVenteModel
  });

  // data fromJson
  factory VenteModel.fromJson(Map<String, dynamic> json) => VenteModel(
      id: json["id"],
      idUtilisateur: json["id_utilisateur"],
      total: json["total"],
      qte: json["qte"],
      date: json["date"]);



}