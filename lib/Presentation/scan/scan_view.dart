import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perixx_outbound/Application/login/auth_service.dart';
import 'package:perixx_outbound/Presentation/size_config.dart';
import 'package:perixx_outbound/Presentation/utilities/dialogs/logout_dialog.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  String get _userName => AuthService.firebase().currentUser!.userName!;
  final TextEditingController _textController = TextEditingController();
  List<String> eanList = [];

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
      appBar: _showAppBar(),
      body: _showScanFilter(),
    );
  }

  AppBar _showAppBar() {
    return AppBar(
      toolbarHeight: SizeConfig.safeVertical * 0.085,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(50, 20, 10, 10),
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
                icon: const FaIcon(FontAwesomeIcons.rectangleList),
                iconSize: 65,
                tooltip: 'Orderlist',
                onPressed: () {
                  Get.offNamed('/ORDERLIST');
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
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(
          SizeConfig.safeVertical * 0.17,
        ),
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
              'Scan',
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

  Widget _showScanFilter() {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: TextField(
          controller: _textController,
          maxLines: 1,
          cursorColor: Colors.black,
          style: GoogleFonts.notoSans(
            fontSize: 40,
            fontWeight: FontWeight.w400,
            color: const Color.fromARGB(255, 131, 131, 131),
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            // filled: true,
            // fillColor: Colors.blueAccent,
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 20,
                color: Colors.lightBlueAccent,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
    );
  }
}
