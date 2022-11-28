import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perixx_outbound/Domain/orderlist/order.dart';
import 'package:perixx_outbound/Presentation/size_config.dart';

typedef OrderCallback = void Function(Order order);
const ebay = 'assets/ebay.png';

class OrderListView extends StatelessWidget {
  final List<Order> orders;
  final OrderCallback onTap;

  const OrderListView({
    super.key,
    required this.orders,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          switch (order.status.name) {
            case 'scanned':
              return _showOrder(context, Colors.indigo, index, order);
            case 'shipped':
              return _showOrder(context, Colors.yellow, index, order);
            default:
              return _showOrder(context,
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

  Widget _showOrder(
      BuildContext context, Color cardColor, int index, Order order) {
    return Card(
      color: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      // shadowColor: Colors.black,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
      elevation: 40,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Theme(
          data: Theme.of(context)
              .copyWith(dividerColor: Colors.transparent), //new,
          child: ExpansionTile(
            backgroundColor: Colors.white,
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Text('${index + 1}'),
            ),
            title: _buildTitle(order),
            trailing: const SizedBox(),
            children: <Widget>[
              _orderDetails(order),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(Order order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ClipRect(
          child: Image.asset(
            ebay,
            width: 200,
            height: 200,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text.rich(
              TextSpan(
                text: 'Order ID : ',
                style: GoogleFonts.notoSans(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: order.orderNo,
                    style: GoogleFonts.notoSans(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Shipped to : ',
                style: GoogleFonts.notoSans(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: order.shippedTo,
                    style: GoogleFonts.notoSans(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Ordered Date : ',
                style: GoogleFonts.notoSans(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: order.orderedDate,
                    style: GoogleFonts.notoSans(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text.rich(
              TextSpan(
                text: 'Order Status : ',
                style: GoogleFonts.notoSans(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: order.status.name,
                    style: GoogleFonts.notoSans(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Scanned By : ',
                style: GoogleFonts.notoSans(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: order.scannedBy,
                    style: GoogleFonts.notoSans(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Shipped On : ',
                style: GoogleFonts.notoSans(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: order.shippedOn,
                    style: GoogleFonts.notoSans(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _orderDetails(Order order) {
    return SizedBox(
      height: (200 * order.items.length).toDouble(),
      child: ListView.builder(
        itemCount: order.items.length,
        itemBuilder: (context, index) {
          final item = order.items[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: ListTile(
              // leading: SizedBox(
              //   width: 500,
              //   child: Image.network(
              //     item.article.image,
              //     scale: 3.0,
              //   ),
              // ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: ClipRect(
                        child: Image.network(
                      item.article.image,
                      width: 150,
                      height: 150,
                    )),
                  ),
                  DataTable(
                    headingRowHeight: 0,
                    columns: const [
                      DataColumn(
                        label: Text(''),
                      ),
                      DataColumn(
                        label: Text(''),
                      ),
                      DataColumn(
                        label: Text(''),
                      ),
                    ],
                    // columns: [
                    //   DataColumn(
                    //     label: Text(
                    //       'Article No.',
                    //       style: GoogleFonts.notoSans(
                    //         fontSize: 30,
                    //         fontWeight: FontWeight.normal,
                    //       ),
                    //     ),
                    //   ),
                    //   DataColumn(
                    //     label: Text(
                    //       'Model',
                    //       style: GoogleFonts.notoSans(
                    //         fontSize: 30,
                    //         fontWeight: FontWeight.normal,
                    //       ),
                    //     ),
                    //   ),
                    //   DataColumn(
                    //     label: Text(
                    //       'Qty.',
                    //       style: GoogleFonts.notoSans(
                    //         fontSize: 30,
                    //         fontWeight: FontWeight.normal,
                    //       ),
                    //     ),
                    //   ),
                    // ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              item.article.articleNo,
                              style: GoogleFonts.notoSans(
                                fontSize: 30,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              item.article.model,
                              style: GoogleFonts.notoSans(
                                fontSize: 30,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          DataCell(
                            Text.rich(
                              TextSpan(
                                text: ' x ',
                                style: GoogleFonts.notoSans(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: '${item.qty}',
                                    style: GoogleFonts.notoSans(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 252, 95, 95),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
