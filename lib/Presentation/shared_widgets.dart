import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:perixx_outbound/Application/login/auth_controller.dart';
import 'package:perixx_outbound/Application/orderlist/order_controller.dart';
import 'package:perixx_outbound/Domain/orderlist/order.dart';
import 'package:perixx_outbound/Presentation/orderlist/order_list_view.dart';
import 'package:perixx_outbound/Presentation/size_config.dart';
import 'package:perixx_outbound/Presentation/utilities/dialogs/logout_dialog.dart';

Widget showAppBar(
  BuildContext context,
  String title,
) {
  final authController = Get.find<AuthController>();
  final orderController = Get.find<OrderController>();
  return SliverAppBar(
    snap: true,
    pinned: true,
    floating: true,
    toolbarHeight: SizeConfig.safeVertical * 0.085,
    leading: Padding(
      padding: const EdgeInsets.fromLTRB(40, 20, 10, 10),
      child: IconButton(
        icon: const FaIcon(FontAwesomeIcons.bars),
        iconSize: 65,
        tooltip: 'Menu',
        onPressed: () {},
      ),
    ), //IconButton
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(80, 20, 70, 10),
        child: Row(
          children: <Widget>[
            if (ModalRoute.of(context)?.settings.name == "/ORDERLIST") ...[
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.barcode),
                iconSize: 65,
                tooltip: 'Scan',
                onPressed: () {
                  Get.toNamed('/SCAN');
                },
              ),
            ] else ...[
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.rectangleList),
                iconSize: 65,
                tooltip: 'Orderlist',
                onPressed: () async {
                  await orderController.getTodayOrder();
                  Get.offNamed('/ORDERLIST');
                },
              ), //IconButton
            ], //IconButton
            SizedBox(
              width: SizeConfig.safeHorizontal * 0.03,
            ),
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
              iconSize: 65,
              tooltip: 'Logout',
              onPressed: () async {
                final shouldLogout = await showLogOutDialog(
                  context,
                  authController.currentUser!.userName!,
                );
                if (shouldLogout) {
                  await authController.logOut();
                  Get.offAllNamed('/LOGIN');
                }
              },
            ), //IconButto
          ],
        ),
      )
    ],
    iconTheme: const IconThemeData(color: Color.fromARGB(255, 247, 247, 247)),

    flexibleSpace: FlexibleSpaceBar(
      background: Image.asset(
        'assets/perixxappbar.jpg',
        fit: BoxFit.fill,
      ),
    ),
    //FlexibleSpaceBar
    // expandedHeight: SizeConfig.safeVertical * 0.31,
    expandedHeight: SizeConfig.safeVertical * 0.27,
    collapsedHeight: SizeConfig.safeVertical * 0.1,

    backgroundColor: const Color.fromARGB(255, 195, 194, 194),
    forceElevated: true,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(20),
      child: Container(
        width: double.maxFinite,
        height: SizeConfig.safeVertical * 0.052,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(221, 89, 89, 89)),
          ),
        ),
      ),
    ),
  );
}

Widget showOrder(
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
        data:
            Theme.of(context).copyWith(dividerColor: Colors.transparent), //new,
        child: ExpansionTile(
          backgroundColor: Colors.white,
          leading: CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: Text('${index + 1}'),
          ),
          title: _buildTitle(order),
          trailing: const SizedBox(),
          children: <Widget>[
            orderDetails(order),
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
                  text: (order.status),
                  style: GoogleFonts.notoSans(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(255, 248, 101, 101),
                  ),
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              text: 'Assigner : ',
              style: GoogleFonts.notoSans(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: order.assigner,
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
                  text: order.shippedDate != null
                      ? DateFormat("yyyy-MM-dd").format(order.shippedDate!)
                      : "",
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

Widget orderDetails(Order order) {
  return GestureDetector(
    onTap: () => (order.status == "scanned" || order.status == "shipped")
        ? Get.toNamed("/PRINT", arguments: {"order": order})
        : null,
    child: SizedBox(
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
    ),
  );
}
