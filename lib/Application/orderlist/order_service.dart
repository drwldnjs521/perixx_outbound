import 'package:perixx_outbound/Application/orderlist/mysql.dart';
import 'package:perixx_outbound/Data/orderlist/order_repository.dart';
import 'package:perixx_outbound/Domain/orderlist/order.dart';

class OrderService implements OrderRepository {
  final OrderRepository _orderRepo;

  const OrderService(this._orderRepo);

  factory OrderService.mysql() =>
      OrderService(OrderRepository(Mysql.getConnection()));

  // static Future<void> createConn() async {
  //   await Mysql.getConnection();
  // }

  @override
  Future<List<Order>> getOrderOn(String timeOn) async {
    return _orderRepo.getOrderOn(timeOn);
  }

  @override
  Future<List<Order>> getOrderBetween(String begin, String end) async {
    return _orderRepo.getOrderBetween(begin, end);
  }

  @override
  Future<List<Order>> getOrderToday() async {
    return _orderRepo.getOrderToday();
  }

  @override
  Future<void> close() async {
    await _orderRepo.close();
  }

  @override
  Future<void> open() async {
    await _orderRepo.open();
  }
}
