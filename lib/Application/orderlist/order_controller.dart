import 'package:get/get.dart';
import 'package:mysql1/mysql1.dart';
import 'package:perixx_outbound/Application/app_state.dart';
import 'package:perixx_outbound/Data/orderlist/mysql_exception.dart';
import 'package:perixx_outbound/Data/orderlist/order_repository.dart';
import 'package:perixx_outbound/Domain/orderlist/article.dart';
import 'package:perixx_outbound/Domain/orderlist/item.dart';
import 'package:perixx_outbound/Domain/orderlist/order.dart';

class OrderController extends GetxController {
  final OrderRepository _orderRepo = OrderRepository();

  //reactive state management
  RxList<Order> orderList = <Order>[].obs;
  RxList<Article> articleList = <Article>[].obs;
  Rx<AppState> pageState = AppState.initial.obs;

  @override
  void onInit() async {
    articleList.value = await _orderRepo.getAllArticles();
    orderList.value = await _orderRepo.getTodayOrder();
    // interval(orderList, (_) async {
    //   orderList.value = await _orderRepo.getAllOrder();
    // }, time: const Duration(seconds: 1));
    super.onInit();
  }

  @override
  void onClose() async {
    _orderRepo.close();
    super.onClose();
  }

  // List<Order> getOrderBetweenByStatus({
  //   required String start,
  //   required String end,
  //   required String status,
  // }) {
  //   switch (status) {
  //     case "processing":
  //       if (start == end) {
  //         return orderList
  //             .where((order) =>
  //                 _getDate(order.createdDate)
  //                     .isAtSameMomentAs(_getDate(DateTime.parse(start))) &&
  //                 order.status == status)
  //             .toList();
  //       } else {
  //         return orderList
  //             .where((order) =>
  //                 _getDate(order.createdDate)
  //                     .isBefore(_getDate(DateTime.parse(end))) &&
  //                 _getDate(order.createdDate)
  //                     .isAfter(_getDate(DateTime.parse(start))) &&
  //                 order.status == status)
  //             .toList();
  //       }

  //     case "scanned":
  //       if (start == end) {
  //         return orderList
  //             .where((order) =>
  //                 _getDate(order.createdDate)
  //                     .isAtSameMomentAs(_getDate(DateTime.parse(start))) &&
  //                 order.status == status)
  //             .toList();
  //       } else {
  //         return orderList
  //             .where((order) =>
  //                 _getDate(order.createdDate)
  //                     .isBefore(_getDate(DateTime.parse(end))) &&
  //                 _getDate(order.createdDate)
  //                     .isAfter(_getDate(DateTime.parse(start))) &&
  //                 order.status == status)
  //             .toList();
  //       }

  //     case "shipped":
  //       if (start == end) {
  //         return orderList
  //             .where((order) =>
  //                 _getDate(order.createdDate)
  //                     .isAtSameMomentAs(_getDate(DateTime.parse(start))) &&
  //                 order.status == status)
  //             .toList();
  //       } else {
  //         return orderList
  //             .where((order) =>
  //                 _getDate(order.createdDate)
  //                     .isBefore(_getDate(DateTime.parse(end))) &&
  //                 _getDate(order.createdDate)
  //                     .isAfter(_getDate(DateTime.parse(start))) &&
  //                 order.status == status)
  //             .toList();
  //       }
  //     default:
  //       if (start == end) {
  //         return orderList
  //             .where((element) => _getDate(element.createdDate)
  //                 .isAtSameMomentAs(_getDate(DateTime.parse(start))))
  //             .toList();
  //       } else {
  //         return orderList
  //             .where((element) =>
  //                 _getDate(element.createdDate)
  //                     .isBefore(_getDate(DateTime.parse(end))) &&
  //                 _getDate(element.createdDate)
  //                     .isAfter(_getDate(DateTime.parse(start))))
  //             .toList();
  //       }
  //   }
  // }

  Future<void> getOrderExactSameEan(List<String> eans) async {
    pageState(AppState.loading);
    orderList.value = await _orderRepo.getProcessingOrder();
    pageState(AppState.loaded);
    orderList.where((order) => order.containExactlySameArticle(eans)).isEmpty
        ? orderList.value = []
        : orderList.value = [
            orderList
                .where((order) => order.containExactlySameArticle(eans))
                .first
          ];
  }

