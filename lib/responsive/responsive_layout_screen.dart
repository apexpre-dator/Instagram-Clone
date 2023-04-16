import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenlayout, mobileScreenLayout;
  const ResponsiveLayout(
      {Key? key,
      required this.webScreenlayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          return webScreenlayout;
        }
        return mobileScreenLayout;
      },
    );
  }
}
