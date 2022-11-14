import 'package:flutter/material.dart';
import 'package:perixx_outbound/Domain/orderlist/article.dart';
import 'package:perixx_outbound/Domain/orderlist/item.dart';
import 'package:perixx_outbound/constants/mysql_crud.dart';

enum Status {
  processing,
  scanned,
  packed,
}

@immutable
class Order {
  final String orderNo;
  final Status status;
  // final int articleId;
  // final int qty;
  final List<Item> items;
  final String labelNo;
  final String shippedTo;
  final String cn23;
  final String? scannedBy;
  final String? packedBy;

  const Order({
    required this.orderNo,
    // required this.articleId,
    // required this.qty,
    required this.items,
    required this.labelNo,
    required this.shippedTo,
    required this.cn23,
    Status? status,
    String? scannedBy,
    String? packedBy,
  })  : scannedBy = scannedBy ?? '',
        packedBy = packedBy ?? '',
        status = scannedBy == null && packedBy == null
            ? Status.processing
            : (packedBy == null ? Status.scanned : Status.packed);

  Order.fromRow(Map<String, Object?> map)
      : orderNo = map[orderNoColumn] as String,
        status = Status.values.byName(map[statusColumn].toString()),
        // articleId = map[articleIdColumn] as int,
        // qty = map[qtyColumn] as int,
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
        scannedBy = map[scannedByColumn] as String?,
        packedBy = map[packedByColumn] as String?;

  @override
  String toString() => 'Order No. = $orderNo, Items = $items';

  @override
  bool operator ==(covariant Order other) => orderNo == other.orderNo;

  @override
  int get hashCode => orderNo.hashCode;
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
