import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:perixx_outbound/Domain/orderlist/article.dart';
import 'package:perixx_outbound/Domain/orderlist/item.dart';
import 'package:perixx_outbound/constants/mysql_crud.dart';

@immutable
class Order {
  final DateTime createdDate;
  final String orderNo;
  // final Status status;
  final List<Item> items;
  final String labelNo;
  final String shippedTo;
  final String cn23;
  final String? assigner;
  final DateTime? shippedDate;

  String get orderedDate => DateFormat("yyyy-MM-dd").format(createdDate);
  String? get status => (assigner != null && shippedDate != null)
      ? "shipped"
      : (assigner != null && shippedDate == null)
          ? "scanned"
          : "processing";

  const Order({
    required this.createdDate,
    required this.orderNo,
    required this.items,
    required this.labelNo,
    required this.shippedTo,
    required this.cn23,
    required this.assigner,
    required this.shippedDate,
  });
  // status = scannedBy == null && shippedOn == null
  //     ? Status.processing
  //     : (shippedOn == null ? Status.scanned : Status.shipped);

  Order.fromRow(Map<String, Object?> map)
      : createdDate = map[createdDateColumn] as DateTime,
        orderNo = map[orderNoColumn] as String,
        // status = Status.values.byName(map[statusColumn].toString()),
        items = List.filled(
            1,
            Item(
                article: Article(
                  id: map[articleIdColumn] as int,
                  articleNo: map[articleNoColumn] as String,
                  ean: map[eanColumn] as String,
                  model: map[modelColumn] as String,
                  image: map[imageColumn] as String,
                ),
                qty: map[qtyColumn] as int),
            growable: true),
        labelNo = map[labelNoColumn] as String,
        shippedTo = map[shippedToColumn] as String,
        cn23 = map[cn23Column] as String,
        assigner = map[assignerColumn] as String?,
        shippedDate = map[shippedDateColumn] as DateTime?;

  @override
  String toString() =>
      'Order No. = $orderNo, Created Date = $createdDate, Items = $items';

  @override
  bool operator ==(covariant Order other) => orderNo == other.orderNo;

  @override
  int get hashCode => orderNo.hashCode;

  bool containExactlySameItems(List<Item> itemList) {
    final orderItemsHasScannedItems = items.every((item) {
      if (item.article.articleNo == "19999") {
        return true;
      }
      return itemList.contains(item);
    });
    final scannedItemsHasOrderItems =
        itemList.every((item) => items.contains(item));
    return orderItemsHasScannedItems && scannedItemsHasOrderItems;
  }

  bool containAllArticle(List<Item> itemList) {
    return itemList.every((item) {
      return _getArticles().contains(item.article);
    });
  }

  // bool containAllItems(List<Item> itemList) {
  //   return itemList.every((item) => _getItems().contains(item));
  // }

  List<Article> _getArticles() {
    return items.map((item) => item.article).toList();
  }

  Order copyWith({
    String? assigner,
    DateTime? shippedDate,
  }) {
    return Order(
      createdDate: createdDate,
      orderNo: orderNo,
      items: items,
      labelNo: labelNo,
      shippedTo: shippedTo,
      cn23: cn23,
      assigner: assigner ?? this.assigner,
      shippedDate: shippedDate ?? this.shippedDate,
    );
  }
}

extension OrderList on List<Order> {
  void addOrder(Order newOrder) {
    if (isNotEmpty) {
      try {
        var oldOrder = firstWhere((p) => p.orderNo == newOrder.orderNo);
        oldOrder.items.add(newOrder.items[0]);
      } catch (e) {
        add(newOrder);
      }
    } else {
      add(newOrder);
    }
  }
}
