import 'package:flutter/material.dart';
import 'package:perixx_outbound/Domain/orderlist/order.dart';
import 'package:perixx_outbound/Presentation/shared_widgets.dart';
import 'package:perixx_outbound/Presentation/size_config.dart';

const ebay = 'assets/ebay.png';

class OrderListView extends StatelessWidget {
  final List<Order> orders;

  const OrderListView({
    super.key,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          switch (order.status) {
            case 'scanned':
              debugPrint(order.assigner);
              return showOrder(context, const Color.fromARGB(255, 167, 255, 85),
                  index, order);
            case 'shipped':
              return showOrder(context, Colors.yellow, index, order);
            default:
              return showOrder(context,
                  const Color.fromARGB(255, 255, 254, 254), index, order);
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
        );
  }
}
