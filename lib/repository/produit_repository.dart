
import 'package:mysql1/mysql1.dart';
import 'package:pharmacie/model/produit_model.dart';
import 'package:pharmacie/repository/database.dart';
import 'package:pharmacie/repository/utilisateur_repository.dart';

/// product repository
class ProduitRepository {

  final Database _database = Database();
  final String _table = "produit";


  ProduitRepository();

  // save product
  save({required ProduitModel produitModel}) async {

    String sql =
        "INSERT INTO $_table (nom,prix_unitaire,qte,date_exp) VALUES (?,?,?,?)";

    MySqlConnection connection = await _database.getConnection();

    await connection.query(sql, [
      produitModel.nom,
      produitModel.pu,
      produitModel.qte,
      produitModel.dateExp
    ]);

  }

  // update product
  update({required ProduitModel produitModel}) async {

    String sql =
        "UPDATE $_table SET nom=?,prix_unitaire=?,qte=?,date_exp=? WHERE id=?";

    MySqlConnection connection = await _database.getConnection();

    await connection.query(sql, [
      produitModel.nom,
      produitModel.pu,
      produitModel.qte,
      produitModel.dateExp,
      produitModel.id
    ]);

  }

  // delete product
  delete({required int id}) async {

    String sql = "DELETE FROM $_table WHERE id=?";

    MySqlConnection connection = await _database.getConnection();
    await connection.query(sql, [id]);

  }

  // get all product
  Future<List<ProduitModel>> get() async {

    List<ProduitModel> produitModel = [];
    String sql = "SELECT * FROM $_table ORDER BY $_table.id DESC";

    MySqlConnection connection = await _database.getConnection();
    Results response = await connection.query(sql);

    for (var res in response) {

      produitModel.add(
        ProduitModel.fromJson(res.fields)
      );

    }

    return produitModel;

  }
}