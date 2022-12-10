import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:perixx_outbound/Application/orderlist/mysql.dart';

import '../firebase_options.dart';

class InitialSettingService extends GetxService {
  Future<InitialSettingService> init() async {
    await dotenv.load();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await Mysql.instance.createConnection();
    return this;
  }

  @override
  void onClose() async {
    await Mysql.connection.close();
  }
}
