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
  Future<int?> save({required VenteModel venteModel}) async {

    String sql_1 = "INSERT INTO $_table_1 (id_utilisateur,total, qte,date) VALUES (?,?,?,?)";

    MySqlConnection connection = await _database.getConnection();

    // insert data into table vente
    Results response = await connection
        .query(sql_1, [venteModel.idUtilisateur, venteModel.total, venteModel.qte, venteModel.date]);

    return response.insertId;
  }


  // get all sales
  Future<List<VenteModel>> get() async {

    List<VenteModel> venteModel = [];
    String sql = "SELECT * FROM $_table_1 ORDER BY $_table_1.id DESC";

    MySqlConnection connection = await _database.getConnection();
    Results response = await connection.query(sql);

    for(var res in response) {


      venteModel.add(
        VenteModel(
            id: res["id"],
            idUtilisateur: res["id_utilisateur"],
            qte: res["qte"],
            total: res["total"],
            date: res["date"])
      );

    }
    return venteModel;

  }

  // amount of money
  Future<num> amount() async {

    String sql = "SELECT total FROM $_table_1";

    MySqlConnection connection = await _database.getConnection();
    Results response = await connection.query(sql);

    num amount = 0;
    for (var res in response) {
      amount = amount + res["total"];
    }

    return amount;


  }

  // number of sales
  Future<num> countSales() async {

    String sql = "SELECT COUNT(id) as sales FROM $_table_1";

    MySqlConnection connection = await _database.getConnection();
    Results response = await connection.query(sql);

    num number = 0;
    for(var res in response) {
      number = res["sales"];
    }

    return number;

  }

}