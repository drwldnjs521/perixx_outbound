import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:perixx_outbound/Domain/orderlist/article.dart';
import 'package:perixx_outbound/Domain/orderlist/item.dart';
import 'package:perixx_outbound/constants/mysql_crud.dart';

enum Status {
  processing,
  scanned,
  shipped,
}

@immutable
class Order {
  final DateTime createdDate;
  final String orderNo;
  final Status status;
  final List<Item> items;
  final String labelNo;
  final String shippedTo;
  final String cn23;
  final String? scannedBy;
  final String? shippedOn;

  String get orderedDate => DateFormat('yyyy-MM-dd').format(createdDate);

  const Order({
    required this.createdDate,
    required this.orderNo,
    // required this.articleId,
    // required this.qty,
    required this.items,
    required this.labelNo,
    required this.shippedTo,
    required this.cn23,
    Status? status,
    String? scannedBy,
    String? shippedOn,
  })  : scannedBy = scannedBy ?? '',
        shippedOn = shippedOn ?? '',
        status = scannedBy == null && shippedOn == null
            ? Status.processing
            : (shippedOn == null ? Status.scanned : Status.shipped);

  Order.fromRow(Map<String, Object?> map)
      : createdDate = map[createdDateColumn] as DateTime,
        orderNo = map[orderNoColumn] as String,
        status = Status.values.byName(map[statusColumn].toString()),
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
        scannedBy = map[scannedColumn] as String?,
        shippedOn = map[shippedColumn] as String?;

  @override
  String toString() =>
      'Order No. = $orderNo, Created Date = $createdDate, Items = $items';

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
