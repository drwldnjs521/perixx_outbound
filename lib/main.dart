import 'package:flutter/material.dart';
import 'package:perixx_outbound/Application/auth_service.dart';
import 'package:perixx_outbound/Presentation/login_view.dart';
import 'package:perixx_outbound/Presentation/order_list_view.dart';
import 'package:perixx_outbound/constants/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      routes: {
        loginRoute: (context) => const LoginView(),
        orderListRoute: (context) => const OrderListView(),
      },
      title: 'Perixx Outbound',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
