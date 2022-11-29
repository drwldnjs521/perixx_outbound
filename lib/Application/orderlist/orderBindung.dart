import 'package:get/get.dart';
import 'package:perixx_outbound/Application/orderlist/order_controller.dart';

class OrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController());
  }
}