  Future<void> getTodayOrder() async {
    pageState(AppState.loading);
    try {
      orderList.value = await _orderRepo.getTodayOrder();
    } on MySqlException catch (e) {
      if (e.errorNumber == 1062) {
        throw DuplicateException();
      } else {
        throw MySqlCustomException(e.message);
      }
    } catch (e) {
      throw MySqlCustomException(e.toString());
    }

    pageState(AppState.loaded);
  }

  Future<void> getOrderBetweenByStatus({
    required String start,
    required String end,
    required String status,
  }) async {
    pageState(AppState.loading);
    try {
      orderList.value = await _orderRepo.getOrderBetweenByStatus(
          begin: start, end: end, status: status);
    } on MySqlException catch (e) {
      if (e.errorNumber == 1062) {
        throw DuplicateException();
      } else {
        throw MySqlCustomException(e.message);
      }
    } catch (e) {
      throw MySqlCustomException(e.toString());
    }

    pageState(AppState.loaded);
    // switch (status) {
    //   case "processing":
    //  orderList.value = await _orderRepo.getOrderBetweenByStatus(
    //           begin: start, end: end, status: status);
    //       break;

    //     }
    //   selectedOrders.value = orderList
    //       .where((order) =>
    //           _getDate(order.createdDate)
    //               .isAtSameMomentAs(_getDate(DateTime.parse(start))) &&
    //           order.status == status)
    //       .toList();
    //   break;
    // } else {
    //   selectedOrders.value = orderList
    //       .where((order) =>
    //           _getDate(order.createdDate)
    //               .isBefore(_getDate(DateTime.parse(end))) &&
    //           _getDate(order.createdDate)
    //               .isAfter(_getDate(DateTime.parse(start))) &&
    //           order.status == status)
    //       .toList();
    //   break;
    // }

    // case "scanned":
    // if (start == end) {
    //   selectedOrders.value = orderList
    //       .where((order) =>
    //           _getDate(order.createdDate)
    //               .isAtSameMomentAs(_getDate(DateTime.parse(start))) &&
    //           order.status == status)
    //       .toList();
    //   break;
    // } else {
    //   selectedOrders.value = orderList
    //       .where((order) =>
    //           _getDate(order.createdDate)
    //               .isBefore(_getDate(DateTime.parse(end))) &&
    //           _getDate(order.createdDate)
    //               .isAfter(_getDate(DateTime.parse(start))) &&
    //           order.status == status)
    //       .toList();
    //   break;
    // }
    //   orderList.value = await _orderRepo.getOrderBetweenByStatus(
    //         begin: start, end: end, status: status);
    //     break;

    // case "shipped":
    //   if (start == end) {
    //     selectedOrders.value = orderList
    //         .where((order) =>
    //             _getDate(order.createdDate)
    //                 .isAtSameMomentAs(_getDate(DateTime.parse(start))) &&
    //             order.status == status)
    //         .toList();
    //     break;
    //   } else {
    //     selectedOrders.value = orderList
    //         .where((order) =>
    //             _getDate(order.createdDate)
    //                 .isBefore(_getDate(DateTime.parse(end))) &&
    //             _getDate(order.createdDate)
    //                 .isAfter(_getDate(DateTime.parse(start))) &&
    //             order.status == status)
    //         .toList();
    //     break;
    //   }
    // default:
    //   if (start == end) {
    //     selectedOrders.value = orderList
    //         .where((element) => _getDate(element.createdDate)
    //             .isAtSameMomentAs(_getDate(DateTime.parse(start))))
    //         .toList();
    //     break;
    //   } else {
    //     selectedOrders.value = orderList
    //         .where((element) =>
    //             _getDate(element.createdDate)
    //                 .isBefore(_getDate(DateTime.parse(end))) &&
    //             _getDate(element.createdDate)
    //                 .isAfter(_getDate(DateTime.parse(start))))
    //         .toList();
    //     break;
    //   }
    // }
  }

  Article? getArticleByEan(String ean) {
    return articleList.where((article) => article.ean == ean).isEmpty
        ? null
        : articleList.where((article) => article.ean == ean).first;
  }

  Future<void> getProcessingOrderByEan(List<String> eans) async {
    pageState(AppState.loading);
    orderList.value = await _orderRepo.getProcessingOrder();
    pageState(AppState.loaded);
    orderList.where((order) => order.containAllArticle(eans)).toList().isEmpty
        ? orderList.value = []
        : orderList.value =
            orderList.where((order) => order.containAllArticle(eans)).toList();
  }

