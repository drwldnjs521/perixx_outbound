import 'package:flutter/material.dart';
import 'package:perixx_outbound/constants/mysql_crud.dart';

@immutable
class Article {
  final int id;
  final String articleNo;
  final String ean;
  final String model;
  final String image;

  const Article({
    required this.id,
    required this.articleNo,
    required this.ean,
    required this.model,
    required this.image,
  });

  Article.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        articleNo = map[articleNoColumn] as String,
        ean = map[eanColumn] as String,
        model = map[modelColumn] as String,
        image = map[imageColumn] as String;

  @override
  String toString() =>
      'Article, ID = $id, Article No. = $articleNo, model = $model';

  @override
  bool operator ==(covariant Article other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}
