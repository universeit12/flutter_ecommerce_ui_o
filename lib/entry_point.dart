import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_ui_o/route/route_constants.dart';
import 'package:flutter_ecommerce_ui_o/screens/bookmark/views/bookmark_screen.dart';
import 'package:flutter_ecommerce_ui_o/screens/checkout/add_to_cart_controller.dart';
import 'package:flutter_ecommerce_ui_o/screens/checkout/views/cart_screen.dart';
import 'package:flutter_ecommerce_ui_o/screens/discover/views/discover_screen.dart';
import 'package:flutter_ecommerce_ui_o/screens/home/views/home_screen.dart';
import 'package:flutter_ecommerce_ui_o/screens/profile/views/profile_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

import 'constants.dart';




class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  final AddToCartController cartController = Get.put(AddToCartController());

  final List _pages =  [
    const HomeScreen(),
    const DiscoverScreen(),
    const BookmarkScreen(),
    // EmptyCartScreen(), // if Cart is empty
    CartScreen(),
    const ProfileScreen(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SvgPicture svgIcon(String src, {Color? color}) {
      return SvgPicture.asset(
        src,
        height: 24,
        colorFilter: ColorFilter.mode(
            color ?? Theme.of(context).iconTheme.color!.withOpacity(
                Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
            BlendMode.srcIn),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: const SizedBox(),
        leadingWidth: 0,
        centerTitle: false,
        title: SvgPicture.asset(
          "assets/logo/Shoplon.svg",
          colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color!, BlendMode.srcIn),
          height: 20,
          width: 100,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchScreenRoute);
            },
            icon: SvgPicture.asset(
              "assets/icons/Search.svg",
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.bodyLarge!.color!,
                  BlendMode.srcIn),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, notificationsScreenRoute);
            },
            icon: SvgPicture.asset(
              "assets/icons/Notification.svg",
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.bodyLarge!.color!,
                  BlendMode.srcIn),
            ),
          ),
        ],
      ),
      body: PageTransitionSwitcher(
        duration: defaultDuration,
        transitionBuilder: (child, animation, secondAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondAnimation,
            child: child,
          );
        },
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: defaultPadding / 2),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF101015),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF101015),
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home, color: Colors.black, size: 23),
              activeIcon: Icon(Iconsax.home, color: Colors.blue, size: 23),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Category.svg"),
              activeIcon: svgIcon("assets/icons/Category.svg", color: primaryColor),
              label: "Discover",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Bookmark.svg"),
              activeIcon: svgIcon("assets/icons/Bookmark.svg", color: primaryColor),
              label: "Bookmark",
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  svgIcon("assets/icons/Bag.svg"),
                  Positioned(
                    right: 0,
                    child: Obx(() {
                      return cartController.itemCount > 0
                          ? CircleAvatar(
                        radius: 6,
                        backgroundColor: Colors.red,
                        child: Center(
                          child: Text(
                            '${cartController.itemCount}',
                            style: const TextStyle(
                              fontSize: 7,
                              color: Colors.white,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                        ),
                      )
                          : const SizedBox.shrink();
                    }),
                  ),
                ],
              ),
              activeIcon: Stack(
                children: [
                  svgIcon("assets/icons/Bag.svg", color: primaryColor),
                  Positioned(
                    right: 0,
                    child: Obx(() {
                      return cartController.itemCount > 0
                          ? CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.red,
                        child: Center(
                          child: Text(
                            '${cartController.itemCount}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                          : const SizedBox.shrink();
                    }),
                  ),
                ],
              ),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Profile.svg"),
              activeIcon: svgIcon("assets/icons/Profile.svg", color: primaryColor),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
