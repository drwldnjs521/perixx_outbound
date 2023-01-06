import 'package:flutter_test/flutter_test.dart';
import 'package:perixx_outbound/Domain/orderlist/article.dart';
import 'package:perixx_outbound/Domain/orderlist/item.dart';
import 'package:perixx_outbound/Domain/orderlist/order.dart';

void main() {
  late List<Order> orderList;
  setUp(() {
    orderList = _generateOrderList();
  });
  group('Add orders to an list', () {
    test(
        "If there is a same order in the list, the items of this order will be integrated.",
        () {
      //Arrange
      Order newOrder = Order(
        createdDate: DateTime.now(),
        orderNo: '1' * 5,
        items: [
          Item(
            article: Article(
              id: 1,
              articleNo: '1' * 5,
              ean: '1' * 8,
              model: 'keyboard1',
              image: 'image1',
            ),
            qty: 2,
          )
        ],
        labelNo: '1' * 9,
        shippedTo: 'DE',
        cn23: '1' * 9,
        assigner: 'PERIXX',
        shippedDate: null,
      );
      //Act
      orderList.addOrder(newOrder);
      //Assert
      expect(
        orderList.first,
        Order(
          createdDate: DateTime.now(),
          orderNo: '1' * 5,
          items: [
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
            Item(
              article: Article(
                id: 2,
                articleNo: '2' * 5,
                ean: '2' * 8,
                model: 'keyboard2',
                image: 'image2',
              ),
              qty: 1,
            )
          ],
          labelNo: '1' * 9,
          shippedTo: 'DE',
          cn23: '1' * 9,
          assigner: 'PERIXX',
          shippedDate: null,
        ),
      );
    });

    test(
        "If there is not a same order in the list, the new order will be appended to the end of the List .",
        () {
      //Arrange
      Order newOrder = Order(
        createdDate: DateTime.now(),
        orderNo: '6' * 5,
        items: [
          Item(
            article: Article(
              id: 1,
              articleNo: '1' * 5,
              ean: '1' * 8,
              model: 'keyboard1',
              image: 'image1',
            ),
            qty: 2,
          )
        ],
        labelNo: '6' * 9,
        shippedTo: 'DE',
        cn23: '6' * 9,
        assigner: 'PERIXX',
        shippedDate: null,
      );
      //Act
      orderList.addOrder(newOrder);
      //Assert
      expect(
        orderList.last,
        newOrder,
      );
    });

    test(
        "If the list is empty, then a new order will be added as the first order.",
        () {
      //Arrange
      List<Order> newOrderList = [];
      Order newOrder = Order(
        createdDate: DateTime.now(),
        orderNo: '1' * 5,
        items: [
          Item(
            article: Article(
              id: 1,
              articleNo: '1' * 5,
              ean: '1' * 8,
              model: 'keyboard1',
              image: 'image1',
            ),
            qty: 2,
          )
        ],
        labelNo: '1' * 9,
        shippedTo: 'DE',
        cn23: '1' * 9,
        assigner: 'PERIXX',
        shippedDate: null,
      );
      //Act
      newOrderList.addOrder(newOrder);
      //Assert
      expect(
        newOrderList.first,
        newOrder,
      );
    });
  });
  group('Test instance attributes', () {
    test('A \'created date\' will be formed as "yyyy-MM-dd"', () {
      //Arrange
      Order order = Order(
        createdDate: DateTime.now(),
        orderNo: '1' * 5,
        items: [
          Item(
            article: Article(
              id: 1,
              articleNo: '1' * 5,
              ean: '1' * 8,
              model: 'keyboard1',
              image: 'image1',
            ),
            qty: 2,
          )
        ],
        labelNo: '1' * 9,
        shippedTo: 'DE',
        cn23: '1' * 9,
        assigner: 'PERIXX',
        shippedDate: null,
      );
      //Act
      //Assert
      expect(
        order.orderedDate,
        '2022-12-25',
      );
    });
    test(
        'The status of an order just with an attribute \'assigner\' is  \'scanned\'',
        () {
      //Arrange
      Order order = Order(
        createdDate: DateTime.now(),
        orderNo: '1' * 5,
        items: [
          Item(
            article: Article(
              id: 1,
              articleNo: '1' * 5,
              ean: '1' * 8,
              model: 'keyboard1',
              image: 'image1',
            ),
            qty: 2,
          )
        ],
        labelNo: '1' * 9,
        shippedTo: 'DE',
        cn23: '1' * 9,
        assigner: 'PERIXX',
        shippedDate: null,
      );

      //Act
      //Assert
      expect(
        order.status,
        'scanned',
      );
    });
    test(
        'The status of an order with attributes \'assigner\' and \'shippedDate\' is  \'shipped\'',
        () {
      //Arrange
      Order order = Order(
        createdDate: DateTime.now(),
        orderNo: '1' * 5,
        items: [
          Item(
            article: Article(
              id: 1,
              articleNo: '1' * 5,
              ean: '1' * 8,
              model: 'keyboard1',
              image: 'image1',
            ),
            qty: 2,
          )
        ],
        labelNo: '1' * 9,
        shippedTo: 'DE',
        cn23: '1' * 9,
        assigner: 'PERIXX',
        shippedDate: DateTime.now(),
      );

      //Act
      //Assert
      expect(
        order.status,
        'shipped',
      );
    });
  });
  group('Check items within an order', () {
    test('An order has same items as in the Orderlist', () {
      //Arrange
    });
  });
}

List<Order> _generateOrderList() {
  List<Order> orders = <Order>[];
  for (int i = 0; i < 5; i++) {
    orders.add(Order(
      createdDate: DateTime.now(),
      orderNo: '${i + 1}' * 5,
      items: [
        Item(
          article: Article(
            id: i + 1,
            articleNo: '${i + 1}' * 5,
            ean: '${i + 1}' * 8,
            model: 'keyboard${i + 1}',
            image: 'image${i + 1}',
          ),
          qty: 1,
        ),
        Item(
          article: Article(
            id: i + 2,
            articleNo: '${i + 2}' * 5,
            ean: '${i + 2}' * 8,
            model: 'keyboard${i + 2}',
            image: 'image${i + 2}',
          ),
          qty: 1,
        )
      ],
      labelNo: '${i + 1}' * 9,
      shippedTo: 'DE',
      cn23: '${i + 1}' * 9,
      assigner: 'PERIXX',
      shippedDate: null,
    ));
  }
  return orders;
}
