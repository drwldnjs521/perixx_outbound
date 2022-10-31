import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perixx_outbound/Application/auth_service.dart';
import 'package:perixx_outbound/Presentation/enums/menu_actions.dart';
import 'package:perixx_outbound/Presentation/utilities/dialogs/logout_dialog.dart';
import 'package:perixx_outbound/constants/routes.dart';

class OrderListView extends StatefulWidget {
  const OrderListView({super.key});

  @override
  State<OrderListView> createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  String get userName => AuthService.firebase().currentUser!.userName!;

  bool _hasBeenPressed = true;
  bool _hasBeenPressed1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "In/Outbound",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 1.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/perixx_profile.jpg"),
            ),
          ),
        ),
        leadingWidth: 80,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
            },
            icon: const Icon(CupertinoIcons.barcode_viewfinder),
          ),
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(
                    context,
                    userName,
                  );
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (_) => false,
                    );
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                    value: MenuAction.logout, child: Text("LOGOUT")),
              ];
            },
          ),
        ],
      ),

      // leading: IconButton(
      //   iconSize: 50,
      //   color: Colors.grey,
      //   icon: const Icon(Icons.person_rounded),
      //   onPressed: () {},
      // ),
      // add more IconButton

      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              //showPopup("33310", "11111","assets/keyboard2.jpg");
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return PrintLabelAndInvoice();
              // }));
            },
            child: Card(
              color: Colors.green.shade700,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  Container(
                    child: Text(
                      "Order# : 33310",
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  Container(
                    child: Text(
                      "Order date : 20.04.22",
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  Container(
                    child: Text(
                      "Price : 111.99",
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _hasBeenPressed1 = !_hasBeenPressed1;
                                });
                              },
                              child: Text(
                                "33333",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: _hasBeenPressed1
                                        ? Colors.redAccent.shade700
                                        : Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Text(
                              "Periboard-718",
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Text(
                              "45.99",
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              // shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.red.shade900
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _hasBeenPressed = !_hasBeenPressed;
                                });
                              },
                              child: Text(
                                "14893",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: _hasBeenPressed
                                        ? Colors.redAccent.shade700
                                        : Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Text(
                              "Periboard-609",
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Text(
                              "68.99",
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.amber.shade200,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                Container(
                  child: Text(
                    "Order# : 33311",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                Container(
                  child: Text(
                    "Order date : 20.04.22",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                Container(
                  child: Text(
                    "Price : 66.99",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "15698",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Text(
                        "Perimice-618",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Text(
                        "19.99",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "33333",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Text(
                        "Periboard-718",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Text(
                        "45.99",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
            width: 10,
          ),
          Card(
            color: Colors.green.shade700,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                Container(
                  child: Text(
                    "Order# : 33312",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                Container(
                  child: Text(
                    "Order date : 20.04.22",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                Container(
                  child: Text(
                    "Price : 111.99",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "33333",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Text(
                            "Periboard-718",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Text(
                            "45.99",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
