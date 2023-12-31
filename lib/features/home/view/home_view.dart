import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soundtt/constants/constants.dart';
import 'package:soundtt/features/wave/views/create_wave_view.dart';
import 'package:soundtt/theme/pallete.dart';

class HomeView extends StatefulWidget {
    static route() => MaterialPageRoute(
        builder: (context) => const HomeView(),
      );
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;
  final appBar = UIConstants.appBar();

void onPageChange(int index) {
  setState(() {
    _page = index;
  });
}

onCreateWave() {
  Navigator.push(context, CreateWaveScreen.route());
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: IndexedStack(
        index: _page,
        children: UIConstants.bottomTabBarPages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreateWave,
        child: const Icon(
          Icons.add,
          size: 28,
          
          ),
        ),
     bottomNavigationBar: CupertinoTabBar(
      currentIndex: _page,
      onTap: onPageChange,
      backgroundColor: Pallete.backgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
             _page == 0
             ? AssetsConstants.homeFilledIcon
             : AssetsConstants.homeOutlinedIcon,
              color: Pallete.whiteColor,
              ),
              ),
                 BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsConstants.searchIcon,
              color: Pallete.whiteColor,

              ),
              ),
                               BottomNavigationBarItem(
            icon: SvgPicture.asset(
               _page == 2
              ? AssetsConstants.notifFilledIcon
              : AssetsConstants.notifOutlinedIcon,
              color: Pallete.whiteColor,

              ),
              ),
        ]),
    );
  }
}

