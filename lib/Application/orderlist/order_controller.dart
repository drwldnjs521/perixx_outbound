import 'package:get/get.dart';
import 'package:perixx_outbound/Application/orderlist/mysql.dart';
import 'package:perixx_outbound/Data/orderlist/order_repository.dart';
import 'package:perixx_outbound/Domain/orderlist/order.dart';

class OrderController extends GetxController with StateMixin<List<Order>> {
  final OrderRepository _orderRepo = OrderRepository();
  void getConnection() async {
    Mysql.instance.createConnection();
  }

  Future<void> open() async {
    await _orderRepo.open();
  }
}
