

/// detail vente model
class DetailVenteModel {

  /// attributes
  final int idProduit;
  final int idVente;
  final int qte;

  DetailVenteModel({
    required this.idProduit,
    required this.idVente,
    required this.qte,
  });

  /// data fromJson
  factory DetailVenteModel.fromJson(Map<String, dynamic> json) =>

      DetailVenteModel(
          idProduit: json["id_produit"],
          idVente: json["id_vente"],
          qte: json["qte"]);

}