  // Future<void> getProcessingOrderByItems(List<Item> itemList) async {
  //   pageState(AppState.loading);
  //   try {
  //     orderList.value = await _orderRepo.getProcessingOrder();
  //   } on MySqlException catch (e) {
  //     if (e.errorNumber == 1062) {
  //       throw DuplicateException();
  //     } else {
  //       throw MySqlCustomException(e.message);
  //     }
  //   } catch (e) {
  //     throw MySqlCustomException(e.toString());
  //   }

  //   pageState(AppState.loaded);
  //   orderList
  //           .where((order) => order.containAllArticle(itemList))
  //           .toList()
  //           .isEmpty
  //       ? orderList.value = []
  //       : orderList.value = orderList
  //           .where((order) => order.containAllArticle(itemList))
  //           .toList();
  // }

  // Future<Order?> getOrderExactSameEan(List<String> eans) async {
  //   pageState(AppState.loading);
  //   orderList.value = await _orderRepo.getProcessingOrder();
  //   pageState(AppState.loaded);
  //   return orderList
  //           .where((order) => order.containExactlySameArticle(eans))
  //           .isEmpty
  //       ? null
  //       : orderList
  //           .where((order) => order.containExactlySameArticle(eans))
  //           .first;
  // }

  Future<void> getOrderExactSameItems(List<Item> itemList) async {
    pageState(AppState.loading);
    try {
      orderList.value = await _orderRepo.getProcessingOrder();
    } on MySqlException catch (e) {
      if (e.errorNumber == 1062) {
        throw DuplicateException();
      } else {
        throw MySqlCustomException(e.message);
      }
    } catch (e) {
      throw MySqlCustomException(e.toString());
    }

    pageState(AppState.loaded);
    // orderList.where((order) => order.containExactlySameArticle(eans)).isEmpty
    //     ? orderList.value = []
    //     : orderList.value = [
    //         orderList
    //             .where((order) => order.containExactlySameArticle(eans))
    //             .first
    //       ];
    orderList.where((order) => order.containExactlySameItems(itemList)).isEmpty
        ? orderList.value = []
        : orderList.value = [
            orderList
                .where((order) => order.containExactlySameItems(itemList))
                .first
          ];
  }

  Future<void> getOrderExactSameArticles(List<String> eanList) async {
    pageState(AppState.loading);
    try {
      orderList.value = await _orderRepo.getProcessingOrder();
    } on MySqlException catch (e) {
      if (e.errorNumber == 1062) {
        throw DuplicateException();
      } else {
        throw MySqlCustomException(e.message);
      }
    } catch (e) {
      throw MySqlCustomException(e.toString());
    }

    pageState(AppState.loaded);
    // orderList.where((order) => order.containExactlySameArticle(eans)).isEmpty
    //     ? orderList.value = []
    //     : orderList.value = [
    //         orderList
    //             .where((order) => order.containExactlySameArticle(eans))
    //             .first
    //       ];
    orderList.where((order) => order.containExactlySameArticle(eanList)).isEmpty
        ? orderList.value = []
        : orderList.value = [
            orderList
                .where((order) => order.containExactlySameArticle(eanList))
                .first
          ];
  }

  // DateTime _getDate(DateTime dateTime) {
  //   return DateUtils.dateOnly(dateTime);
  // }

  // Future<void> _getProcessingOrder() async {
  //   pageState(AppState.loading);
  //   orderList.value = await _orderRepo.getProcessingOrder();
  //   pageState(AppState.loaded);
  // }

  Future<void> updateStatusToScanned({
    required Order order,
    required String assigner,
  }) async {
    final copiedOrder = order.copyWith(assigner: assigner);
    pageState(AppState.loading);
    try {
      await _orderRepo.updateStatusToScanned(order, assigner);
    } on MySqlException catch (e) {
      if (e.errorNumber == 1062) {
        throw DuplicateException();
      } else {
        throw MySqlCustomException(e.message);
      }
    } catch (e) {
      throw MySqlCustomException(e.toString());
    }
    orderList.remove(order);
    orderList.add(copiedOrder);
    pageState(AppState.loaded);
  }

  Future<void> updateStatusToShipped({required List<Order> orderList}) async {
    pageState(AppState.loading);
    for (var order in orderList) {
      final copiedOrder = order.copyWith(shippedDate: DateTime.now().toUtc());
      try {
        await _orderRepo.updateStatusToShipped(order);
      } on MySqlException catch (e) {
        if (e.errorNumber == 1062) {
          throw DuplicateException();
        } else {
          throw MySqlCustomException(e.message);
        }
      } catch (e) {
        throw MySqlCustomException(e.toString());
      }
      orderList.remove(order);
      orderList.add(copiedOrder);
    }
  }
}
