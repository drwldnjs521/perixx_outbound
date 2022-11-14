import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysql1/mysql1.dart';
import 'package:perixx_outbound/Application/login/auth_service.dart';
import 'package:perixx_outbound/Application/orderlist/mysql.dart';
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
  MySqlConnection mySqlConnection = await Mysql.getConnection();

  @override
  Widget build(BuildContext context) {
    const conn = Mysql.getConnection;
    return Scaffold(
      body: CustomScrollView(
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
                  icon: const Icon(CupertinoIcons.barcode_viewfinder),
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
            iconTheme:
                const IconThemeData(color: Color.fromARGB(255, 247, 247, 247)),

            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/perixxappbar.jpg',
                fit: BoxFit.fill,
              ),
            ),
            //FlexibleSpaceBar
            expandedHeight: 330,
            collapsedHeight: 120,
            backgroundColor: const Color.fromARGB(255, 195, 194, 194),
            forceElevated: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      return const CircularProgressIndicator();
                    default:
                      return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
          // Consumer(
          //   builder: (BuildContext context, WidgetRef ref, Widget? child) {
          //     return SliverList(
          //       delegate: SliverChildBuilderDelegate(
          //           // (context, index) => ListTile(
          //           //   tileColor:
          //           //       (index % 2 == 0) ? Colors.white : Colors.green[50],
          //           //   title: Center(
          //           //     child: Text('$index',
          //           //         style: TextStyle(
          //           //             fontWeight: FontWeight.normal,
          //           //             fontSize: 50,
          //           //             color: Colors.greenAccent[400]) //TextStyle
          //           //         ), //Text
          //           //   ), //Center
          //           // ), //ListTile
          //           (context, index) => ListView.builder(
          //                 itemCount: orderService.getAllArticle().length,
          //                 itemBuilder: (BuildContext context, int index) {},
          //               )
          //           // childCount: 51,
          //           ), //SliverChildBuildDelegate
          //     );
          //   },
          // ) //SliverList
        ],
      ),
    );
  }
}
