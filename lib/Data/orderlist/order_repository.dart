import 'package:mysql_client/exception.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:perixx_outbound/Data/orderlist/mysql_exception.dart';
import 'package:perixx_outbound/constants/mysql_crud.dart';

class OrderRepository {
  final _conn;

  const OrderRepository(this._conn);

  Future<void> open() async {
    try {
      // create shippedBy table
      await _conn.execute(createShippedByTable);
      // create scannedBy table
      await _conn.execute(createShippedByTable);
    } on MySQLClientException {
      throw CouldNotCreateTheTable();
    }
  }

  Future<void> initialize() async {
    await _conn.conn();
  }
}
