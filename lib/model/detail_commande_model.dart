

// detail commande model
class DetailCommandeModel {

  final int id;
  final int idCommande;
  late final String nom;
  final int qte;
  final int prix;
  final int total;

  DetailCommandeModel({
    this.id = 0,
    this.idCommande = 0,
    required this.nom,
    required this.qte,
    required this.prix,
    required this.total
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_commande": idCommande,
    "nom": nom,
    "qte": qte,
    "prix": prix,
    "total": total
  };

  factory DetailCommandeModel.fromJson(Map<String, dynamic> json) =>

      DetailCommandeModel(
        id: json["id"],
        idCommande: json["id_commande"],
        nom: json["nom"],
        qte: json["qte"],
        prix: json["prix"],
        total: json["total"]
      );


}