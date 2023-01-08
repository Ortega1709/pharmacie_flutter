
// action repository
import 'package:mysql1/mysql1.dart';
import 'package:pharmacie/model/action_model.dart';
import 'package:pharmacie/repository/database.dart';
import 'package:pharmacie/utils/custom_date.dart';

import '../utils/custom_actions.dart';

class ActionRepository {

  final Database _database = Database();
  final String _table = "action";

  ActionRepository();

  // save action
  save({required ActionModel actionModel}) async {
    String sql = "INSERT INTO $_table (email, action, date) VALUES (?,?,?)";
    MySqlConnection connection = await _database.getConnection();

    await connection.query(
        sql, [actionModel.email, actionModel.action, actionModel.date]);
  }

  // get all
  get() async {
    String sql = "SELECT * FROM $_table ORDER BY $_table.id DESC";
    MySqlConnection connection = await _database.getConnection();

    Results responses = await connection.query(sql);
    List<ActionModel> actionsModels = [];

    for (var response in responses) {
      actionsModels.add(
          ActionModel(
              id: response["id"],
              email: response["email"],
              action: response["action"],
              date: response["date"])
      );
    }

    return actionsModels;
  }

}