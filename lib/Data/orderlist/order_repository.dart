import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:perixx_outbound/Application/orderlist/mysql.dart';
import 'package:perixx_outbound/Domain/orderlist/order.dart';
import 'package:perixx_outbound/constants/mysql_crud.dart';

class OrderRepository {
  final MySqlConnection _conn = Mysql.connection;

  OrderRepository();

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
    try {
      var result = await _conn.query(orderToday, [formattedDate]);
      result
          .map((row) => Order.fromRow(row.fields))
          .forEach((e) => orderList.addOrder(e));
      return orderList;
    } catch (e) {
      log("MySQL Exception: $e");
      rethrow; // or return [];
    }
  }

  Future<List<Order>> getOrderOn(String timeOn) async {
    List<Order> orderList = [];
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(DateTime.parse(timeOn));
    try {
      var result = await _conn.query(orderOn, [formattedDate]);
      result
          .map((row) => Order.fromRow(row.fields))
          .forEach((e) => orderList.addOrder(e));
      return orderList;
    } catch (e) {
      log("MySQL Exception: $e");
      rethrow;
    }
  }

  Future<List<Order>> getOrderBetween(String begin, String end) async {
    List<Order> orderList = [];
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedBeginDate = formatter.format(DateTime.parse(begin));
    String formattedEndDate = formatter.format(DateTime.parse(end));
    try {
      var result = await _conn.query(orderBetween, [
        formattedBeginDate,
        formattedEndDate,
      ]);
      result
          .map((row) => Order.fromRow(row.fields))
          .forEach((e) => orderList.addOrder(e));
      return orderList;
    } catch (e) {
      log("MySQL Exception: $e");
      rethrow;
    }
  }

  Future<void> close() async {
    await _conn.close();
  }
}
