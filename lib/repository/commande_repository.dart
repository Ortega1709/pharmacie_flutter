

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
      commandeModel.total,
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
  Future<List<CommandeModel>> get() async {

    // query
    String sql = "SELECT * FROM $_table_1";
    String sql_1 = "SELECT * FROM $_table_2 WHERE id_commande=?";

    // connection to database
    MySqlConnection connection = await _database.getConnection();
    // execution of query
    Results responses = await connection.query(sql);

    // commande model
    CommandeModel commandeModel = CommandeModel();

    // detail commande model
    DetailCommandeModel detailCommandeModel = DetailCommandeModel();

    // list of commande model
    List<CommandeModel> commandeModels = [];

    // list of detail commande model
    List<DetailCommandeModel> detailCommandeModels = [];

    for (var response in responses) {
      commandeModel.id = response.fields["id"];
      commandeModel.idUtilisateur = response.fields["id_utilisateur"];
      commandeModel.fournisseur = response.fields["fournisseur"];
      commandeModel.adresseFournisseur = response.fields["adresse_fournisseur"];
      commandeModel.numeroFournisseur = response.fields["numero_fournisseur"];
      commandeModel.total = response.fields["total"];
      commandeModel.date = response.fields["date"];

      // execute the second query
      Results responses2 = await connection.query(sql_1, [response.fields["id"]]);
      for (var response2 in responses2) {

        detailCommandeModel.id = response2.fields["id"];
        detailCommandeModel.idCommande = response2.fields["id_commande"];
        detailCommandeModel.nom = response2.fields["nom"];
        detailCommandeModel.qte = response2.fields["qte"];
        detailCommandeModel.prix = response2.fields["prix"];
        detailCommandeModel.total = response2.fields["total"];

        // add detail commande model to the list
        detailCommandeModels.add(detailCommandeModel);

      }

      commandeModel.detailCommandeModel = detailCommandeModels;
      // add commande model to the list
      commandeModels.add(commandeModel);
    }

    return commandeModels;

  }

}
