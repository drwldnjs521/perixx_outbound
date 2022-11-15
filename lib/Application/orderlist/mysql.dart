import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysql1/mysql1.dart';

class Mysql {
  static Future<MySqlConnection> getConnection() async {
    return await MySqlConnection.connect(
      ConnectionSettings(
        host: dotenv.env['DB_HOST']!,
        user: dotenv.env['DB_USER']!,
        db: dotenv.env['DB_DATABASE']!,
        password: dotenv.env['DB_PASSWORD']!,
      ),
    );
  }
}
