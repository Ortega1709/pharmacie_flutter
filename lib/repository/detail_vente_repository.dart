

// detail vente repository
import 'package:mysql1/mysql1.dart';
import 'package:pharmacie/model/detail_vente_model.dart';
import 'package:pharmacie/repository/database.dart';

class DetailVenteRepository {

  final Database _database = Database();
  final String _table_1 = "detail_vente";
  final String _table_2 = "produit";

  // save detail vente
  save({required DetailVenteModel detailVenteModel, required int reste}) async {

    String sql_1 = "INSERT INTO $_table_1 (id_produit,id_vente,qte) VALUES (?,?,?)";
    String sql_2 = "UPDATE $_table_2 SET qte=? WHERE id=?";

    MySqlConnection connection = await _database.getConnection();
    await connection.query(sql_1,
        [detailVenteModel.idProduit, detailVenteModel.idVente, detailVenteModel.qte]);

    await connection.query(sql_2, [reste, detailVenteModel.idProduit]);
  }

  // get all detail vente model
  Future<List<DetailVenteModel>> get({required int id}) async {

    String sql = "SELECT * FROM $_table_1 WHERE $_table_1.id_vente = ?";
    MySqlConnection connection = await _database.getConnection();

    List<DetailVenteModel> items = [];
    Results responses = await connection.query(sql, [id]);

    for (var response in responses) {
      items.add(
        DetailVenteModel.fromJson(response.fields)
      );
    }

    return items;
  }

}