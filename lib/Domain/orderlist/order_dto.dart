import 'package:flutter/material.dart';
import 'package:perixx_outbound/constants/mysql_crud.dart';

@immutable
class OrderDto {
  final int id;
  final String orderNo;
  final String invoiceLink;
  final String status;
  final int articleId;
  final int qty;
  final String labelNo;
  final String labelLink;
  final String shippedTo;
  final String cn23;
  final String? cn23Link;

  const OrderDto({
    required this.id,
    required this.orderNo,
    required this.invoiceLink,
    required this.status,
    required this.articleId,
    required this.qty,
    required this.labelNo,
    required this.labelLink,
    required this.shippedTo,
    required this.cn23,
    required this.cn23Link,
  });

  OrderDto.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        orderNo = map[orderNoColumn] as String,
        invoiceLink = map[invoiceLinkColumn] as String,
        status = map[statusColumn] as String,
        articleId = map[articleIdColumn] as int,
        qty = map[qtyColumn] as int,
        labelNo = map[labelNoColumn] as String,
        labelLink = map[labelLinkColumn] as String,
        shippedTo = map[shippedToColumn] as String,
        cn23 = map[cn23Column] as String,
        cn23Link = map[cn23LinkColumn] as String?;

  @override
  String toString() =>
      'Order, ID = $id, Order No. = $orderNo, Article ID = $articleId, Qyt. = $qty';

  @override
  bool operator ==(covariant OrderDto other) => id == other.id;

  @override
  int get hashCode => id.hashCode;

  bool hasSameOrderNo(covariant OrderDto other) {
    return orderNo == other.orderNo;
  }
}
