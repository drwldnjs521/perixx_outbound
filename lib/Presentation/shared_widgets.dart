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
      padding: EdgeInsets.fromLTRB(
        SizeConfig.safeHorizontal * 0.02,
        SizeConfig.safeVertical * 0.001,
        SizeConfig.safeHorizontal * 0.02,
        SizeConfig.safeVertical * 0.001,
      ),
      child: IconButton(
        icon: const FaIcon(FontAwesomeIcons.bars),
        iconSize: SizeConfig.safeHorizontal * 0.08,
        tooltip: 'Menu',
        onPressed: () {},
      ),
    ), //IconButton
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(
          SizeConfig.safeHorizontal * 0.02,
          SizeConfig.safeVertical * 0.001,
          SizeConfig.safeHorizontal * 0.02,
          SizeConfig.safeVertical * 0.001,
        ),
        child: Row(
          children: <Widget>[
            if (ModalRoute.of(context)?.settings.name == "/ORDERLIST") ...[
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.barcode),
                iconSize: SizeConfig.safeHorizontal * 0.08,
                tooltip: 'Scan',
                onPressed: () {
                  Get.toNamed('/SCAN');
                },
              ),
            ] else ...[
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.rectangleList),
                iconSize: SizeConfig.safeHorizontal * 0.08,
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
              iconSize: SizeConfig.safeHorizontal * 0.08,
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
    expandedHeight: SizeConfig.safeVertical * 0.25,
    collapsedHeight: SizeConfig.safeVertical * 0.1,

    backgroundColor: const Color.fromARGB(255, 195, 194, 194),
    forceElevated: true,
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(SizeConfig.safeVertical * 0.001),
      child: Container(
        width: double.maxFinite,
        height: SizeConfig.safeVertical * 0.05,
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
            style: TextStyle(
                fontSize: SizeConfig.safeVertical * 0.025,
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(221, 89, 89, 89)),
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
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: cardColor,
        width: 2,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(15.0),
      ),
    ),
    // shadowColor: Colors.black,
    margin: EdgeInsets.fromLTRB(
      SizeConfig.safeHorizontal * 0.02,
      SizeConfig.safeVertical * 0.005,
      SizeConfig.safeHorizontal * 0.02,
      SizeConfig.safeVertical * 0.01,
    ),
    elevation: 40,
    child: Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent), //new,
      child: ExpansionTile(
        childrenPadding: EdgeInsets.symmetric(
          vertical: SizeConfig.safeHorizontal * 0.01,
          horizontal: SizeConfig.safeHorizontal * 0.05,
        ),
        tilePadding: EdgeInsets.only(
          left: SizeConfig.safeHorizontal * 0.02,
          right: SizeConfig.safeHorizontal * 0.02,
        ),
        backgroundColor: Colors.white,
        // leading: CircleAvatar(
        //   radius: SizeConfig.safeHorizontal * 0.03,
        //   backgroundColor: Colors.blueGrey,
        //   child: Text(
        //     '${index + 1}',
        //     style: GoogleFonts.notoSans(
        //       fontSize: SizeConfig.safeHorizontal * 0.03,
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        // ),
        leading: SizedBox(
          width: SizeConfig.safeHorizontal * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRect(
                    child: CircleAvatar(
                      radius: SizeConfig.safeHorizontal * 0.03,
                      backgroundColor: const Color.fromARGB(255, 71, 110, 129),
                      child: Text(
                        '${index + 1}',
                        style: GoogleFonts.notoSans(
                          fontSize: SizeConfig.safeHorizontal * 0.03,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset(
                ebay,
                height: SizeConfig.safeVertical * 0.04,
              ),
            ],
          ),
        ),
        title: _buildTitle(order),
        children: <Widget>[
          const Divider(
            thickness: 0.5,
            color: Color.fromARGB(202, 83, 82, 82),
          ),
          orderDetails(order),
          if (order.status == 'shipped' || order.status == 'scanned') ...[
            Padding(
              padding: EdgeInsets.all(SizeConfig.safeHorizontal * 0.03),
              child: SizedBox(
                height: SizeConfig.safeVertical * 0.05,
                child: FloatingActionButton.extended(
                  backgroundColor: const Color.fromARGB(163, 27, 108, 30),
                  splashColor: Colors.yellow,
                  focusElevation: 50,
                  onPressed: () =>
                      Get.toNamed("/PRINT", arguments: {"order": order}),
                  label: Text(
                    'Go to print',
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w800,
                      fontSize: SizeConfig.safeHorizontal * 0.035,
                    ),
                  ),
                  icon: FaIcon(
                    FontAwesomeIcons.print,
                    size: SizeConfig.safeHorizontal * 0.04,
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    ),
  );
}

Widget _buildTitle(Order order) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text.rich(
        TextSpan(
          text: 'Order ID : ',
          style: GoogleFonts.notoSans(
            fontSize: SizeConfig.safeHorizontal * 0.03,
            fontWeight: FontWeight.w600,
          ),
          children: <InlineSpan>[
            TextSpan(
              text: order.orderNo,
              style: GoogleFonts.notoSans(
                fontSize: SizeConfig.safeHorizontal * 0.03,
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
            fontSize: SizeConfig.safeHorizontal * 0.03,
            fontWeight: FontWeight.w600,
          ),
          children: <InlineSpan>[
            TextSpan(
              text: order.shippedTo,
              style: GoogleFonts.notoSans(
                fontSize: SizeConfig.safeHorizontal * 0.03,
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
            fontSize: SizeConfig.safeHorizontal * 0.03,
            fontWeight: FontWeight.w600,
          ),
          children: <InlineSpan>[
            TextSpan(
              text: order.orderedDate,
              style: GoogleFonts.notoSans(
                fontSize: SizeConfig.safeHorizontal * 0.03,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      Text.rich(
        TextSpan(
          text: 'Order Status : ',
          style: GoogleFonts.notoSans(
            fontSize: SizeConfig.safeHorizontal * 0.03,
            fontWeight: FontWeight.w600,
          ),
          children: <InlineSpan>[
            TextSpan(
              text: (order.status),
              style: GoogleFonts.notoSans(
                fontSize: SizeConfig.safeHorizontal * 0.03,
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
            fontSize: SizeConfig.safeHorizontal * 0.03,
            fontWeight: FontWeight.w600,
          ),
          children: <InlineSpan>[
            TextSpan(
              text: order.assigner,
              style: GoogleFonts.notoSans(
                fontSize: SizeConfig.safeHorizontal * 0.03,
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
            fontSize: SizeConfig.safeHorizontal * 0.03,
            fontWeight: FontWeight.w600,
          ),
          children: <InlineSpan>[
            TextSpan(
              text: order.shippedDate != null
                  ? DateFormat("yyyy-MM-dd").format(order.shippedDate!)
                  : "",
              style: GoogleFonts.notoSans(
                fontSize: SizeConfig.safeHorizontal * 0.03,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    ],
  );
}
// Widget _buildTitle(Order order) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: <Widget>[
//       ClipRect(
//         child: Image.asset(
//           ebay,
//           width: SizeConfig.safeHorizontal * 0.2,
//           height: SizeConfig.safeHorizontal * 0.2,
//         ),
//       ),
//       Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text.rich(
//             TextSpan(
//               text: 'Order ID : ',
//               style: GoogleFonts.notoSans(
//                 fontSize: SizeConfig.safeHorizontal * 0.03,
//                 fontWeight: FontWeight.w600,
//               ),
//               children: <InlineSpan>[
//                 TextSpan(
//                   text: order.orderNo,
//                   style: GoogleFonts.notoSans(
//                     fontSize: SizeConfig.safeHorizontal * 0.03,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Text.rich(
//             TextSpan(
//               text: 'Shipped to : ',
//               style: GoogleFonts.notoSans(
//                 fontSize: SizeConfig.safeHorizontal * 0.03,
//                 fontWeight: FontWeight.w600,
//               ),
//               children: <InlineSpan>[
//                 TextSpan(
//                   text: order.shippedTo,
//                   style: GoogleFonts.notoSans(
//                     fontSize: SizeConfig.safeHorizontal * 0.03,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Text.rich(
//             TextSpan(
//               text: 'Ordered Date : ',
//               style: GoogleFonts.notoSans(
//                 fontSize: SizeConfig.safeHorizontal * 0.03,
//                 fontWeight: FontWeight.w600,
//               ),
//               children: <InlineSpan>[
//                 TextSpan(
//                   text: order.orderedDate,
//                   style: GoogleFonts.notoSans(
//                     fontSize: SizeConfig.safeHorizontal * 0.03,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//       Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text.rich(
//             TextSpan(
//               text: 'Order Status : ',
//               style: GoogleFonts.notoSans(
//                 fontSize: SizeConfig.safeHorizontal * 0.03,
//                 fontWeight: FontWeight.w600,
//               ),
//               children: <InlineSpan>[
//                 TextSpan(
//                   text: (order.status),
//                   style: GoogleFonts.notoSans(
//                     fontSize: SizeConfig.safeHorizontal * 0.03,
//                     fontWeight: FontWeight.normal,
//                     color: const Color.fromARGB(255, 248, 101, 101),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Text.rich(
//             TextSpan(
//               text: 'Assigner : ',
//               style: GoogleFonts.notoSans(
//                 fontSize: SizeConfig.safeHorizontal * 0.03,
//                 fontWeight: FontWeight.w600,
//               ),
//               children: <InlineSpan>[
//                 TextSpan(
//                   text: order.assigner,
//                   style: GoogleFonts.notoSans(
//                     fontSize: SizeConfig.safeHorizontal * 0.03,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Text.rich(
//             TextSpan(
//               text: 'Shipped On : ',
//               style: GoogleFonts.notoSans(
//                 fontSize: SizeConfig.safeHorizontal * 0.03,
//                 fontWeight: FontWeight.w600,
//               ),
//               children: <InlineSpan>[
//                 TextSpan(
//                   text: order.shippedDate != null
//                       ? DateFormat("yyyy-MM-dd").format(order.shippedDate!)
//                       : "",
//                   style: GoogleFonts.notoSans(
//                     fontSize: SizeConfig.safeHorizontal * 0.03,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     ],
//   );
// }

// Widget orderDetails(Order order) {
//   return GestureDetector(
//     onTap: () => (order.status == "scanned" || order.status == "shipped")
//         ? Get.toNamed("/PRINT", arguments: {"order": order})
//         : null,
//     child: SizedBox(
//       height: (SizeConfig.safeVertical * 0.15 * order.items.length).toDouble(),
//       child: ListView.builder(
//         itemCount: order.items.length,
//         itemBuilder: (context, index) {
//           final item = order.items[index];
//           return Padding(
//             padding: EdgeInsets.fromLTRB(
//               SizeConfig.safeHorizontal * 0.02,
//               SizeConfig.safeVertical * 0.01,
//               SizeConfig.safeHorizontal * 0.02,
//               SizeConfig.safeVertical * 0.0,
//             ),
//             child: ListTile(
//               // leading: SizedBox(
//               //   width: 500,
//               //   child: Image.network(
//               //     item.article.image,
//               //     scale: 3.0,
//               //   ),
//               // ),
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Center(
//                     child: ClipRect(
//                         child: Image.network(
//                       item.article.image,
//                       width: SizeConfig.safeHorizontal * 0.18,
//                       height: SizeConfig.safeHorizontal * 0.18,
//                     )),
//                   ),
//                   DataTable(
//                     headingRowHeight: 0,
//                     columns: const [
//                       DataColumn(
//                         label: Text(''),
//                       ),
//                       DataColumn(
//                         label: Text(''),
//                       ),
//                       DataColumn(
//                         label: Text(''),
//                       ),
//                     ],
//                     // columns: [
//                     //   DataColumn(
//                     //     label: Text(
//                     //       'Article No.',
//                     //       style: GoogleFonts.notoSans(
//                     //         fontSize: 30,
//                     //         fontWeight: FontWeight.normal,
//                     //       ),
//                     //     ),
//                     //   ),
//                     //   DataColumn(
//                     //     label: Text(
//                     //       'Model',
//                     //       style: GoogleFonts.notoSans(
//                     //         fontSize: 30,
//                     //         fontWeight: FontWeight.normal,
//                     //       ),
//                     //     ),
//                     //   ),
//                     //   DataColumn(
//                     //     label: Text(
//                     //       'Qty.',
//                     //       style: GoogleFonts.notoSans(
//                     //         fontSize: 30,
//                     //         fontWeight: FontWeight.normal,
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ],
//                     rows: [
//                       DataRow(
//                         cells: [
//                           DataCell(
//                             Text(
//                               item.article.articleNo,
//                               style: GoogleFonts.notoSans(
//                                 fontSize: SizeConfig.safeHorizontal * 0.03,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                           ),
//                           DataCell(
//                             Text(
//                               item.article.model,
//                               style: GoogleFonts.notoSans(
//                                 fontSize: SizeConfig.safeHorizontal * 0.03,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                           ),
//                           DataCell(
//                             Text.rich(
//                               TextSpan(
//                                 text: ' x ',
//                                 style: GoogleFonts.notoSans(
//                                   fontSize: SizeConfig.safeHorizontal * 0.03,
//                                   fontWeight: FontWeight.normal,
//                                 ),
//                                 children: <InlineSpan>[
//                                   TextSpan(
//                                     text: '${item.qty}',
//                                     style: GoogleFonts.notoSans(
//                                       fontSize:
//                                           SizeConfig.safeHorizontal * 0.03,
//                                       fontWeight: FontWeight.bold,
//                                       color: const Color.fromARGB(
//                                           255, 252, 95, 95),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     ),
//   );

Widget orderDetails(Order order) {
  return SizedBox(
    height: SizeConfig.safeVertical * 0.12 * order.items.length,
    child: ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: order.items.length,
      itemBuilder: (context, index) {
        final item = order.items[index];
        return Card(
          color: const Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            side: BorderSide(
              // border color
              color: Colors.blue.shade200,
              // border thickness
              width: 1,
            ),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            minVerticalPadding: 0,
            leading: ClipRect(
              child: Image.network(
                item.article.image,
                width: SizeConfig.safeHorizontal * 0.25,
              ),
            ),
            title: Text(
              item.article.model,
              style: GoogleFonts.notoSans(
                fontSize: SizeConfig.safeHorizontal * 0.035,
                fontWeight: FontWeight.normal,
              ),
            ),
            subtitle: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  item.article.articleNo,
                  style: GoogleFonts.notoSans(
                    fontSize: SizeConfig.safeHorizontal * 0.03,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: ' x ',
                    style: GoogleFonts.notoSans(
                      fontSize: SizeConfig.safeHorizontal * 0.03,
                      fontWeight: FontWeight.normal,
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        text: '${item.qty}',
                        style: GoogleFonts.notoSans(
                          fontSize: SizeConfig.safeHorizontal * 0.03,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 252, 95, 95),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

// Widget orderDetailsColumn(Order order) {
//   return SizedBox(
//     height: (SizeConfig.safeVertical * 0.15 * order.items.length).toDouble(),
//     child: ListView.builder(
//       itemCount: order.items.length,
//       itemBuilder: (context, index) {
//         final item = order.items[index];
//         return Padding(
//           padding: EdgeInsets.fromLTRB(
//             SizeConfig.safeHorizontal * 0.02,
//             SizeConfig.safeVertical * 0.01,
//             SizeConfig.safeHorizontal * 0.02,
//             SizeConfig.safeVertical * 0.0,
//           ),
//           child: ListTile(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Center(
//                   child: ClipRect(
//                       child: Image.network(
//                     item.article.image,
//                     width: SizeConfig.safeHorizontal * 0.18,
//                     height: SizeConfig.safeHorizontal * 0.18,
//                   )),
//                 ),
//                 DataTable(
//                   columnSpacing: SizeConfig.safeHorizontal * 0.04,
//                   headingRowHeight: 0,
//                   columns: const [
//                     DataColumn(
//                       label: SizedBox(
//                         child: Text(''),
//                       ),
//                     ),
//                     DataColumn(
//                       label: SizedBox(
//                         child: Text(''),
//                       ),
//                     ),
//                     DataColumn(
//                       label: SizedBox(
//                         child: Text(''),
//                       ),
//                     ),
//                   ],
//                   rows: [
//                     DataRow(
//                       cells: [
//                         DataCell(
//                           Text(
//                             item.article.articleNo,
//                             style: GoogleFonts.notoSans(
//                               fontSize: SizeConfig.safeHorizontal * 0.04,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         ),
//                         DataCell(
//                           Text(
//                             item.article.model,
//                             style: GoogleFonts.notoSans(
//                               fontSize: SizeConfig.safeHorizontal * 0.04,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         ),
//                         DataCell(
//                           Text.rich(
//                             TextSpan(
//                               text: ' x ',
//                               style: GoogleFonts.notoSans(
//                                 fontSize: SizeConfig.safeHorizontal * 0.04,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                               children: <InlineSpan>[
//                                 TextSpan(
//                                   text: '${item.qty}',
//                                   style: GoogleFonts.notoSans(
//                                     fontSize: SizeConfig.safeHorizontal * 0.04,
//                                     fontWeight: FontWeight.bold,
//                                     color:
//                                         const Color.fromARGB(255, 252, 95, 95),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     ),
//   );
// }
