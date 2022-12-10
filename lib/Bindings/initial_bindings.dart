import 'package:get/get.dart';
import 'package:perixx_outbound/Application/login/auth_controller.dart';
import 'package:perixx_outbound/Application/orderlist/order_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    // Get.lazyPut<OrderController>(() => OrderController(), fenix: true);
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<OrderController>(OrderController(), permanent: true);
  }
}
