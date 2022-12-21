import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perixx_outbound/Application/orderlist/order_controller.dart';
import 'package:perixx_outbound/Domain/orderlist/order.dart';
import 'package:perixx_outbound/Presentation/shared_widgets.dart';
import 'package:perixx_outbound/Presentation/size_config.dart';
import 'package:perixx_outbound/constants/pdf_document.dart';
import 'package:printing/printing.dart';

class PrintView extends StatefulWidget {
  const PrintView({Key? key}) : super(key: key);

  @override
  State<PrintView> createState() => _PrintViewState();
}

class _PrintViewState extends State<PrintView> {
  Order order = Get.arguments["order"];
  final _orderController = Get.find<OrderController>();

  late Uint8List _invoice;
  late Uint8List _label;
  late Uint8List _cn23;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverAppBar(order: order),
          ),
          // SliverToBoxAdapter(
          //     child: Padding(
          //   padding: EdgeInsets.only(top: SizeConfig.safeHorizontal * 0.08),
          //   child: Column(
          //     children: <Widget>[
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: <Widget>[
          //           Text(
          //             "Create Date : ",
          //             style: GoogleFonts.notoSans(
          //               fontSize: SizeConfig.safeHorizontal * 0.05,
          //               fontWeight: FontWeight.w500,
          //               color: const Color.fromARGB(255, 210, 210, 210),
          //             ),
          //           ),
          //           Text(
          //             order.orderedDate,
          //             style: GoogleFonts.notoSans(
          //               fontSize: SizeConfig.safeHorizontal * 0.05,
          //               fontWeight: FontWeight.w500,
          //               color: const Color.fromARGB(255, 210, 210, 210),
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: <Widget>[
          //           Text(
          //             "Shipped To : ",
          //             style: GoogleFonts.notoSans(
          //               fontSize: SizeConfig.safeHorizontal * 0.05,
          //               fontWeight: FontWeight.w500,
          //               color: const Color.fromARGB(255, 210, 210, 210),
          //             ),
          //           ),
          //           Text(
          //             order.shippedTo,
          //             style: GoogleFonts.notoSans(
          //               fontSize: SizeConfig.safeHorizontal * 0.05,
          //               fontWeight: FontWeight.w500,
          //               color: const Color.fromARGB(255, 210, 210, 210),
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: <Widget>[
          //           Text(
          //             "Label : ",
          //             style: GoogleFonts.notoSans(
          //               fontSize: SizeConfig.safeHorizontal * 0.05,
          //               fontWeight: FontWeight.w500,
          //               color: const Color.fromARGB(255, 210, 210, 210),
          //             ),
          //           ),
          //           Text(
          //             order.labelNo,
          //             style: GoogleFonts.notoSans(
          //               fontSize: SizeConfig.safeHorizontal * 0.05,
          //               fontWeight: FontWeight.w500,
          //               color: const Color.fromARGB(255, 210, 210, 210),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // )),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: EdgeInsets.fromLTRB(
                  SizeConfig.safeHorizontal * 0.03,
                  SizeConfig.safeVertical * 0.05,
                  SizeConfig.safeHorizontal * 0.03,
                  SizeConfig.safeVertical * 0.02,
                ),
                child: orderDetails(order),
              ),
              childCount: 1,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeHorizontal * 0.03,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: SizeConfig.safeVertical * 0.05),
                      child: SizedBox(
                        height: SizeConfig.safeVertical * 0.6,
                        child: FutureBuilder(
                          future: _orderController
                              .getDocument('$documentUrl${order.orderNo}.pdf'),
                          builder: (ctx, snapshot) {
                            // Checking if future is resolved or not
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              // If we got an error
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    '${snapshot.error} occurred',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                );

                                // if we got our data
                              } else if (snapshot.hasData) {
                                // Extracting data from snapshot object
                                _invoice = snapshot.data as Uint8List;
                                return Center(
                                  child: PdfPreview(
                                    build: (format) => _invoice,
                                    useActions: false,
                                  ),
                                );
                              }
                            }

                            // Displaying LoadingSpinner to indicate waiting state
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: SizeConfig.safeVertical * 0.05),
                      child: SizedBox(
                        height: SizeConfig.safeVertical * 0.6,
                        child: FutureBuilder(
                          future: order.labelNo == 'DEUTSCHE POST'
                              ? _orderController.getDocument(
                                  '${documentUrl}dp${order.orderNo}.pdf')
                              : _orderController.getDocument(
                                  '$documentUrl${order.labelNo}.pdf'),
                          builder: (ctx, snapshot) {
                            // Checking if future is resolved or not
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              // If we got an error
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    '${snapshot.error} occurred',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                );

                                // if we got our data
                              } else if (snapshot.hasData) {
                                // Extracting data from snapshot object
                                _label = snapshot.data as Uint8List;
                                return Center(
                                  child: PdfPreview(
                                    build: (format) => _label,
                                    // initialPageFormat: const PdfPageFormat(
                                    //     100 * PdfPageFormat.mm,
                                    //     150 * PdfPageFormat.mm),
                                    useActions: false,
                                    previewPageMargin: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.safeHorizontal * 0.2),
                                  ),
                                );
                              }
                            }

                            // Displaying LoadingSpinner to indicate waiting state
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ),
                    if (order.cn23 != 'not necessary') ...[
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: SizeConfig.safeVertical * 0.05),
                        child: SizedBox(
                          height: SizeConfig.safeVertical * 0.6,
                          child: FutureBuilder(
                            future: _orderController
                                .getDocument('$documentUrl${order.cn23}'),
                            builder: (ctx, snapshot) {
                              // Checking if future is resolved or not
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                // If we got an error
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                      '${snapshot.error} occurred',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  );

                                  // if we got our data
                                } else if (snapshot.hasData) {
                                  // Extracting data from snapshot object
                                  _cn23 = snapshot.data as Uint8List;
                                  return Center(
                                    child: PdfPreview(
                                      build: (format) => _cn23,
                                      useActions: false,
                                    ),
                                  );
                                }
                              }

                              // Displaying LoadingSpinner to indicate waiting state
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 40,
        backgroundColor: const Color.fromARGB(255, 255, 201, 8),
        icon: const FaIcon(FontAwesomeIcons.print),
        label: const Text('Print documents'),
        onPressed: () async {
          // List<Printer> printers = await Printing.info();
          // for (var printer in printers) {
          // debugPrint(Printing.info().toString());
          // Printer printer = const Printer(
          //   url: '192.168.0.88',
          // );
          // Printing.directPrintPdf(printer: printer, onLayout: (_) => _invoice);
          Printing.layoutPdf(onLayout: (_) => _invoice);
          Printing.layoutPdf(onLayout: (_) => _label);
          if (order.cn23 != 'not necessary') {
            Printing.layoutPdf(onLayout: (_) => _cn23);
          }
        },
      ),
    );
  }

  // Future<Uint8List> _getDocument(String url) async {
  //   return (await NetworkAssetBundle(Uri.parse(url)).load(url))
  //       .buffer
  //       .asUint8List();
  // }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  static double expandedHeight = SizeConfig.safeVertical * 0.18;
  final Order order;
  MySliverAppBar({required this.order});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // return Stack(
    //   clipBehavior: Clip.none,
    //   fit: StackFit.expand,
    //   children: [
    //     Container(
    //       alignment: Alignment.centerLeft,
    //       decoration: const BoxDecoration(
    //         borderRadius: BorderRadius.only(
    //           bottomRight: Radius.circular(40),
    //           bottomLeft: Radius.circular(40),
    //         ),
    //         gradient: LinearGradient(
    //           begin: Alignment.topCenter,
    //           end: Alignment.bottomCenter,
    //           colors: [
    //             Color.fromARGB(255, 252, 252, 252),
    //             Color.fromARGB(230, 93, 93, 93),
    //           ],
    //         ),
    //       ),
    //       child: Padding(
    //         padding: EdgeInsets.only(left: SizeConfig.safeHorizontal * 0.03),
    //         child: IconButton(
    //           onPressed: () {
    //             Get.back();
    //           },
    //           icon: Icon(
    //             Icons.arrow_back_ios,
    //             color: Colors.black,
    //             size: SizeConfig.safeHorizontal * 0.08,
    //           ),
    //         ),
    //       ),
    //     ),
    //     Center(
    //       child: Opacity(
    //         opacity: shrinkOffset / expandedHeight,
    //         child: Text(
    //           'Order Details',
    //           style: GoogleFonts.notoSans(
    //             fontSize: SizeConfig.safeHorizontal * 0.08,
    //             fontWeight: FontWeight.bold,
    //             color: const Color.fromARGB(255, 210, 210, 210),
    //           ),
    //         ),
    //       ),
    //     ),
    //     Positioned(
    //       top: expandedHeight / 5 - shrinkOffset,
    //       left: SizeConfig.safeHorizontal * 0.2,
    //       child: Opacity(
    //         opacity: (1 - shrinkOffset / expandedHeight),
    //         child: Column(
    //           children: [
    //             Text(
    //               "Order ${order.orderNo}",
    //               style: GoogleFonts.notoSans(
    //                 fontSize: SizeConfig.safeHorizontal * 0.09,
    //                 fontWeight: FontWeight.w600,
    //                 color: const Color.fromARGB(255, 66, 66, 66),
    //               ),
    //             ),
    //             Card(
    //               elevation: 40,
    //               shape: const CircleBorder(),
    //               child: SizedBox(
    //                 height: SizeConfig.safeVertical * 0.12,
    //                 width: SizeConfig.safeHorizontal * 0.5,
    //                 child: CircularProfileAvatar(
    //                   '',
    //                   radius: SizeConfig.safeHorizontal * 0.15,
    //                   backgroundColor: Colors.transparent,
    //                   borderColor: Colors.transparent,
    //                   // backgroundColor: Colors.transparent,
    //                   // borderColor: Colors.transparent,
    //                   child: Image.asset(
    //                     'assets/ebay.png',
    //                     fit: BoxFit.contain,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
    final progress = shrinkOffset / maxExtent;

    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: progress == 1
                ? const Color.fromARGB(255, 90, 255, 61)
                : const Color.fromARGB(255, 252, 165, 236),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 92, 90, 90),
                offset: Offset(
                  5.0,
                  5.0,
                ), //Offset
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
          ),
          duration: const Duration(milliseconds: 100),
        ),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: 1 - progress,
          child: CircularProfileAvatar(
            '',
            radius: SizeConfig.safeHorizontal * 0.2,
            backgroundColor: const Color.fromARGB(255, 252, 165, 236),
            borderColor: Colors.transparent,
            // backgroundColor: Colors.transparent,
            // borderColor: Colors.transparent,
            child: Image.asset(
              'assets/ebay.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: EdgeInsets.lerp(
            EdgeInsets.only(bottom: SizeConfig.safeVertical * 0.01),
            EdgeInsets.only(bottom: SizeConfig.safeVertical * 0.03),
            progress,
          ),
          alignment: Alignment.bottomCenter,
          child: Text(
            'Order No. ${order.orderNo}',
            style: TextStyle.lerp(
              GoogleFonts.notoSans(
                fontSize: SizeConfig.safeHorizontal * 0.05,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
              GoogleFonts.notoSans(
                fontSize: SizeConfig.safeHorizontal * 0.07,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
              progress,
            ),
          ),
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          leading: const BackButton(),
          elevation: 0,
          toolbarHeight: SizeConfig.safeVertical * 0.12,
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => SizeConfig.safeVertical * 0.15;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
