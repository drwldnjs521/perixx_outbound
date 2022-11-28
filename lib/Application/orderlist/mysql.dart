import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysql1/mysql1.dart';

class Mysql {
  // Singleton pattern
  static final Mysql _mySql = Mysql._internal();

  factory Mysql() {
    return _mySql;
  }

  Mysql._internal();

  static Mysql get instance => _mySql;

  static late MySqlConnection _connection;

  static MySqlConnection get connection => _connection;

  Future<void> createConnection() async {
    final dbHost = dotenv.env['DB_HOST'];
    final dbUser = dotenv.env['DB_USER'];
    final db = dotenv.env['DB_DATABASE'];
    final pw = dotenv.env['DB_PASSWORD'];
    if (dbHost == null || dbUser == null || db == null || pw == null) {
      throw ArgumentError(
          "Missing configuration value for database (see .env file).");
    }
    _connection = await MySqlConnection.connect(
      ConnectionSettings(
        host: dbHost,
        user: dbUser,
        db: db,
        password: pw,
      ),
    );
  }
}
