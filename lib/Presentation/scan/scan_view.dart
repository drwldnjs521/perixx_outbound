import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perixx_outbound/Application/app_state.dart';
import 'package:perixx_outbound/Application/login/auth_controller.dart';
import 'package:perixx_outbound/Application/orderlist/order_controller.dart';
import 'package:perixx_outbound/Domain/orderlist/article.dart';
import 'package:perixx_outbound/Presentation/shared_widgets.dart';
import 'package:perixx_outbound/Presentation/size_config.dart';
import 'package:perixx_outbound/Presentation/utilities/snackbars/snackbar.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  final _authController = Get.find<AuthController>();
  final _orderController = Get.find<OrderController>();
  final _eanController = TextEditingController();
  // final _itemList = <Item>[];
  final _eanList = <String>[];
  bool _showOrders = false;
  bool _hasProperOrder = true;
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    // return FutureBuilder(
    //     future: OrderService.mysql().getOrderByEan(eans: eanList),
    //     builder: (context, snapshot) {
    //       switch (snapshot.connectionState) {
    //         case ConnectionState.done:
    //           if (snapshot.hasData && snapshot.data!.isNotEmpty) {
    //             final allOrders = snapshot.data as List<Order>;
    //             return Scaffold(
    //               appBar: _showAppBar(),
    //               body: _showScanFilter(),
    //             );
    //           } else {
    //             return Scaffold(
    //               appBar: _showAppBar(),
    //               body: _showScanFilter(),
    //               // body: CustomScrollView(
    //               //   slivers: <Widget>[
    //               //     _showAppBar(),
    //               //     _showScanFilter(),
    //               //     SliverToBoxAdapter(
    //               //       child: SizedBox(
    //               //         width: SizeConfig.safeHorizontal * 0.3,
    //               //         height: SizeConfig.safeVertical * 0.6,
    //               //         child: Center(
    //               //           child: Text(
    //               //             'no_result'.tr,
    //               //             style: GoogleFonts.notoSans(
    //               //               fontSize: 100,
    //               //               fontWeight: FontWeight.w500,
    //               //             ),
    //               //           ),
    //               //         ),
    //               //       ),
    //               //     ),
    //               //   ],
    //               // ),
    //             );
    //           }
    //         default:
    //           return const Center(child: CircularProgressIndicator());
    //       }
    //     });
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          showAppBar(
            context,
            "SCAN",
          ),
          _showScanEditor(),
          if (_eanList.isNotEmpty && !_hasProperOrder) ...[
            _showOrderToHandle(),
          ],

          // SliverToBoxAdapter(
          //   child: Row(
          //     children: <Widget>[
          //       TextField(
          //         autofocus: true,
          //         controller: _eanController,
          //         decoration: const InputDecoration(
          //           icon: FaIcon(
          //             FontAwesomeIcons.searchengin,
          //             size: 50,
          //           ),
          //         ),
          //         style: GoogleFonts.notoSans(
          //           fontSize: 40,
          //           fontWeight: FontWeight.w500,
          //         ),
          //         textAlign: TextAlign.center,
          //         onChanged: (value) {
          //           setState(() {
          //             scanController.scannedEan.value = value;
          //           });
          //         },
          //       ),
          //       const SizedBox(
          //         height: 50,
          //       ),
          //       TextButton(
          //         onPressed: () {
          //           scanController.addEan(scanController.scannedEan.value);
          //         },
          //         child: const Text('ENTER'),
          //       ),
          //       const SizedBox(
          //         height: 50,
          //       ),
          //       Expanded(
          //         child: SizedBox(
          //           width: 800,
          //           child: Obx(
          //             () => ListView.builder(
          //               scrollDirection: Axis.horizontal,
          //               itemCount: scanController.eanList.length,
          //               itemBuilder: (context, index) {
          //                 return Container(
          //                   decoration: BoxDecoration(
          //                     border: Border.all(
          //                       color: Colors.blue,
          //                     ),
          //                     borderRadius: BorderRadius.circular(10.0),
          //                   ),
          //                   child: Text(
          //                     '${scanController.eanList[index]} ',
          //                     style: GoogleFonts.notoSans(
          //                       fontSize: 30,
          //                       fontWeight: FontWeight.w500,
          //                     ),
          //                   ),
          //                 );
          //               },
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _showScanEditor() {
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
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),

        child: Padding(
          padding: const EdgeInsets.all(10),
          // child: SizedBox(
          //   width: 500,
          //   child: Row(
          //     children: <Widget>[
          //       TextField(
          //         autofocus: true,
          //         controller: _eanController,
          //         decoration: const InputDecoration(
          //           icon: FaIcon(
          //             FontAwesomeIcons.searchengin,
          //             size: 50,
          //           ),
          //         ),
          //         style: GoogleFonts.notoSans(
          //           fontSize: 40,
          //           fontWeight: FontWeight.w500,
          //         ),
          //         textAlign: TextAlign.center,
          //       ),
          //       const SizedBox(
          //         width: 50,
          //       ),
          //       TextButton(
          //         onPressed: () {
          //           if (_eanController.text.isNotEmpty) {
          //             scanController.addEan(_eanController.text);
          //             _eanController.text = "";
          //           }
          //         },
          //         child: Text(
          //           'ENTER',
          //           style: GoogleFonts.notoSans(
          //             fontSize: 40,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 50,
          //       ),
          //     ],
          //   ),
          // ),
          child: SizedBox(
            height: 350,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          width: SizeConfig.safeHorizontal * 0.7,
                          // child: TextField(
                          //   autofocus: true,
                          //   controller: _eanController,
                          //   decoration: const InputDecoration(
                          //     icon: FaIcon(
                          //       FontAwesomeIcons.searchengin,
                          //       size: 50,
                          //     ),
                          //   ),
                          //   style: GoogleFonts.notoSans(
                          //     fontSize: 40,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          //   textAlign: TextAlign.center,
                          // ),
                          child: RawKeyboardListener(
                            autofocus: true,
                            focusNode: FocusNode(onKey: (node, event) {
                              if (event.isKeyPressed(LogicalKeyboardKey.tab)) {
                                return KeyEventResult
                                    .handled; // prevent passing the event into the TextField
                              }
                              return KeyEventResult
                                  .ignored; // pass the event to the TextField
                            }),
                            onKey: (event) async {
                              if (event.isKeyPressed(LogicalKeyboardKey.tab) &&
                                  _eanController.text.isNotEmpty) {
                                setState(() {
                                  final article = _orderController
                                      .getArticleByEan(_eanController.text);
                                  if (article != null) {
                                    // _itemList.addItem(
                                    //   Item(
                                    //     article: article,
                                    //     qty: 1,
                                    //   ),
                                    // );
                                    _eanList.add(_eanController.text);
                                  } else {
                                    openSnackbar(
                                      title: 'warning'.tr,
                                      message: 'no_article_found'.tr,
                                    );
                                  }
                                  _eanController.clear();
                                });
                                await _orderController
                                    .getOrderExactSameArticles(_eanList);
                                if (_orderController.orderList.isNotEmpty) {
                                  setState(() {
                                    _hasProperOrder = true;
                                  });
                                  final selectedOrder =
                                      _orderController.orderList[0];
                                  Get.toNamed("/PRINT",
                                      arguments: {"order": selectedOrder});
                                  _eanList.clear();
                                  _orderController.updateStatusToScanned(
                                      order: selectedOrder,
                                      assigner: _authController
                                          .currentUser!.userName!);
                                } else {
                                  setState(() {
                                    _hasProperOrder = false;
                                  });
                                  await _orderController
                                      .getProcessingOrderByEan(_eanList);
                                  final orders = _orderController.orderList;
                                  if (orders.isNotEmpty) {
                                    setState(() {
                                      _showOrders = true;
                                    });
                                  }
                                }
                              }
                            },
                            child: TextField(
                              controller: _eanController,
                              decoration: const InputDecoration(
                                icon: FaIcon(
                                  FontAwesomeIcons.searchengin,
                                  size: 50,
                                ),
                              ),
                              style: GoogleFonts.notoSans(
                                fontSize: 40,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                              // onChanged: (value) {
                              //   setState(() {
                              //     _scannedEan = value;
                              //     _textController.clear();
                              //   });
                              // },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        // TextButton(
                        //   onPressed: () => setState(() {
                        //     _eanList.add(_eanController.text);
                        //     _eanController.text = "";
                        //     debugPrint(_eanList.length.toString());
                        //   }),
                        //   child: Text(
                        //     'ENTER',
                        //     style: GoogleFonts.notoSans(
                        //       fontSize: 40,
                        //       fontWeight: FontWeight.w500,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _eanList.map((ean) {
                        final article = _orderController.getArticleByEan(ean);
                        return Stack(
                          children: <Widget>[
                            if (article != null) ...[_showArticle(article)],
                            Positioned(
                              right: 1,
                              top: 1,
                              child: SizedBox(
                                width: 35,
                                height: 35,
                                child: FloatingActionButton(
                                  child: const Icon(
                                    Icons.highlight_remove,
                                  ),
                                  onPressed: () => setState(() {
                                    _eanList.remove(ean);
                                  }),
                                ),
                              ),
                            ),
                            // child: Container(
                            //   padding: const EdgeInsets.all(2),
                            //   decoration: BoxDecoration(
                            //     color: Colors.red,
                            //     borderRadius: BorderRadius.circular(6),
                            //   ),
                            //   constraints: const BoxConstraints(
                            //     minWidth: 20,
                            //     minHeight: 20,
                            //   ),
                            //   child: const Text(
                            //     '1',
                            //     style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 8,
                            //     ),
                            //     textAlign: TextAlign.center,
                            //   ),
                            // ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),

                  // if (_eanList.isNotEmpty) ...[
                  //   // Obx(() {
                  //   //   debugPrint(scanController.eanList.length.toString());
                  //   //   debugPrint(orderController
                  //   //       .getArticleByEan(scanController.eanList.last)
                  //   //       .toString());
                  //   //   return _showArticle(orderController
                  //   //       .getArticleByEan(scanController.eanList.last));
                  //   // }),
                  //   SingleChildScrollView(
                  //     scrollDirection: Axis.horizontal,
                  //     child: Row(
                  //       children: _eanList
                  //           .map((ean) =>
                  //               _showArticle(orderController.getArticleByEan(ean)))
                  //           .toList(),
                  //     ),
                  //   ),
                  // ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _showItem(Article article) {
  //   return Card(
  //     elevation: 40,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(15.0),
  //       ),
  //       side: BorderSide(
  //         color: Color.fromARGB(255, 122, 122, 122),
  //       ),
  //     ),
  //     margin: const EdgeInsets.fromLTRB(5, 5, 10, 5),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: <Widget>[
  //         CircleAvatar(
  //           radius: 60.0,
  //           backgroundImage: NetworkImage(article.image),
  //           backgroundColor: Colors.transparent,
  //         ),
  //         // Text(
  //         //   "${item.article.articleNo} x ${item.qty}",
  //         //   style: GoogleFonts.notoSans(
  //         //     fontSize: 25,
  //         //     fontWeight: FontWeight.w700,
  //         //   ),
  //         // ),
  //         Text(
  //           article.articleNo,
  //           style: GoogleFonts.notoSans(
  //             fontSize: 20,
  //             fontWeight: FontWeight.w700,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _showArticle(Article article) {
    return Card(
      elevation: 40,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        side: BorderSide(
          color: Color.fromARGB(255, 122, 122, 122),
        ),
      ),
      margin: const EdgeInsets.fromLTRB(5, 5, 10, 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 60.0,
            backgroundImage: NetworkImage(article.image),
            backgroundColor: Colors.transparent,
          ),
          // Text(
          //   "${item.article.articleNo} x ${item.qty}",
          //   style: GoogleFonts.notoSans(
          //     fontSize: 25,
          //     fontWeight: FontWeight.w700,
          //   ),
          // ),
          Text(
            article.articleNo,
            style: GoogleFonts.notoSans(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _showOrderToHandle() {
    if (_showOrders) {
      return Obx(
        () => _orderController.pageState.value == AppState.loading
            ? SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                      padding:
                          EdgeInsets.only(top: SizeConfig.safeVertical * 0.18),
                      child: const CircularProgressIndicator()),
                ),
              )
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => SizedBox(
                    height: SizeConfig.safeVertical,
                    child: Column(
                      children:
                          _orderController.orderList.asMap().entries.map((e) {
                        return showOrder(
                            context,
                            const Color.fromARGB(255, 255, 254, 254),
                            e.key,
                            e.value);
                      }).toList(),
                    ),
                  ),
                  childCount: _orderController.orderList.length,
                ),
              ),
      );
    } else {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: SizeConfig.safeVertical * 0.18),
            child: Text(
              'no_result'.tr,
              style: GoogleFonts.notoSans(
                fontSize: 100,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }
  }
}
