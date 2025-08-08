import 'package:flutter/material.dart';
import 'package:porfolio/screens/largescreen/desktop_layout_page.dart';
import 'package:porfolio/screens/mobile/mobile_layout_page.dart';
import 'package:porfolio/screens/tablet/tablet_layout_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1000) {
      return const DesktopLayout();
    } else if (width >= 760 && width < 1000) {
      return const TabletLayout();
    } else {
      return const MobileLayout();
    }
  }
}
