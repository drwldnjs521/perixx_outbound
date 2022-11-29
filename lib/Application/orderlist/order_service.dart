import 'package:perixx_outbound/Data/orderlist/order_repository.dart';
import 'package:perixx_outbound/Domain/orderlist/order.dart';

class OrderService {
  final OrderRepository _orderRepo;

  const OrderService(this._orderRepo);

  factory OrderService.mysql() => OrderService(OrderRepository());

  // static Future<void> createConn() async {
  //   await Mysql.getConnection();
  // }

  // Future<List<Order>> getOrderOn(String dateOn) async {
  //   return _orderRepo.getOrderOn(dateOn);
  // }

  Future<List<Order>> getOrderBetweenWithStatus({
    required String begin,
    required String end,
    required String? status,
  }) async {
    return _orderRepo.getOrderBetweenByStatus(
      begin: begin,
      end: end,
      status: status,
    );
  }

  Future<List<Order>> getOrderByEan({required List<String> eans}) async {
    return _orderRepo.getOrderByEan(eans: eans);
  }

  Future<void> close() async {
    await _orderRepo.close();
  }

  Future<void> open() async {
    await _orderRepo.open();
  }

  Future<void> initialize() async {
    _orderRepo.initialize();
  }
}

// class OrderController extends GetxController {
//   static final OrderRepository _orderRepo = OrderRepository();

//   final allOrderList = _orderRepo.getAllOrder().obs;

//   Future<List<Order>> getOrderBetweenWithStatus({
//     required String begin,
//     required String end,
//     required String? status,
//   }) async {
//     return _orderRepo.getOrderBetweenByStatus(
//       begin: begin,
//       end: end,
//       status: status,
//     );
//   }

//   Future<List<Order>> getOrderByEan({required List<String> eans}) async {
//     return _orderRepo.getOrderByEan(eans: eans);
//   }

//   Future<void> close() async {
//     await _orderRepo.close();
//   }

//   Future<void> open() async {
//     await _orderRepo.open();
//   }

//   Future<void> initialize() async {
//     _orderRepo.initialize();
//   }
// }
