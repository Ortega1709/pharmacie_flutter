import 'package:mysql1/mysql1.dart';

/// database class [connection to mysql]
class Database {

  static String host = "localhost";
  static String user = "ortega";
  static String password = "observateur17092002";
  static String db = "pharmacie";
  static int port = 3306;

  Database();

  Future<MySqlConnection> getConnection() async {

    // settings for connection to database mysql
    var settings = ConnectionSettings(
      host: host,
      user: user,
      password: password,
      db: db,
      port: port
    );

    // return connection to database
    return await MySqlConnection.connect(settings);
  }
}

