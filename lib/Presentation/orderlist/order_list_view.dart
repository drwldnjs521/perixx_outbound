import 'package:flutter/material.dart';
import 'package:perixx_outbound/Domain/orderlist/order.dart';
import 'package:perixx_outbound/Presentation/shared_widgets.dart';

const ebay = 'assets/ebay.png';

class OrderListView extends StatelessWidget {
  final int index;
  final Order order;

  const OrderListView({
    super.key,
    required this.index,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    switch (order.status) {
      case 'scanned':
        return showOrder(
            context, const Color.fromARGB(255, 167, 255, 85), index, order);
      case 'shipped':
        return showOrder(context, Colors.yellow, index, order);
      default:
        return showOrder(
            context, const Color.fromARGB(255, 255, 254, 254), index, order);
    }
  }
  // final order = orders[index];
  // return ListTile(
  //   onTap: () {
  //     onTap(order);
  //   },
  //   title: Text(
  //     order.orderNo,
  //     softWrap: true,
  //     overflow: TextOverflow.ellipsis,
  //   ),
  // trailing: IconButton(
  //   onPressed: () async {
  //     final shouldDelete = await showDeleteDialog(context);
  //     if (shouldDelete) {
  //       onDeleteNote(note);
  //     }
  //   },
  //   icon: const Icon(Icons.delete),
  // ),

}
