import 'package:flutter_test/flutter_test.dart';
import 'package:perixx_outbound/Domain/orderlist/article.dart';
import 'package:perixx_outbound/Domain/orderlist/item.dart';

void main() {
  late List<Item> itemList;
  setUp(() {
    itemList = _generateItemList();
  });
  group('Add items to an list', () {
    test(
        "If there is a same item in a list, the quantity of this item will be added.",
        () {
      //Arrange
      Item newItem = Item(
        article: Article(
          id: 1,
          articleNo: '1' * 5,
          ean: '1' * 8,
          model: 'keyboard1',
          image: 'image1',
        ),
        qty: 1,
      );
      //Act
      itemList.addItem(newItem);
      //Assert
      expect(
        itemList.first,
        Item(
          article: Article(
            id: 1,
            articleNo: '1' * 5,
            ean: '1' * 8,
            model: 'keyboard1',
            image: 'image1',
          ),
          qty: 2,
        ),
      );
    });

    test(
        "If there is not a same item in a list, the new item will be appended to the end of the List .",
        () {
      //Arrange
      Item newItem = Item(
        article: Article(
          id: 6,
          articleNo: '6' * 5,
          ean: '6' * 8,
          model: 'keyboard6',
          image: 'image6',
        ),
        qty: 1,
      );
      //Act
      itemList.addItem(newItem);
      //Assert
      expect(
        itemList.last,
        newItem,
      );
    });

    test(
        "If the list is empty, then a new item will be added as the first item.",
        () {
      //Arrange
      List<Item> newItemList = [];
      Item newItem = Item(
        article: Article(
          id: 6,
          articleNo: '6' * 5,
          ean: '6' * 8,
          model: 'keyboard6',
          image: 'image6',
        ),
        qty: 1,
      );
      //Act
      newItemList.addItem(newItem);
      //Assert
      expect(
        newItemList.first,
        newItem,
      );
    });
  });
}

List<Item> _generateItemList() {
  List<Item> items = <Item>[];
  for (int i = 0; i < 5; i++) {
    items.add(Item(
      article: Article(
        id: i + 1,
        articleNo: '${i + 1}' * 5,
        ean: '${i + 1}' * 8,
        model: 'keyboard${i + 1}',
        image: 'image${i + 1}',
      ),
      qty: 1,
    ));
  }
  return items;
}
