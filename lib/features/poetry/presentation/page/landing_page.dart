import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:poets_paradise/cores/palette/app_palette.dart';
import 'package:poets_paradise/features/poetry/presentation/page/add/add_page.dart';
import 'package:poets_paradise/features/poetry/presentation/page/home/home_page.dart';
import 'package:poets_paradise/features/poetry/presentation/page/like/likes_page.dart';
import 'package:poets_paradise/features/poetry/presentation/page/save/save_page.dart';

class LandingPage extends StatelessWidget {
  final controller = PersistentTabController(initialIndex: 0);
  LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screensList() {
      return [
        const HomePage(),
        const LikesPage(),
        const AddPage(),
        const SavePage(),
        const SavePage(),
      ];
    }

    List<PersistentBottomNavBarItem> navBarItem = [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        activeColorPrimary: AppPallete.purpleColor,
        inactiveColorPrimary: AppPallete.greyColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.heart_fill),
        activeColorPrimary: AppPallete.purpleColor,
        inactiveColorPrimary: AppPallete.greyColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.add,
          color: AppPallete.whiteColor,
        ),
        activeColorPrimary: AppPallete.purpleColor,
        inactiveColorPrimary: AppPallete.greyColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.notification_add),
        activeColorPrimary: AppPallete.purpleColor,
        inactiveColorPrimary: AppPallete.greyColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.bookmark),
        activeColorPrimary: AppPallete.purpleColor,
        inactiveColorPrimary: AppPallete.greyColor,
      ),
    ];
    return PersistentTabView(
      context,
      screens: screensList(),
      items: navBarItem,
      navBarStyle: NavBarStyle.style15,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(1),
        colorBehindNavBar: AppPallete.backgroundColor,
      ),
    );
  }
}
