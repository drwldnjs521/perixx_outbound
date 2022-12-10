import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final authController = Get.find<AuthController>();
  final orderController = Get.find<OrderController>();
  final _eanController = TextEditingController();
  final _eanList = <String>[];
  bool _showOrders = false;
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
            _showScanEditor(),
          ),
          _showOrderToHandle(),

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
    return Card(
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
          height: 500,
          child: Column(
            children: <Widget>[
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 500,
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
                          if (event.isKeyPressed(LogicalKeyboardKey.tab)) {
                            setState(() {
                              if (orderController
                                      .getArticleByEan(_eanController.text) !=
                                  null) {
                                _eanList.add(_eanController.text);
                              } else {
                                openSnackbar(
                                  title: 'warning'.tr,
                                  message: 'no_article_found'.tr,
                                );
                              }
                              _eanController.clear();
                            });
                            await orderController
                                .getOrderExactSameEan(_eanList);
                            if (orderController.orderList.isNotEmpty) {
                              final selectedOrder =
                                  orderController.orderList[0];
                              Get.toNamed("/PRINT",
                                  arguments: {"order": selectedOrder});
                              _eanList.clear();
                              orderController.updateStatusToScanned(
                                  order: selectedOrder,
                                  assigner:
                                      authController.currentUser!.userName!);
                            } else {
                              await orderController
                                  .getProcessingOrderByEan(_eanList);
                              setState(() {
                                _showOrders = true;
                              });
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
                height: 50,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _eanList.map((ean) {
                    return Stack(
                      children: <Widget>[
                        if (orderController.getArticleByEan(ean) != null) ...[
                          _showArticle(orderController.getArticleByEan(ean)!),
                        ] else ...[
                          Text(ean),
                        ],

                        Positioned(
                          right: 4,
                          top: 9,
                          child: SizedBox(
                            width: 28,
                            height: 28,
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
    );
  }

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
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 40.0,
              backgroundImage: NetworkImage(article.image),
              backgroundColor: Colors.transparent,
            ),
            Text(
              article.articleNo,
              style: GoogleFonts.notoSans(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showOrderToHandle() {
    if (_eanList.isNotEmpty) {
      if (_showOrders) {
        return Obx(
          () => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => SizedBox(
                height: SizeConfig.safeVertical,
                child: Column(
                  children: orderController.orderList.asMap().entries.map((e) {
                    return showOrder(
                        context,
                        const Color.fromARGB(255, 255, 254, 254),
                        e.key,
                        e.value);
                  }).toList(),
                ),
              ),
              childCount: orderController.orderList.length,
            ),
          ),
        );
      }
    }

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
