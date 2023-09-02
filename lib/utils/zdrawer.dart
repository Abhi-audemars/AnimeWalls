import 'package:demo1/utils/menu_screen.dart';
import 'package:demo1/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ZDrawer extends StatelessWidget {
  const ZDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuBackgroundColor: Colors.purple.shade100,
      style: DrawerStyle.style3,
      angle: -1.0,
      // openCurve: Curves.fastEaseInToSlowEaseOut,
      isRtl: true,
      slideWidth: 260,
      borderRadius: 24.0,
      mainScreenScale: 0.01,
      mainScreenTapClose: true,
      showShadow: true,
      // drawerShadowsBackgroundColor: const Color.fromARGB(255, 147, 124, 147),
      duration: const Duration(seconds: 1),
      mainScreen: const HomeScreen(),
      menuScreen: const MenuScreen(),
    );
  }
}
