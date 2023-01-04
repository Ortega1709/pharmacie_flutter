

// commande repository
import 'package:mysql1/mysql1.dart';
import 'package:pharmacie/model/detail_commande_model.dart';
import 'package:pharmacie/repository/database.dart';

import '../model/commande_model.dart';

class CommandeRepository {

  final Database _database = Database();
  final String _table_1 = "commande";
  final String _table_2 = "detail_commande";

  CommandeRepository();

  // save commande
  save({required CommandeModel commandeModel, required List<DetailCommandeModel> detailCommandeModel}) async {

    // query to insert data into commande table
    String sql = "INSERT INTO $_table_1 (id_utilisateur, fournisseur, adresse_fournisseur, numero_fournisseur, total, date) VALUES (?,?,?,?,?,?)";

    // query to insert data into detail_commande table
    String sql_1 = "INSERT INTO $_table_2 (id_commande, nom, qte, prix, total) VALUES (?,?,?,?,?)";

    // connection to mysql database
    MySqlConnection connection = await _database.getConnection();

    // execute query (insert data into commande table first)
    Results response = await connection.query(sql, [
      commandeModel.idUtilisateur,
      commandeModel.fournisseur,
      commandeModel.adresseFournisseur,
      commandeModel.numeroFournisseur,
      commandeModel.detailCommandeModel?.total,
      commandeModel.date
    ]);

    // execute the second query (insert data into detail_commande table)
    for (var items in detailCommandeModel) {
      await connection.query(sql_1, [
        response.insertId,
        items.nom,
        items.qte,
        items.prix,
        items.total
      ]);
    }
  }

  // get all orders in database
  Future<List<CommandeModel>?> get() async {

    return null;

  }

}