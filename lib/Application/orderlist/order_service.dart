import 'package:perixx_outbound/Data/orderlist/order_repository.dart';
import 'package:perixx_outbound/Domain/orderlist/order.dart';

class OrderService {
  final OrderRepository _orderRepo;

  const OrderService(this._orderRepo);

  factory OrderService.mysql() => OrderService(OrderRepository());

  // static Future<void> createConn() async {
  //   await Mysql.getConnection();
  // }

  Future<List<Order>> getOrderOn(String timeOn) async {
    return _orderRepo.getOrderOn(timeOn);
  }

  Future<List<Order>> getOrderBetween(String begin, String end) async {
    return _orderRepo.getOrderBetween(begin, end);
  }

  Future<List<Order>> getOrderToday() async {
    return _orderRepo.getOrderToday();
  }

  Future<void> close() async {
    await _orderRepo.close();
  }

  Future<void> open() async {
    await _orderRepo.open();
  }
}
