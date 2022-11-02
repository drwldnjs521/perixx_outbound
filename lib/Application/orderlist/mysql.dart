import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysql_client/mysql_client.dart';

class Mysql {
  static Future<MySQLConnection> getConnection() async {
    return await MySQLConnection.createConnection(
      host: dotenv.env['DB_HOST'],
      port: int.parse(dotenv.env['DB_PORT']!),
      userName: dotenv.env['DB_USER']!,
      password: dotenv.env['DB_PASSWORD']!,
    );
  }
}
