import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perixx_outbound/Application/app_state.dart';
import 'package:perixx_outbound/Application/login/auth_controller.dart';
import 'package:perixx_outbound/Application/orderlist/order_controller.dart';
import 'package:perixx_outbound/Domain/orderlist/item.dart';
import 'package:perixx_outbound/Presentation/shared_widgets.dart';
import 'package:perixx_outbound/Presentation/size_config.dart';
import 'package:perixx_outbound/Presentation/utilities/snackbars/snackbar.dart';
import 'package:perixx_outbound/theme/custom_theme.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  final _authController = Get.find<AuthController>();
  final _orderController = Get.find<OrderController>();
  final _eanController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final _itemList = <Item>[];
  final RegExp digitValidator = RegExp("[0-9]+");
  bool isANumber = true;
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            showAppBar(
              context,
              "SCAN",
            ),
            _showScanEditor(),
            if (_itemList.isNotEmpty && !_hasProperOrder) ...[
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
          // side: BorderSide(
          //   color: Color.fromARGB(255, 34, 34, 34),
          // ),
        ),
        // margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        margin: EdgeInsets.all(
          SizeConfig.safeHorizontal * 0.02,
        ),

        child: SizedBox(
          height: SizeConfig.safeVertical * 0.23,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              SizeConfig.safeHorizontal * 0.015,
              SizeConfig.safeVertical * 0.02,
              SizeConfig.safeHorizontal * 0.015,
              SizeConfig.safeVertical * 0.01,
            ),
            child: Column(
              children: <Widget>[
                IntrinsicHeight(
                  // child: SizedBox(
                  //   width: SizeConfig.safeHorizontal * 0.8,
                  //   child: RawKeyboardListener(
                  //     autofocus: true,
                  //     focusNode: FocusNode(onKey: (node, event) {
                  //       if (event.isKeyPressed(LogicalKeyboardKey.tab)) {
                  //         return KeyEventResult
                  //             .handled; // prevent passing the event into the TextField
                  //       }
                  //       return KeyEventResult
                  //           .ignored; // pass the event to the TextField
                  //     }),
                  //     onKey: (event) async {
                  //       if (event.isKeyPressed(LogicalKeyboardKey.enter) &&
                  //           _eanController.text.isNotEmpty) {
                  //         setState(() {
                  //           final article = _orderController
                  //               .getArticleByEan(_eanController.text);
                  //           if (article != null) {
                  //             _itemList.addItem(
                  //               Item(
                  //                 article: article,
                  //                 qty: 1,
                  //               ),
                  //             );
                  //           } else {
                  //             openSnackbar(
                  //               title: 'warning'.tr,
                  //               message: 'no_article_found'.tr,
                  //             );
                  //           }
                  //           _eanController.clear();
                  //         });
                  //         await _orderController
                  //             .getOrderExactSameItems(_itemList);
                  //         final orders1 = _orderController.orderList;
                  //         if (orders1.isNotEmpty) {
                  //           setState(() {
                  //             _hasProperOrder = true;
                  //           });
                  //           final selectedOrder = _orderController.orderList[0];
                  //           Get.toNamed("/PRINT",
                  //               arguments: {"order": selectedOrder});
                  //           _itemList.clear();
                  //           _orderController.updateStatusToScanned(
                  //               order: selectedOrder,
                  //               assigner:
                  //                   _authController.currentUser!.userName!);
                  //         } else {
                  //           setState(() {
                  //             _hasProperOrder = false;
                  //           });
                  //           // await _orderController
                  //           //     .getProcessingOrderByEan(_eanList);
                  //           await _orderController
                  //               .getProcessingOrderByItems(_itemList);
                  //           final orders2 = _orderController.orderList;
                  //           if (orders2.isNotEmpty) {
                  //             setState(() {
                  //               _showOrders = true;
                  //             });
                  //           }
                  //         }
                  //       }
                  //     },
                  //     child: TextField(
                  //       controller: _eanController,
                  //       decoration: InputDecoration(
                  //         contentPadding: EdgeInsets.only(
                  //             top: SizeConfig.safeVertical * 0.001,
                  //             bottom: SizeConfig.safeVertical * 0.003),
                  //         labelText: "EAN",
                  //         labelStyle: CustomTheme.theme.textTheme.labelSmall,
                  //         floatingLabelBehavior: FloatingLabelBehavior.auto,
                  //         hintText: "Please scan a valid article",
                  //         hintStyle: CustomTheme.theme.textTheme.labelLarge,
                  //         icon: FaIcon(
                  //           FontAwesomeIcons.magnifyingGlass,
                  //           size: SizeConfig.safeHorizontal * 0.05,
                  //           color: const Color.fromARGB(255, 40, 133, 175),
                  //         ),
                  //         enabledBorder: const UnderlineInputBorder(
                  //           borderSide: BorderSide(
                  //             color: Colors.greenAccent,
                  //             style: BorderStyle.solid,
                  //           ),
                  //         ),
                  //         focusedBorder: const UnderlineInputBorder(
                  //           borderSide: BorderSide(
                  //             color: Color(0xffF02E65),
                  //             style: BorderStyle.solid,
                  //           ),
                  //         ),

                  //         // onChanged: (value) {
                  //         //   setState(() {
                  //         //     _scannedEan = value;
                  //         //     _textController.clear();
                  //         //   });
                  //         // },
                  //       ),
                  //       style: CustomTheme.theme.textTheme.labelLarge,
                  //     ),
                  //   ),
                  // ),
                  child: SizedBox(
                    width: SizeConfig.safeHorizontal * 0.8,
                    child: TextField(
                      focusNode: _focusNode,
                      autofocus: true,
                      controller: _eanController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorText: isANumber ? null : "not_valid_ean".tr,
                        contentPadding: EdgeInsets.only(
                            top: SizeConfig.safeVertical * 0.001,
                            bottom: SizeConfig.safeVertical * 0.003),
                        labelText: "EAN",
                        labelStyle: CustomTheme.theme.textTheme.labelSmall,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: "not_valid_ean".tr,
                        hintStyle: CustomTheme.theme.textTheme.labelLarge,
                        icon: FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          size: SizeConfig.safeHorizontal * 0.05,
                          color: const Color.fromARGB(255, 40, 133, 175),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.greenAccent,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffF02E65),
                            style: BorderStyle.solid,
                          ),
                        ),

                        // onChanged: (value) {
                        //   setState(() {
                        //     _scannedEan = value;
                        //     _textController.clear();
                        //   });
                        // },
                      ),
                      style: CustomTheme.theme.textTheme.labelLarge,
                      onChanged: (input) {
                        if (input.isEmpty || digitValidator.hasMatch(input)) {
                          _setValidator(true);
                        } else {
                          _setValidator(false);
                        }
                      },
                      onSubmitted: (input) async {
                        if (input.isNotEmpty) {
                          setState(() {
                            final article =
                                _orderController.getArticleByEan(input);
                            if (article != null) {
                              _itemList.addItem(
                                Item(
                                  article: article,
                                  qty: 1,
                                ),
                              );
                            } else {
                              openSnackbar(
                                title: 'warning'.tr,
                                message: 'no_article_found'.tr,
                              );
                            }
                            _eanController.clear();
                            _focusNode.requestFocus();
                          });
                          await _orderController
                              .getOrderExactSameItems(_itemList);
                          final orders1 = _orderController.orderList;
                          if (orders1.isNotEmpty) {
                            setState(() {
                              _hasProperOrder = true;
                            });
                            final selectedOrder = _orderController.orderList[0];
                            Get.toNamed("/PRINT",
                                arguments: {"order": selectedOrder});
                            _itemList.clear();
                            await _orderController.updateStatusToScanned(
                                order: selectedOrder,
                                assigner:
                                    _authController.currentUser!.userName!);
                            await _orderController
                                .printDocuments(selectedOrder);
                          } else {
                            setState(() {
                              _hasProperOrder = false;
                            });
                            await _orderController
                                .getProcessingOrderByItems(_itemList);
                            final orders2 = _orderController.orderList;
                            if (orders2.isNotEmpty) {
                              setState(() {
                                _showOrders = true;
                              });
                            }
                          }
                        }
                      },
                    ),
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _itemList.map((item) {
                      return Badge(
                        padding: EdgeInsets.zero,
                        badgeColor: Colors.transparent,
                        position: BadgePosition.topEnd(
                          top: SizeConfig.safeHorizontal * 0.025,
                          end: 0,
                        ),
                        badgeContent: SizedBox(
                          height: SizeConfig.safeHorizontal * 0.05,
                          width: SizeConfig.safeHorizontal * 0.05,
                          child: FittedBox(
                            child: FloatingActionButton(
                              backgroundColor:
                                  const Color.fromARGB(151, 207, 52, 124),
                              onPressed: () => setState(() {
                                _itemList.remove(item);
                              }),
                              child: Icon(
                                Icons.highlight_remove,
                                size: SizeConfig.safeHorizontal * 0.14,
                              ),
                            ),
                          ),
                        ),
                        child: _showItem(item),
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
    );
  }

  void _setValidator(valid) {
    setState(() {
      isANumber = valid;
    });
  }

  Widget _showItem(Item item) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        SizeConfig.safeHorizontal * 0.015,
        SizeConfig.safeVertical * 0.02,
        SizeConfig.safeHorizontal * 0.015,
        SizeConfig.safeVertical * 0.01,
      ),
      padding: EdgeInsets.all(SizeConfig.safeHorizontal * 0.015),
      decoration: CustomTheme.customBox,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: SizeConfig.safeHorizontal * 0.06,
            backgroundImage: NetworkImage(item.article.image),
            backgroundColor: Colors.transparent,
          ),
          Text.rich(
            TextSpan(
              text: item.article.articleNo,
              style: GoogleFonts.notoSans(
                fontSize: SizeConfig.safeHorizontal * 0.035,
                fontWeight: FontWeight.w700,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: " x ",
                  style: GoogleFonts.notoSans(
                    fontSize: SizeConfig.safeHorizontal * 0.035,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 252, 79, 79),
                  ),
                ),
                TextSpan(
                  text: item.qty.toString(),
                  style: GoogleFonts.notoSans(
                    fontSize: SizeConfig.safeHorizontal * 0.035,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  //   return Card(
  //     elevation: 80,
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
  //           backgroundImage: NetworkImage(item.article.image),
  //           backgroundColor: Colors.transparent,
  //         ),
  //         Text.rich(
  //           TextSpan(
  //             text: item.article.articleNo,
  //             style: GoogleFonts.notoSans(
  //               fontSize: 20,
  //               fontWeight: FontWeight.w700,
  //             ),
  //             children: <InlineSpan>[
  //               TextSpan(
  //                 text: " x ",
  //                 style: GoogleFonts.notoSans(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.w700,
  //                   color: const Color.fromARGB(255, 252, 79, 79),
  //                 ),
  //               ),
  //               TextSpan(
  //                 text: item.qty.toString(),
  //                 style: GoogleFonts.notoSans(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.w700,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
                fontSize: SizeConfig.safeHorizontal * 0.1,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }
  }
}
