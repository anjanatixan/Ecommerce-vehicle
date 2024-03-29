import 'package:ecommerce/views/HomePage.dart';
import 'package:ecommerce/views/MarketPage.dart';
import 'package:ecommerce/views/helper/utils.dart';
import 'package:ecommerce/views/productPage.dart';
import 'package:ecommerce/views/shopPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'helper/navigation.dart';
import 'provider/bottomNavBarProvider.dart';
import 'servicePage.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with WidgetsBindingObserver {
  static List<Widget> screens = [
    HomePage(),
    ServicePage(),
    ProductPage(),
    MarketPage(),
    ShopPage()
  ];

  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    setState(() {
      _isKeyboardVisible = isKeyboardVisible;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBarProvider>(
        builder: (context, provider, child) {
      return Scaffold(
        floatingActionButton: _isKeyboardVisible
              ? null :Container(
          margin: const EdgeInsets.only(top: 6),
          height: 60,
          width: 60,
          child: FloatingActionButton(
            backgroundColor: Color(0xffE80F0F),
            elevation: 0,
            onPressed: () {
              getContext().read<BottomNavigationBarProvider>().currentIndex = 2;
              NavigationUtils.goNextFinishAll(context, BottomBar());
            },
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 3, color: Colors.white),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
            child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: provider.currentIndex,
          unselectedItemColor: Colors.black,
          unselectedLabelStyle: GoogleFonts.lato(
              textStyle: TextStyle(
            fontSize: 10.sp,
          )),
          selectedItemColor: Color(0xffE80F0F),
          unselectedFontSize: 12,
          selectedFontSize: 12,
          selectedLabelStyle: GoogleFonts.lato(
              textStyle: TextStyle(fontSize: 10.sp, color: Color(0xffE80F0F))),
          onTap: (index) {
            setState(() {});
            provider.currentIndex = index;
          },
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Container(child: Icon(Icons.home_outlined)),
                label: "Home",
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Container(
                  width: 20.w,
                  height: 20.w,
                  child: provider.currentIndex == 1
                      ? SvgPicture.asset(
                          "assets/images/Service.svg",
                          color: Color(0xffE80F0F),
                        )
                      : SvgPicture.asset(
                          "assets/images/Service.svg",
                          color: Colors.black,
                        ),
                ),
                label: "Services",
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                ),
                label: "Product",
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Container(
                  width: 20.w,
                  height: 20.w,
                  child: provider.currentIndex == 3
                      ? SvgPicture.asset(
                          "assets/images/market.svg",
                          color: Color(0xffE80F0F),
                        )
                      : SvgPicture.asset(
                          "assets/images/market.svg",
                          color: Colors.black,
                        ),
                ),
                label: "Market",
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Container(
                  width: 20.w,
                  height: 20.w,
                  child: provider.currentIndex == 4
                      ? SvgPicture.asset(
                          "assets/images/shop.svg",
                          color: Color(0xffE80F0F),
                        )
                      : SvgPicture.asset(
                          "assets/images/shop.svg",
                          color: Colors.black,
                        ),
                ),
                label: "My Shop",
                backgroundColor: Colors.white),
          ],
        )),
        body: Container(child: screens[provider.currentIndex]),
      );
    });
  }
}
