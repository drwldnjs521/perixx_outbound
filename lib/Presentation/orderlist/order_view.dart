import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:perixx_outbound/Application/app_state.dart';
import 'package:perixx_outbound/Application/orderlist/order_controller.dart';
import 'package:perixx_outbound/Presentation/orderlist/order_list_view.dart';
import 'package:perixx_outbound/Presentation/shared_widgets.dart';
import 'package:perixx_outbound/Presentation/size_config.dart';

class OrderView extends StatefulWidget {
  const OrderView({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final _orderController = Get.find<OrderController>();

  String _startDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String _endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  // DropDownItem _status = menus[0];
  String _status = 'all';

  List<String> menus = ['all', 'processing', 'scanned', 'shipped'];

  List<DropdownMenuItem<String>> get _dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [];
    for (var menu in menus) {
      menuItems.addAll(
        [
          DropdownMenuItem(
            value: menu,
            child: Text(
              menu,
              style: GoogleFonts.notoSans(
                fontSize: SizeConfig.safeHorizontal * 0.05,
                color: Colors.blueGrey,
              ),
            ),
          ),
          if (menu != menus.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(
                color: Color.fromARGB(107, 83, 80, 80),
              ),
            ),
        ],
      );
    }
    return menuItems;
  }

  // List<DropdownMenuItem<DropDownItem>> get _dropdownItems {
  //   List<DropdownMenuItem<DropDownItem>> menuItems = [];
  //   for (var menu in menus) {
  //     menuItems.addAll(
  //       [
  //         DropdownMenuItem(
  //           value: menu,
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 4.0),
  //             child: Text(
  //               menu.name,
  //               style: GoogleFonts.notoSans(
  //                 fontSize: 40,
  //                 color: Colors.blueGrey,
  //               ),
  //             ),
  //           ),
  //         ),
  //         if (menu != menus.last)
  //           const DropdownMenuItem<DropDownItem>(
  //             enabled: false,
  //             child: Divider(
  //               color: Color.fromARGB(107, 83, 80, 80),
  //             ),
  //           ),
  //       ],
  //     );
  //   }

  //   return menuItems;
  // }

