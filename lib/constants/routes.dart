import 'package:get/get.dart';
import 'package:perixx_outbound/Bindings/initial_bindings.dart';
import 'package:perixx_outbound/Presentation/login/login_view.dart';
import 'package:perixx_outbound/Presentation/orderlist/order_view.dart';
import 'package:perixx_outbound/Presentation/print/print_view.dart';
import 'package:perixx_outbound/Presentation/scan/scan_view.dart';

appRoutes() => [
      GetPage(
        name: '/LOGIN',
        page: () => const LoginView(),
        binding: InitialBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/ORDERLIST',
        page: () => const OrderView(),
        binding: InitialBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/SCAN',
        page: () => const ScanView(),
        binding: InitialBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/PRINT',
        page: () => const PrintView(),
        binding: InitialBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
    ];
