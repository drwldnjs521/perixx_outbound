import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:perixx_outbound/Application/login/auth_service.dart';
import 'package:perixx_outbound/Application/orderlist/orderBindung.dart';
import 'package:perixx_outbound/Presentation/login/login_view.dart';
import 'package:perixx_outbound/Presentation/orderlist/order_view.dart';
import 'package:perixx_outbound/Presentation/languages.dart';
import 'package:perixx_outbound/constants/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  // await Mysql.instance.createConnection();
  runApp(GetMaterialApp(
    title: 'Perixx Outbound',
    getPages: appRoutes(),
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
              return const OrderView();
            } else {
              return const LoginView();
            }
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    ),
    initialBinding: OrderBinding(),
  ));
}
