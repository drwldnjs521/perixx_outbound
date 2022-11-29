import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:perixx_outbound/Application/orderlist/mysql.dart';
import 'package:perixx_outbound/Domain/orderlist/order.dart';
import 'package:perixx_outbound/constants/mysql_crud.dart';

class OrderRepository {
  final MySqlConnection _conn = Mysql.connection;

  OrderRepository();

  Future<void> open() async {
    // create shipped table
    await _conn.query(createShippedTable);
    // create scannedBy table
    await _conn.query(createScannedTable);
  }

  // Future<List<Order>> getOrderToday() async {
  //   List<Order> orderList = [];
  //   var now = DateTime.now();
  //   var formatter = DateFormat('yyyy-MM-dd');
  //   String formattedDate = formatter.format(now);
  //   var result = await _conn.query(orderToday, [formattedDate]);
  //   result
  //       .map(
  //         (row) => Order.fromRow(row.fields),
  //       )
  //       .forEach((e) => orderList.addOrder(e));
  //   return orderList;
  // }

  // Future<List<Order>> getOrderOn(String timeOn) async {
  //   List<Order> orderList = [];
  //   var formatter = DateFormat('yyyy-MM-dd');
  //   String formattedDate = formatter.format(DateTime.parse(timeOn));
  //   var result = await _conn.query(orderOn, [formattedDate]);
  //   result
  //       .map(
  //         (row) => Order.fromRow(row.fields),
  //       )
  //       .forEach((e) => orderList.addOrder(e));
  //   return orderList;
  // }

  Future<List<Order>> getAllOrder() async {
    List<Order> orderList = [];
    Results results;
    results = await _conn.query(
      allOrder,
    );

    results
        .map(
          (row) => Order.fromRow(row.fields),
        )
        .forEach((e) => orderList.addOrder(e));

    return orderList;
  }

  Future<List<Order>> getOrderBetweenByStatus({
    required String begin,
    required String end,
    required String? status,
  }) async {
    List<Order> orderList = [];
    Results results;
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedBeginDate = formatter.format(DateTime.parse(begin));
    String formattedEndDate = formatter.format(DateTime.parse(end));

    if (status != null && status != 'all') {
      results = await _conn.query(
        orderBetweenWithStatus,
        [
          formattedBeginDate,
          formattedEndDate,
          status,
        ],
      );
    } else {
      results = await _conn.query(
        orderBetween,
        [
          formattedBeginDate,
          formattedEndDate,
        ],
      );
    }
    results
        .map(
          (row) => Order.fromRow(row.fields),
        )
        .forEach((e) => orderList.addOrder(e));

    return orderList;
  }

  Future<List<Order>> getOrderByEan({required List<String> eans}) async {
    List<Order> orderList = [];
    var orders = await _getReferenceNoByEan(eans: eans);
    var results = await _conn.queryMulti(orderByReferenceNo, orders);
    for (var result in results) {
      result
          .map((row) => Order.fromRow(row.fields))
          .forEach((e) => orderList.addOrder(e));
    }
    return orderList;
  }

  Future<List<List<String>>> _getReferenceNoByEan(
      {required List<String> eans}) async {
    var orderList = [];

    for (var ean in eans) {
      List<String> orders = [];
      var result = await _conn.query(orderByEan, [ean]);
      for (var row in result) {
        orders.add(row['reference_no']);
      }
      orderList.add(orders);
    }
    final commonOrders = orderList
        .fold<Set>(orderList.first.toSet(), (a, b) => a.intersection(b.toSet()))
        .map((e) => e.toString())
        .toList();

    return commonOrders.map((e) => [e]).toList();
  }

  Future<void> close() async {
    await _conn.close();
  }

  Future<void> initialize() async {
    await Mysql.instance.createConnection();
  }
}
