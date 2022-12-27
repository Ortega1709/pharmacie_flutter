

/// product model
class ProduitModel {

  final String nom;
  final int pu;
  final int qte;
  final dynamic dateExp;

  ProduitModel({
    required this.nom,
    required this.pu,
    required this.qte,
    required this.dateExp});

  /// data toJson
  Map<String, dynamic> toJson() => {
    "nom": nom,
    "pu": pu,
    "qte": qte,
    "dateExp": dateExp
  };

  /// data fromJson
  factory ProduitModel.fromJson(Map<String, dynamic> json) => ProduitModel(
      nom: json["nom"] ?? "",
      pu: json["pu"] ?? 0,
      qte: json["qte"] ?? 0,
      dateExp: json["dateExp"].toString());

}