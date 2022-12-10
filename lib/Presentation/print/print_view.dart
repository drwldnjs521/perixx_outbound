import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perixx_outbound/Domain/orderlist/order.dart';
import 'package:perixx_outbound/Presentation/size_config.dart';
import 'package:printing/printing.dart';

class PrintView extends StatefulWidget {
  const PrintView({Key? key}) : super(key: key);

  @override
  State<PrintView> createState() => _PrintViewState();
}

class _PrintViewState extends State<PrintView> {
  Order order = Get.arguments["order"];
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverAppBar(order: order),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Create Date : ",
                      style: GoogleFonts.notoSans(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 210, 210, 210),
                      ),
                    ),
                    Text(
                      order.orderedDate,
                      style: GoogleFonts.notoSans(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 210, 210, 210),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Shipped To : ",
                      style: GoogleFonts.notoSans(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 210, 210, 210),
                      ),
                    ),
                    Text(
                      order.shippedTo,
                      style: GoogleFonts.notoSans(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 210, 210, 210),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Label : ",
                      style: GoogleFonts.notoSans(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 210, 210, 210),
                      ),
                    ),
                    Text(
                      order.labelNo,
                      style: GoogleFonts.notoSans(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 210, 210, 210),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => SizedBox(
                height: SizeConfig.safeVertical,
                child: _showArticle(),
              ),
              childCount: order.items.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) async {
          _changeTab(index);
          switch (index) {
            case 1:
              _printDocument(
                  "https://jeewon.perixx.dev/media/ebay/${order.orderNo}.pdf");
              break;
            case 2:
              _printDocument(
                  "https://jeewon.perixx.dev/media/ebay/${order.labelNo}.pdf");
              break;
            case 3:
              if (order.cn23 != "not necessary") {
                _printDocument(
                    "https://jeewon.perixx.dev/media/ebay/${order.cn23}.pdf");
                break;
              }
          }
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        iconSize: 50,
        selectedFontSize: 20,
        unselectedFontSize: 15,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.print),
            label: "",
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.fileInvoiceDollar),
              label: "Invoice"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.dhl), label: "Label"),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_3x3_outlined), label: "Customs Invoice"),
        ],
      ),
    );
  }

  void _printDocument(String path) async {
    final pdf = (await NetworkAssetBundle(Uri.parse(path)).load(path))
        .buffer
        .asUint8List();

    await Printing.layoutPdf(onLayout: (_) => pdf);
  }

  void _changeTab(int index) {
    if (index == 3 && order.cn23 == "not necessary") {
      return;
    }
    setState(() {
      _selectedTab = index;
    });
  }

  Widget _showArticle() {
    return ListView.builder(
      itemCount: order.items.length,
      itemBuilder: (context, index) {
        final item = order.items[index];
        return Card(
          margin: const EdgeInsets.all(20),
          elevation: 60,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: ClipRect(
                    child: Image.network(
                  item.article.image,
                )),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Text(
                    item.article.articleNo,
                    style: GoogleFonts.notoSans(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Text(
                  item.article.model,
                  style: GoogleFonts.notoSans(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  "${item.qty}",
                  style: GoogleFonts.notoSans(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  static const double expandedHeight = 300;
  final Order order;
  MySliverAppBar({required this.order});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 252, 252, 252),
                Color.fromARGB(230, 93, 93, 93),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 50,
              ),
            ),
          ),
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Text(
              'Order Details',
              style: GoogleFonts.notoSans(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 210, 210, 210),
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 5 - shrinkOffset,
          left: SizeConfig.safeHorizontal * 0.357,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Column(
              children: [
                Text(
                  "Order ${order.orderNo}",
                  style: GoogleFonts.notoSans(
                    fontSize: 60,
                    fontWeight: FontWeight.w800,
                    color: const Color.fromARGB(255, 66, 66, 66),
                  ),
                ),
                Card(
                  elevation: 40,
                  shape: const CircleBorder(),
                  child: SizedBox(
                    height: expandedHeight,
                    width: 300,
                    child: CircularProfileAvatar(
                      '',
                      radius: 200,
                      // backgroundColor: Colors.transparent,
                      // borderColor: Colors.transparent,
                      child: Image.asset(
                        'assets/ebay.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 150;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
