import 'package:flutter/material.dart';
import 'package:perixx_outbound/Domain/orderlist/article.dart';

@immutable
class Item {
  final Article article;
  final int qty;

  const Item({
    required this.article,
    required this.qty,
  });

  @override
  String toString() => '${article.articleNo}   ${article.model}   x  $qty';

  @override
  bool operator ==(covariant Item other) =>
      article == other.article && qty == other.qty;

  @override
  int get hashCode => Object.hash(
        article,
        qty,
      );
}

extension ItemList on List<Item> {
  void addItem(Item newItem) {
    if (isNotEmpty) {
      int newQty = 0;
      try {
        Item oldItem = firstWhere((item) => item.article == newItem.article);
        int index = indexOf(oldItem);
        newQty = oldItem.qty + newItem.qty;
        this[index] = Item(
          article: oldItem.article,
          qty: newQty,
        );
      } catch (e) {
        add(newItem);
      }
    } else {
      add(newItem);
    }
  }
}
