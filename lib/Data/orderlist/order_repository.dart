import 'package:intl/intl.dart';
import 'package:perixx_outbound/Domain/orderlist/order.dart';
import 'package:perixx_outbound/constants/mysql_crud.dart';

class OrderRepository {
  final _conn;

  const OrderRepository(this._conn);

  Future<void> open() async {
    // create shippedBy table
    await _conn.query(createShippedByTable);
    // create scannedBy table
    await _conn.query(createShippedByTable);
  }

  Future<List<Order>> getOrderToday() async {
    List<Order> orderList = [];
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var result = await _conn.query(orderToday, [formattedDate]);
    return result
        .map(
          (row) => Order.fromRow(row.fields),
        )
        .forEach((e) => orderList.addOrder(e));
  }

  Future<List<Order>> getOrderOn(String timeOn) async {
    List<Order> orderList = [];
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(DateTime.parse(timeOn));
    var result = await _conn.query(orderOn, [formattedDate]);
    return result
        .map(
          (row) => Order.fromRow(row.fields),
        )
        .forEach((e) => orderList.addOrder(e));
  }

  Future<List<Order>> getOrderBetween(String begin, String end) async {
    List<Order> orderList = [];
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedBeginDate = formatter.format(DateTime.parse(begin));
    String formattedEndDate = formatter.format(DateTime.parse(end));
    var result = await _conn.query(orderBetween, [
      formattedBeginDate,
      formattedEndDate,
    ]);
    return result
        .map(
          (row) => Order.fromRow(row.fields),
        )
        .forEach((e) => orderList.addOrder(e));
  }

  Future<void> close() async {
    await _conn.close();
  }
}
