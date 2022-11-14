import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:perixx_outbound/Application/login/auth_service.dart';
import 'package:perixx_outbound/Presentation/login/login_view.dart';
import 'package:perixx_outbound/Presentation/orderlist/order_list_view.dart';
import 'package:perixx_outbound/Presentation/scan/scan_view.dart';
import 'package:perixx_outbound/constants/routes.dart';
import 'package:perixx_outbound/Presentation/languages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  runApp(GetMaterialApp(
    routes: {
      loginRoute: (context) => const LoginView(),
      orderListRoute: (context) => const OrderListView(),
      scanRoute: (context) => const ScanView(),
    },
    title: 'Perixx Outbound',
    debugShowCheckedModeBanner: false,
    translations: Languages(),
    locale: Get.deviceLocale,
    fallbackLocale: const Locale('en', 'US'),
    home: FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final currentUser = AuthService.firebase().currentUser;
            if (currentUser != null) {
              return const OrderListView();
            } else {
              return const LoginView();
            }
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    ),
  ));
}
