

/// detail vente model
class DetailVenteModel {

  /// attributes
  final String idProduit;
  final String idVente;
  final int qte;
  final int total;

  DetailVenteModel({
    required this.idProduit,
    required this.idVente,
    required this.qte,
    required this.total
  });

  /// data toJson
  Map<String, dynamic> toJson() => {
    "id_produit": idProduit,
    "id_vente": idVente,
    "qte": qte,
    "total": total
  };

  /// data fromJson
  factory DetailVenteModel.fromJson(Map<String, dynamic> json) =>

      DetailVenteModel(
          idProduit: json["id_produit"],
          idVente: json["id_vente"],
          qte: json["qte"],
          total: json["total"]);

}