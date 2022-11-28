import 'package:get/get_navigation/get_navigation.dart';
import 'package:perixx_outbound/Presentation/login/login_view.dart';
import 'package:perixx_outbound/Presentation/orderlist/order_view.dart';
import 'package:perixx_outbound/Presentation/print/print_view.dart';
import 'package:perixx_outbound/Presentation/scan/scan_view.dart';

appRoutes() => [
      GetPage(
        name: '/LOGIN',
        page: () => const LoginView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/ORDERLIST',
        page: () => const OrderView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/SCAN',
        page: () => const ScanView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/PRINT',
        page: () => const PrintView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
    ];
