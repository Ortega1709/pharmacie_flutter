/// detail vente model
class DetailVenteModel {
  /// attributes
  int? id;
  int idProduit;
  String? produit;
  int? total;
  int? reste;
  int idVente;
  int qte;

  DetailVenteModel({
    required this.idProduit,
    this.id,
    this.produit,
    this.total,
    this.reste,
    required this.idVente,
    required this.qte,
  });

  // data toJson
  Map<String, dynamic> toJson() => {
        "id": id,
        "id_produit": idProduit,
        "id_vente": idVente,
        "qte": qte,
      };

  // data fromJson
  factory DetailVenteModel.fromJson(Map<String, dynamic> json) =>
      DetailVenteModel(
          id: json["id"],
          idProduit: json["id_produit"],
          idVente: json["id_vente"],
          qte: json["qte"]);
}
