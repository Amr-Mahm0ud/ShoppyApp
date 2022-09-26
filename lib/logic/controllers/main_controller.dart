import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:shoppy/view/screens/home/bottom_bar/discover.dart';
import 'package:shoppy/view/screens/home/bottom_bar/home_screen.dart';
import 'package:shoppy/view/screens/home/bottom_bar/profile_screen.dart';
import 'package:shoppy/view/screens/home/bottom_bar/wishlist_screen.dart';


class MainController extends GetxController {
  RxInt currentPage = 0.obs;

  PageController pageController = PageController();

  List<Widget> pages = [
    const HomeScreen(),
    const DiscoverScreen(),
    const WishListScreen(),
    const ProfileScreen(),
  ];

  List<String> titles = [
    'Shoppy',
    'Discover',
    'Wish List',
    'Profile',
  ];

  changePage(newPage) {
    currentPage.value = newPage;
  }
}
