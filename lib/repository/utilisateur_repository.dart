import 'dart:async';

import 'package:bcrypt/bcrypt.dart';
import 'package:mysql1/mysql1.dart';
import 'package:pharmacie/model/utilisateur_model.dart';
import 'package:pharmacie/repository/database.dart';


/// user repository
class UtilisateurRepository {

  final Database _database = Database();
  final String _table = "utilisateur";

  UtilisateurRepository();

  // save user
  save({required UtilisateurModel utilisateurModel}) async {

    String sql =
        "INSERT INTO $_table (nom,email,mdp,type) VALUES (?,?,?,?)";

    MySqlConnection connection = await _database.getConnection();

    await connection.query(sql, [
      utilisateurModel.nom,
      utilisateurModel.email,
      BCrypt.hashpw(utilisateurModel.mdp, BCrypt.gensalt()),
      utilisateurModel.type
    ]);

  }

  // update user
  update({required UtilisateurModel utilisateurModel}) async {

    String sql =
        "UPDATE $_table SET nom=?,email=?,mdp=?,type=? WHERE id=?";

    MySqlConnection connection = await _database.getConnection();

    await connection.query(sql, [
      utilisateurModel.nom,
      utilisateurModel.email,
      BCrypt.hashpw(utilisateurModel.mdp, BCrypt.gensalt()),
      utilisateurModel.type,
      utilisateurModel.id
    ]);

  }

  // delete user
  delete({required int id}) async {

    String sql = "DELETE FROM $_table WHERE id=?";

    MySqlConnection connection = await _database.getConnection();
    await connection.query(sql, [id]);

  }


  // get all user
  Future<List<UtilisateurModel>> get() async {

    List<UtilisateurModel> users = [];
    String sql = "SELECT * FROM $_table ORDER BY $_table.id DESC";

    MySqlConnection connection = await _database.getConnection();
    Results response = await connection.query(sql);

    for (var res in response) {

      users.add(
        UtilisateurModel.fromJson(res.fields)
      );

    }
    return users;

  }

  // authentication
  Future<UtilisateurModel?> authentication({required String email, required String mdp}) async {

    String sql = "SELECT * FROM $_table WHERE email = ?";

    MySqlConnection connection = await _database.getConnection();
    Results response = await connection.query(sql, [email]);

    for (var res in response) {

      if (BCrypt.checkpw(mdp, res["mdp"]) == true) {

        return UtilisateurModel.fromJson(res.fields);

      }

    }

    return null;

  }
}




