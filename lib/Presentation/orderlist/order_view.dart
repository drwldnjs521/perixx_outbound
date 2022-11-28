import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:perixx_outbound/Application/login/auth_service.dart';
import 'package:perixx_outbound/Application/orderlist/mysql.dart';
import 'package:perixx_outbound/Application/orderlist/order_service.dart';
import 'package:perixx_outbound/Domain/orderlist/order.dart';
import 'package:perixx_outbound/Presentation/orderlist/order_list_view.dart';
import 'package:perixx_outbound/Presentation/size_config.dart';
import 'package:perixx_outbound/Presentation/utilities/dialogs/logout_dialog.dart';

class OrderView extends StatefulWidget {
  const OrderView({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  String get _userName => AuthService.firebase().currentUser!.userName!;
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                menu,
                style: GoogleFonts.notoSans(
                  fontSize: 40,
                  color: Colors.blueGrey,
                ),
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
        itemsHeights.add(50);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        itemsHeights.add(44);
      }
    }
    return itemsHeights;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return FutureBuilder(
      future: Mysql.instance.createConnection(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            OrderService.mysql().open();
            return FutureBuilder(
              future: OrderService.mysql().getOrderBetweenWithStatus(
                begin: _startDate,
                end: _endDate,
                //status: _status.name,
                status: _status,
              ),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      final allOrders = snapshot.data as List<Order>;
                      return Scaffold(
                        body: CustomScrollView(
                          slivers: <Widget>[
                            _showAppBar(),
                            _showFilter(),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => SizedBox(
                                  height: SizeConfig.safeVertical,
                                  child: OrderListView(
                                    orders: allOrders,
                                    onTap: (order) {},
                                  ),
                                ),
                                childCount: allOrders.length,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Scaffold(
                        body: CustomScrollView(
                          slivers: <Widget>[
                            _showAppBar(),
                            _showFilter(),
                            SliverToBoxAdapter(
                              child: SizedBox(
                                width: SizeConfig.safeHorizontal * 0.3,
                                height: SizeConfig.safeVertical * 0.6,
                                child: Center(
                                  child: Text(
                                    'no_result'.tr,
                                    style: GoogleFonts.notoSans(
                                      fontSize: 100,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                  default:
                    return const Center(child: CircularProgressIndicator());
                }
              },
            );

          case ConnectionState.none:
            return Scaffold(
              body: CustomScrollView(
                slivers: <Widget>[
                  _showAppBar(),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 1000,
                      child: Center(
                        child: Text(
                          'no_database_connection'.tr,
                          style: GoogleFonts.notoSans(
                            fontSize: 100,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _showAppBar() {
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
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.barcode),
                iconSize: 65,
                tooltip: 'Scan',
                onPressed: () {
                  Get.offNamed('/SCAN');
                },
              ), //IconButton
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
                    _userName,
                  );
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
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
          child: const Center(
            child: Text(
              'In/Outbound',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(221, 89, 89, 89)),
            ),
          ),
        ),
      ),
    );
  }

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
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  style: const ButtonStyle(),
                  onPressed: () async {
                    DateTimeRange? pickedRange = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 5),
                      // initialDateRange: DateTimeRange(
                      //   end: DateTime(DateTime.now().year, DateTime.now().month,
                      //       DateTime.now().day + 13),
                      //   start: DateTime.now(),
                      // ),
                    );

                    if (pickedRange != null) {
                      String startDate =
                          DateFormat('yyyy-MM-dd').format(pickedRange.start);
                      String? endDate =
                          DateFormat('yyyy-MM-dd').format(pickedRange.end);
                      setState(() {
                        _startDate = startDate;
                        _endDate =
                            endDate; //set output date to TextField value.
                      });
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: SizeConfig.safeVertical * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(
                          Icons.date_range,
                          size: 60,
                        ),
                        if (_startDate == _endDate) ...[
                          Text(
                            " $_startDate",
                            style: GoogleFonts.notoSans(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ] else ...[
                          Text(
                            " $_startDate - $_endDate",
                            style: GoogleFonts.notoSans(
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                // const Icon(
                //   Icons.more_vert,
                //   size: 70,
                //   color: Color.fromARGB(159, 57, 57, 57),
                // ),
                const VerticalDivider(
                  color: Color.fromARGB(111, 68, 67, 67), //color of divider
                  width: 10, //width space of divider
                  thickness: 2, //thickness of divier line
                  indent: 15, //Spacing at the top of divider.
                  endIndent: 15, //Spacing at the bottom of divider.
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text(
                      'Selected Status',
                      style: GoogleFonts.notoSans(
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                        color: Colors.blueGrey,
                      ),
                    ),
                    value: _status,
                    // selectedItemBuilder: (BuildContext context) => menus
                    //     .map<Widget>((menu) => Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: <Widget>[
                    //             Padding(
                    //               padding: const EdgeInsets.only(left: 16.0),
                    //               child: menu.icon,
                    //             ),
                    //             Padding(
                    //               padding: const EdgeInsets.only(left: 20),
                    //               child: Text(
                    //                 menu.name,
                    //                 style: GoogleFonts.notoSans(
                    //                   fontSize: 40,
                    //                   fontWeight: FontWeight.w400,
                    //                   color: Colors.blueGrey,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ))
                    //     .toList(),
                    items: _dropdownItems,
                    customItemsHeights: _customsItemsHeight,
                    onChanged: (value) {
                      setState(() {
                        _status = value as String;
                      });
                    },
                    buttonHeight: 60,
                    icon: const FaIcon(FontAwesomeIcons.sortDown),
                    iconOnClick: const FaIcon(FontAwesomeIcons.sortUp),
                    iconSize: 50,
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
