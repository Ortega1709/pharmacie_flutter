

/// product model
class ProduitModel {

  int id;
  String nom;
  int pu;
  int qte;
  dynamic dateExp;

  ProduitModel({
    required this.id,
    required this.nom,
    required this.pu,
    required this.qte,
    required this.dateExp});

  factory ProduitModel.fromJson(Map<String, dynamic> json) => ProduitModel(
      id: json["id"],
      nom: json["nom"],
      pu: json["prix_unitaire"],
      qte: json["qte"],
      dateExp: json["date_exp"]);

  @override
  String toString() {
    return 'ProduitModel{id: $id, nom: $nom, pu: $pu, qte: $qte, dateExp: $dateExp}';
  }

}