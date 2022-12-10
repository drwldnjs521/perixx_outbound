import 'package:get/get.dart';

class ScanController extends GetxController {
  RxList<String> eanList = <String>[].obs;

  void removeEan(String ean) {
    eanList.remove(ean);
  }

  void addEan(String ean) {
    eanList.add(ean);
  }
}
