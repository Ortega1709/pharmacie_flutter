import 'package:mysql1/mysql1.dart';
import 'package:pharmacie/model/detail_vente_model.dart';
import 'package:pharmacie/model/vente_model.dart';
import 'package:pharmacie/repository/database.dart';

import '../model/produit_model.dart';

/// vente repository
class VenteRepository {

  final Database _database = Database();
  final String _table_1 = "vente";
  final String _table_2 = "detail_vente";
  final String _table_3 = "produit";

  VenteRepository();


  // create sale
  create({required VenteModel venteModel, required int rest}) async {

    String sql_1 = "INSERT INTO $_table_1 (id_utilisateur,total,date) VALUES (?,?,?)";
    String sql_2 = "INSERT INTO $_table_2 (id_produit,id_vente,qte) VALUES (?,?,?)";
    String sql_3 = "UPDATE $_table_3 SET qte=? WHERE id=?";

    MySqlConnection connection = await _database.getConnection();

    // insert data into table vente
    Results response = await connection
        .query(sql_1, [venteModel.idUtilisateur, venteModel.total, venteModel.date]);

    // insert data into table detail_vente
    await connection.query(sql_2, [venteModel.detailVenteModel?.idProduit, response.insertId, venteModel.detailVenteModel?.qte]);

    // reduce the quantity of the product in stock
    await connection.query(sql_3, [rest, venteModel.detailVenteModel?.idProduit]);
  }


  // get all sales
  Future<List<VenteModel>> get() async {

    List<VenteModel> venteModel = [];
    String sql = "SELECT * FROM $_table_1, $_table_2 WHERE $_table_2.id_vente = $_table_1.id";

    MySqlConnection connection = await _database.getConnection();
    Results response = await connection.query(sql);

    for(var res in response) {

      // create map for sale detail
      Map<String, dynamic> detail = {
        "id_produit": res["id_produit"],
        "id_vente": res["id_vente"],
        "qte": res["qte"]
      };

      venteModel.add(
        VenteModel(
            id: res["id"],
            idUtilisateur: res["id_utilisateur"],
            total: res["total"],
            date: res["date"],
            detailVenteModel: DetailVenteModel.fromJson(detail))
      );

    }
    return venteModel;

  }

}
