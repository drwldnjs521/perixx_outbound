import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:perixx_outbound/Application/orderlist/mysql.dart';
import 'package:perixx_outbound/Domain/orderlist/article.dart';
import 'package:perixx_outbound/Domain/orderlist/order.dart';
import 'package:perixx_outbound/constants/mysql_crud.dart';

class OrderRepository {
  final MySqlConnection _conn = Mysql.connection;

  Future<List<Article>> getAllArticles() async {
    List<Article> articleList = [];
    Results results;
    try {
      results = await _conn.query(allArticles);
    } catch (_) {
      rethrow;
    }

    results.map((row) => Article.fromRow(row.fields)).forEach((article) {
      articleList.add(article);
    });
    return articleList;
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

  Future<List<Order>> getTodayOrder() async {
    List<Order> orderList = [];

    Results results;
    try {
      results = await _conn.query(todayOrder);
    } catch (_) {
      rethrow;
    }

    results
        .map(
          (row) => Order.fromRow(row.fields),
        )
        .forEach((e) => orderList.addOrder(e));

    return orderList;
  }

  Future<List<Order>> getProcessingOrder() async {
    List<Order> orderList = [];
    Results results;
    try {
      results = await _conn.query(allProcessingOrder);
    } catch (_) {
      rethrow;
    }
    results
        .map(
          (row) => Order.fromRow(row.fields),
        )
        .forEach((e) => orderList.addOrder(e));

    return orderList;
  }

  // Future<List<Order>> getAllOrder() async {
  //   List<Order> orderList = [];
  //      Results results;
  //   try {
  //     results = await _conn.query(allOrder);

  //   } catch (_) {
  //     rethrow;
  //   }

  //   results
  //       .map(
  //         (row) => Order.fromRow(row.fields),
  //       )
  //       .forEach((e) => orderList.addOrder(e));

  //   return orderList;
  // }

  Future<List<Order>> getOrderBetweenByStatus({
    required String begin,
    required String end,
    required String status,
  }) async {
    List<Order> orderList = [];
    Results results;
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedBeginDate = formatter.format(DateTime.parse(begin));
    String formattedEndDate = formatter.format(DateTime.parse(end));
    try {
      results = await _conn.query(allArticles);
    } catch (_) {
      rethrow;
    }

    switch (status) {
      case "processing":
        try {
          results = await _conn.query(
              processingOrderBetween, [formattedBeginDate, formattedEndDate]);
        } catch (_) {
          rethrow;
        }
        break;

      case "scanned":
        try {
          results = await _conn.query(
              scannedOrderBetween, [formattedBeginDate, formattedEndDate]);
        } catch (_) {
          rethrow;
        }
        break;

      case "shipped":
        try {
          results = await _conn.query(
              shippedOrderBetween, [formattedBeginDate, formattedEndDate]);
        } catch (_) {
          rethrow;
        }
        break;

      default:
        try {
          results = await _conn
              .query(orderBetween, [formattedBeginDate, formattedEndDate]);
        } catch (_) {
          rethrow;
        }
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

  Future<void> updateStatusToScanned(Order order, String assigner) async {
    try {
      await _conn.query(updateAssigner, [
        assigner,
        order.orderNo,
      ]);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> updateStatusToShipped(Order order) async {
    try {
      await _conn.query(updateShippedDate, [
        DateTime.now().toUtc(),
        order.orderNo,
      ]);
    } catch (_) {
      rethrow;
    }
  }

  // Future<void> initialize() async {
  //   await Mysql.instance.createConnection();
  // }
}
