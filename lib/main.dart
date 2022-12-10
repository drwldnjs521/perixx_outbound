import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perixx_outbound/Application/setting_service.dart';

import 'package:perixx_outbound/Presentation/languages.dart';
import 'package:perixx_outbound/constants/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await Mysql.instance.createConnection();
  await initService();
  runApp(
    GetMaterialApp(
      title: 'Perixx Outbound',
      getPages: appRoutes(),
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: '/LOGIN',
    ),
  );
}

Future<void> initService() async {
  debugPrint("starting initial Service...");
  await Get.putAsync(() => InitialSettingService().init(), permanent: true);
  debugPrint("initial Service started...");
}





// runApp(GetMaterialApp(
//     title = 'Perixx Outbound',
//     getPages = appRoutes(),
//     debugShowCheckedModeBanner = false,
//     translations = Languages(),
//     locale = Get.deviceLocale,
//     fallbackLocale = const Locale('en', 'US'),
//     home = FutureBuilder(
//       future: AuthService.firebase().initialize(),
//       builder: (context, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.done:
//             final currentUser = AuthService.firebase().currentUser;
//             if (currentUser != null) {
//               return const OrderView();
//             } else {
//               return const LoginView();
//             }
//           default:
//             return const Center(child: CircularProgressIndicator());
//         }
//       },
//     ),
//     initialBinding = OrderBinding(),
//   ));
// }
