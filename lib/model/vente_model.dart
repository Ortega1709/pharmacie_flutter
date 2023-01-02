import 'detail_vente_model.dart';

/// vente model
class VenteModel {

  // attributes
  final int id;
  final int idUtilisateur;
  final int total;
  final dynamic date;
  final DetailVenteModel? detailVenteModel;

  VenteModel({
    required this.id,
    required this.idUtilisateur,
    required this.total,
    required this.date,
    required this.detailVenteModel
  });

  // data fromJson
  factory VenteModel.fromJson(Map<String, dynamic> json) => VenteModel(
      id: json["id"],
      idUtilisateur: json["id_utilisateur"],
      total: json["total"],
      date: json["date"],
      detailVenteModel: DetailVenteModel.fromJson(json["detail"]));



}