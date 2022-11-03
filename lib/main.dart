import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:perixx_outbound/Application/login/auth_service.dart';
import 'package:perixx_outbound/Presentation/login/login_view.dart';
import 'package:perixx_outbound/Presentation/orderlist/order_list_view.dart';
import 'package:perixx_outbound/constants/routes.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(GetMaterialApp(
      routes: {
        loginRoute: (context) => const LoginView(),
        orderListRoute: (context) => const OrderListView(),
      },
      title: 'Perixx Outbound',
      debugShowCheckedModeBanner: false,
      //internalization
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en', ''),
      //   Locale('de', ''),
      // ],
      home: const HomePage()));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
              return const CircularProgressIndicator();
          }
        });
  }
}
