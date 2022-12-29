import 'package:pharmacie/model/utilisateur_model.dart';
import 'package:pharmacie/repository/database.dart';



/// utilisateur repository
class UtilisateurRepository {

  /// instance of database class
  final Database _database = Database();
  final String _table = "utilisateur";

  /// save user
  save({required UtilisateurModel utilisateurModel}) {



  }

  /// get all user in database
  get() async {


    String sql = "SELECT * FROM $_table";

    await _database.getConnection().then((connection) async {
      await connection.query(sql).then((results) {
        for (var result in results) {
          print(result);
        }
      }).onError((error, stackTrace) {
        print(error);
        return null;
      });

      connection.close();

    });

  }
}

void main() {

  UtilisateurRepository().get();

}