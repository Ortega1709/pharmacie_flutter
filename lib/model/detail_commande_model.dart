

// detail commande model
class DetailCommandeModel {

  late int? id;
  late int? idCommande;
  late String? nom;
  late int? qte;
  late int? prix;
  late int? total;

  DetailCommandeModel({
    this.id = 0,
    this.idCommande = 0,
    this.nom,
    this.qte,
    this.prix,
    this.total
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