  List<double> get _customsItemsHeight {
    List<double> itemsHeights = [];
    for (var i = 0; i < (menus.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(SizeConfig.safeVertical * 0.05);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        itemsHeights.add(SizeConfig.safeVertical * 0.015);
      }
    }
    return itemsHeights;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: CustomScrollView(
        slivers: <Widget>[
          showAppBar(
            context,
            "In/OutBound",
          ),
          _showFilter(),
          Obx(
            () => _orderController.pageState.value == AppState.loading
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.safeVertical * 0.22),
                          child: const CircularProgressIndicator()),
                    ),
                  )
                : (_orderController.orderList.isNotEmpty)
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final order = _orderController.orderList[index];
                            return OrderListView(index: index, order: order);
                          },
                          childCount: _orderController.orderList.length,
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.safeVertical * 0.22),
                            child: Text(
                              'no_result'.tr,
                              style: GoogleFonts.notoSans(
                                fontSize: SizeConfig.safeHorizontal * 0.1,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
          ),
          // SliverToBoxAdapter(
          //   child: SizedBox(height: SizeConfig.safeVertical * 0.1),
          // )
        ],
      ),
      bottomSheet: _status == "scanned"
          ? GestureDetector(
              child: SizedBox(
                width: double.infinity,
                height: SizeConfig.safeVertical * 0.09,
                child: Card(
                  margin: EdgeInsets.fromLTRB(
                    SizeConfig.safeHorizontal * 0.02,
                    SizeConfig.safeVertical * 0.01,
                    SizeConfig.safeHorizontal * 0.02,
                    SizeConfig.safeVertical * 0.01,
                  ),
                  color: Colors.lightBlue,
                  elevation: 40,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'swipe'.tr,
                        style: GoogleFonts.notoSans(
                          fontSize: SizeConfig.safeHorizontal * 0.05,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 230, 228, 228),
                        ),
                        children: [
                          TextSpan(
                            text: "    >>>",
                            style: GoogleFonts.notoSans(
                              fontSize: SizeConfig.safeHorizontal * 0.05,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(205, 227, 0, 204),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              onHorizontalDragUpdate: (details) async {
                if (details.delta.direction >= 0) {
                  if (_orderController.orderList.isNotEmpty) {
                    await _orderController.updateStatusToShipped(
                        orderList: _orderController.orderList);
                    await _orderController.getOrderBetweenByStatus(
                        start: _startDate, end: _endDate, status: _status);
                  }
                }
              },
            )
          : null,
    );
  }
  //                   } else {
  //                     return Scaffold(
  //                       body: CustomScrollView(
  //                         slivers: <Widget>[
  //                           _showAppBar(),
  //                           _showFilter(),
  //                           SliverToBoxAdapter(
  //                             child: SizedBox(
  //                               width: SizeConfig.safeHorizontal * 0.3,
  //                               height: SizeConfig.safeVertical * 0.6,
  //                               child: Center(
  //                                 child: Text(
  //                                   'no_result'.tr,
  //                                   style: GoogleFonts.notoSans(
  //                                     fontSize: 100,
  //                                     fontWeight: FontWeight.w500,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //                   }

  //                 default:
  //                   return const Center(child = const CircularProgressIndicator());
  //               }
  //             },
  //           );

  //         case ConnectionState.none:
  //           return Scaffold(
  //             body = CustomScrollView(
  //               slivers: <Widget>[
  //                 _showAppBar(),
  //                 SliverToBoxAdapter(
  //                   child: SizedBox(
  //                     height: 1000,
  //                     child: Center(
  //                       child: Text(
  //                         'no_database_connection'.tr,
  //                         style: GoogleFonts.notoSans(
  //                           fontSize: 100,
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         default:
  //           return const Center(child = const CircularProgressIndicator());
  //       }
  //     },
  //   );
  // }

  // Widget _showFilter() {
  //   return SliverToBoxAdapter(
  //     child: Card(
  //       elevation: 40,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(
  //           Radius.circular(15.0),
  //         ),
  //         side: BorderSide(
  //           color: Color.fromARGB(255, 34, 34, 34),
  //         ),
  //       ),
  //       margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
  //       child: Padding(
  //         padding: const EdgeInsets.all(5),
  //         child: IntrinsicHeight(
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: <Widget>[
  //               TextButton(
  //                 style: const ButtonStyle(),
  //                 onPressed: () async {
  //                   DateTimeRange? pickedRange = await showDateRangePicker(
  //                     context: context,
  //                     firstDate: DateTime(DateTime.now().year - 1),
  //                     lastDate: DateTime(DateTime.now().year + 5),
  //                     // initialDateRange: DateTimeRange(
  //                     //   end: DateTime(DateTime.now().year, DateTime.now().month,
  //                     //       DateTime.now().day + 13),
  //                     //   start: DateTime.now(),
  //                     // ),
  //                   );

  //                   if (pickedRange != null) {
  //                     String startDate =
  //                         DateFormat('yyyy-MM-dd').format(pickedRange.start);
  //                     String? endDate =
  //                         DateFormat('yyyy-MM-dd').format(pickedRange.end);
  //                     setState(() {
  //                       _startDate = startDate;
  //                       _endDate =
  //                           endDate; //set output date to TextField value.
  //                     });
  //                   }
  //                   orderController.getOrderBetweenByStatus(
  //                       _startDate, _endDate, _status);
  //                 },
  //                 child: Container(
  //                   alignment: Alignment.center,
  //                   height: SizeConfig.safeVertical * 0.05,
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: <Widget>[
  //                       const Icon(
  //                         Icons.date_range,
  //                         size: 60,
  //                       ),
  //                       if (_startDate == _endDate) ...[
  //                         Text(
  //                           " $_startDate",
  //                           style: GoogleFonts.notoSans(
  //                             fontSize: 40,
  //                             fontWeight: FontWeight.w500,
  //                             color: Colors.blueGrey,
  //                           ),
  //                         ),
  //                       ] else ...[
  //                         Text(
  //                           " $_startDate - $_endDate",
  //                           style: GoogleFonts.notoSans(
  //                             fontSize: 40,
  //                             fontWeight: FontWeight.w400,
  //                           ),
  //                         ),
  //                       ],
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               // const Icon(
  //               //   Icons.more_vert,
  //               //   size: 70,
  //               //   color: Color.fromARGB(159, 57, 57, 57),
  //               // ),
  //               const VerticalDivider(
  //                 color: Color.fromARGB(111, 68, 67, 67), //color of divider
  //                 width: 10, //width space of divider
  //                 thickness: 2, //thickness of divier line
  //                 indent: 15, //Spacing at the top of divider.
  //                 endIndent: 15, //Spacing at the bottom of divider.
  //               ),
  //               DropdownButtonHideUnderline(
  //                 child: DropdownButton2(
  //                   hint: Text(
  //                     'Selected Status',
  //                     style: GoogleFonts.notoSans(
  //                       fontSize: 40,
  //                       fontWeight: FontWeight.w400,
  //                       color: Colors.blueGrey,
  //                     ),
  //                   ),
  //                   value: _status,
  //                   // selectedItemBuilder: (BuildContext context) => menus
  //                   //     .map<Widget>((menu) => Row(
  //                   //           mainAxisAlignment: MainAxisAlignment.center,
  //                   //           children: <Widget>[
  //                   //             Padding(
  //                   //               padding: const EdgeInsets.only(left: 16.0),
  //                   //               child: menu.icon,
  //                   //             ),
  //                   //             Padding(
  //                   //               padding: const EdgeInsets.only(left: 20),
  //                   //               child: Text(
  //                   //                 menu.name,
  //                   //                 style: GoogleFonts.notoSans(
  //                   //                   fontSize: 40,
  //                   //                   fontWeight: FontWeight.w400,
  //                   //                   color: Colors.blueGrey,
  //                   //                 ),
  //                   //               ),
  //                   //             ),
  //                   //           ],
  //                   //         ))
  //                   //     .toList(),
  //                   items: _dropdownItems,
  //                   customItemsHeights: _customsItemsHeight,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       _status = value as String;
  //                     });
  //                     orderController.getOrderBetweenByStatus(
  //                         _startDate, _endDate, _status);
  //                   },
  //                   buttonHeight: 60,
  //                   icon: const FaIcon(FontAwesomeIcons.sortDown),
  //                   iconOnClick: const FaIcon(FontAwesomeIcons.sortUp),
  //                   iconSize: 50,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget _showFilter() {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 40,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
          side: BorderSide(
            color: Color.fromARGB(255, 34, 34, 34),
          ),
        ),
        // margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        margin: EdgeInsets.fromLTRB(
          SizeConfig.safeHorizontal * 0.02,
          SizeConfig.safeVertical * 0.01,
          SizeConfig.safeHorizontal * 0.02,
          SizeConfig.safeVertical * 0.01,
        ),

        child: Padding(
          padding: EdgeInsets.all(SizeConfig.safeHorizontal * 0.01),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: () async {
                    DateTimeRange? pickedRange = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                      // initialDateRange: DateTimeRange(
                      //   end: DateTime(DateTime.now().year, DateTime.now().month,
                      //       DateTime.now().day + 13),
                      //   start: DateTime.now(),
                      // ),
                    );

                    if (pickedRange != null) {
                      String startDate =
                          DateFormat('yyyy-MM-dd').format(pickedRange.start);
                      String endDate =
                          DateFormat('yyyy-MM-dd').format(pickedRange.end);
                      setState(() {
                        _startDate = startDate;
                        _endDate = endDate;
                      });
                      await _orderController.getOrderBetweenByStatus(
                          start: _startDate, end: _endDate, status: _status);
                    }

                    // orderController.getOrderBetweenByStatus(
                    //     _startDate, _endDate, _status);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: SizeConfig.safeVertical * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.date_range,
                          size: SizeConfig.safeHorizontal * 0.08,
                        ),
                        if (_startDate == _endDate) ...[
                          Text(
                            " $_startDate",
                            style: GoogleFonts.notoSans(
                              fontSize: SizeConfig.safeHorizontal * 0.05,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ] else ...[
                          Text(
                            "$_startDate - $_endDate",
                            style: GoogleFonts.notoSans(
                              fontSize: SizeConfig.safeHorizontal * 0.03,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: Color.fromARGB(111, 68, 67, 67), //color of divider
                  width: 8, //width space of divider
                  thickness: 2, //thickness of divier line
                  indent: 10, //Spacing at the top of divider.
                  endIndent: 10, //Spacing at the bottom of divider.
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    value: _status,
                    items: _dropdownItems,
                    customItemsHeights: _customsItemsHeight,
                    onChanged: (value) async {
                      setState(() {
                        _status = value as String;
                      });
                      await _orderController.getOrderBetweenByStatus(
                          start: _startDate, end: _endDate, status: _status);
                    },
                    buttonHeight: SizeConfig.safeVertical * 0.05,
                    icon: const FaIcon(FontAwesomeIcons.caretDown),
                    iconOnClick: const FaIcon(FontAwesomeIcons.caretUp),
                    iconSize: SizeConfig.safeHorizontal * 0.05,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
