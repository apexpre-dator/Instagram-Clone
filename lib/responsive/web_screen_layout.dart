import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTap(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  void pageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () => navigationTap(0),
            icon: Icon(
              Icons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () => navigationTap(1),
            icon: Icon(
              Icons.search,
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () => navigationTap(2),
            icon: Icon(
              Icons.add_a_photo,
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () => navigationTap(3),
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () => navigationTap(4),
            icon: Icon(
              Icons.person,
              color: _page == 4 ? primaryColor : secondaryColor,
            ),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.messenger_outline),
          // ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: pageChanged,
        children: homeScreenItems,
      ),
    );
  }
}
