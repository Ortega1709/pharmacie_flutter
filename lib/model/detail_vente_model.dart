

/// detail vente model
class DetailVenteModel {

  /// attributes
  int idProduit;
  String? produit;
  int? total;
  int? reste;
  int idVente;
  int qte;

  DetailVenteModel({
    required this.idProduit,
    this.produit,
    this.total,
    this.reste,
    required this.idVente,
    required this.qte,
  });

  // data toJson
  Map<String, dynamic> toJson() => {
    "id_produit": idProduit,
    "id_vente": idVente,
    "qte": qte,
  };

  // data fromJson
  factory DetailVenteModel.fromJson(Map<String, dynamic> json) =>

      DetailVenteModel(
          idProduit: json["id_produit"],
          idVente: json["id_vente"],
          qte: json["qte"]);

}