import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:perixx_outbound/Application/login/auth_service.dart';
import 'package:perixx_outbound/Application/orderlist/mysql.dart';
import 'package:perixx_outbound/Application/orderlist/order_service.dart';
import 'package:perixx_outbound/Presentation/utilities/dialogs/logout_dialog.dart';
import 'package:perixx_outbound/constants/routes.dart';

class OrderListView extends StatefulWidget {
  const OrderListView({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderListView> createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  String get userName => AuthService.firebase().currentUser!.userName!;
  // late MySqlConnection conn;
  TextEditingController dateInput = TextEditingController();

  // MySqlConnection mySqlConnection = await Mysql.getConnection();

  @override
  Widget build(BuildContext context) {
    // _getConn();
    // OrderService orderService = OrderService.mysql(conn);
    return Scaffold(
      body: FutureBuilder(
          future: Mysql.getConnection(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final conn = snapshot.data as MySqlConnection;
                  final OrderService orderService = OrderService.mysql(conn);
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        snap: true,
                        pinned: true,
                        floating: true,
                        toolbarHeight: 100,
                        leading: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                          child: IconButton(
                            icon: const Icon(Icons.menu),
                            iconSize: 50,
                            tooltip: 'Menu',
                            onPressed: () {},
                          ),
                        ), //IconButton
                        actions: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 5, 10),
                            child: IconButton(
                              icon:
                                  const Icon(CupertinoIcons.barcode_viewfinder),
                              iconSize: 45,
                              tooltip: 'Scan',
                              onPressed: () {
                                Get.toNamed(scanRoute);
                              },
                            ),
                          ), //IconButton
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 4, 10, 10),
                            child: IconButton(
                              icon: const Icon(Icons.logout_rounded),
                              iconSize: 45,
                              tooltip: 'Logout',
                              onPressed: () async {
                                final shouldLogout = await showLogOutDialog(
                                  context,
                                  userName,
                                );
                                if (shouldLogout) {
                                  await AuthService.firebase().logOut();
                                  Get.offAllNamed(loginRoute);
                                }
                              },
                            ),
                          ), //IconButto
                        ],
                        iconTheme: const IconThemeData(
                            color: Color.fromARGB(255, 247, 247, 247)),

                        flexibleSpace: FlexibleSpaceBar(
                          background: Image.asset(
                            'assets/perixxappbar.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                        //FlexibleSpaceBar
                        expandedHeight: 330,
                        collapsedHeight: 120,
                        backgroundColor:
                            const Color.fromARGB(255, 195, 194, 194),
                        forceElevated: true,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(20),
                          child: Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'In/Outbound',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(221, 89, 89, 89)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => FutureBuilder(
                            future: orderService.getOrderOn('2022-11-02'),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.done:
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                        '${snapshot.error} occurred',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    );
                                  } else if (snapshot.hasData) {
                                    return const Text("HAS DATA");
                                  }
                                  return const Center(
                                      child: CircularProgressIndicator());
                                default:
                                  return const Center(
                                      child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      ),
                      //   SliverToBoxAdapter(
                      //     child: Container(
                      //       alignment: Alignment.center,
                      //       height: 100,
                      //       child: TextField(
                      //         controller: dateInput,

                      //         decoration: const InputDecoration(
                      //             icon: Icon(Icons.calendar_today), //icon of text field
                      //             labelText: "Date of orders" //label text of field
                      //             ),
                      //         readOnly: true,
                      //         //set it true, so that user will not able to edit text
                      //         onTap: () => _selectDate(context),
                      //       ),
                      //     ),
                      //   ),
                      //   SliverGrid(
                      //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      //       maxCrossAxisExtent: 200.0,
                      //       mainAxisSpacing: 10.0,
                      //       crossAxisSpacing: 10.0,
                      //       childAspectRatio: 4.0,
                      //     ),
                      //     delegate: SliverChildBuilderDelegate(
                      //       (BuildContext context, int index) {
                      //         return Container(
                      //           alignment: Alignment.center,
                      //           color: Colors.teal[100 * (index % 9)],
                      //           child: Text('Grid Item $index'),
                      //         );
                      //       },
                      //       childCount: 20,
                      //     ),
                      //   ),
                      //   SliverToBoxAdapter(
                      //     child: Container(
                      //       color: Colors.amberAccent,
                      //       alignment: Alignment.center,
                      //       height: 200,
                      //       child: const Text('This is Container'),
                      //     ),
                      //   ),
                      //   SliverToBoxAdapter(
                      //     child: SizedBox(
                      //       height: 100.0,
                      //       child: ListView.builder(
                      //         scrollDirection: Axis.horizontal,
                      //         itemCount: 10,
                      //         itemBuilder: (context, index) {
                      //           return SizedBox(
                      //             width: 100.0,
                      //             child: Card(
                      //               color: Colors.cyan[100 * (index % 9)],
                      //               child: Text('Item $index'),
                      //             ),
                      //           );
                      //         },
                      //       ),
                      //     ),
                      //   ),

                      //   SliverList(
                      //     delegate: SliverChildBuilderDelegate(
                      //       (context, index) => ListTile(
                      //         tileColor: (index % 2 == 0) ? Colors.white : Colors.green[50],
                      //         title: Center(
                      //           child: Text('$index',
                      //               style: TextStyle(
                      //                   fontWeight: FontWeight.normal,
                      //                   fontSize: 50,
                      //                   color: Colors.greenAccent[400]) //TextStyle
                      //               ), //Text
                      //         ), //Center
                      //       ), //ListTile

                      //       childCount: 51,
                      //     ), //SliverChildBuildDelegate
                      //   ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                }

              default:
                return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.amberAccent, // <-- SEE HERE
              onPrimary: Colors.redAccent, // <-- SEE HERE
              onSurface: Colors.blueAccent, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        dateInput.text = formattedDate; //set output date to TextField value.
      });
    } else {}
  }

  // void _getConn() {
  //   setState(() async {
  //     conn = await Mysql.getConnection();
  //   });
  // }
}
