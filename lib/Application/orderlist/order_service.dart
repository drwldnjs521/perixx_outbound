import 'package:perixx_outbound/Application/orderlist/mysql.dart';
import 'package:perixx_outbound/Data/orderlist/order_repository.dart';

class OrderService {
  final OrderRepository _orderRepo;

  const OrderService(this._orderRepo);

  factory OrderService.mysql() =>
      OrderService(OrderRepository(Mysql.getConnection()));

  Future<void> open() async {
    await _orderRepo.open();
  }

  Future<void> initialize() async {
    await _orderRepo.initialize();
  }
}
