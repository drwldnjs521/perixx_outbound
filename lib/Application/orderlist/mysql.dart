import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysql1/mysql1.dart';

class Mysql {
  static Future<MySqlConnection> getConnection() async {
    return await MySqlConnection.connect(
      ConnectionSettings(
        host: dotenv.env['DB_HOST']!,
        port: int.parse(dotenv.env['DB_PORT']!),
        user: dotenv.env['DB_USER']!,
        db: dotenv.env['DB_Database'],
        password: dotenv.env['DB_PASSWORD']!,
      ),
    );
  }
}
