
import 'package:intl/intl.dart';

/// vente model
class VenteModel {

  /// attributes
  final String idUtilisateur;
  final int total;
  final dynamic date;

  VenteModel({
    required this.idUtilisateur,
    required this.total,
    required this.date
  });

  /// data toJson
  Map<String, dynamic> toJson() => {
    "id_utilisateur": idUtilisateur,
    "total": total,
    "date": date
  };

  /// data fromJson
  factory VenteModel.fromJson(Map<String, dynamic> json) => VenteModel(
      idUtilisateur: json["id_utilisateur"],
      total: json["total"],
      date: json["date"].toString());

}