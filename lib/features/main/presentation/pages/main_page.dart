
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_codebase_clean/features/main/presentation/bloc/main_cubit.dart';
import 'package:flutter_codebase_clean/injection_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final PersistentTabController _controller = PersistentTabController();
  late MainCubit _cubit;

  @override
  void initState() {
    _cubit = getIt<MainCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: _cubit,
        child: BlocConsumer<MainCubit, MainState>(
          listener: (context, state) {},
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: PersistentTabView(
                controller: _controller,
                backgroundColor: Colors.transparent,
                navBarHeight: 62.5,
                tabs: _navBarsItems(),
                navBarBuilder: (navBarConfig) => Style3BottomNavBar(
                  navBarDecoration: NavBarDecoration(
                    padding: EdgeInsets.only(bottom: 8.h),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(16.r), topLeft: Radius.circular(16.r)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0C000000),
                        blurRadius: 8,
                        offset: Offset(0, -4),
                      )
                    ],
                  ),
                  navBarConfig: navBarConfig,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<PersistentTabConfig> _navBarsItems() {
    const Color activeColor = Colors.black;
    const Color inactiveColor = Colors.white24;
    return [
      PersistentTabConfig(
        screen: const Center(
          child: Text(
            'Coming soon',
          ),
        ),
        item: ItemConfig(
            icon: const Icon(Icons.home),
            inactiveIcon:  const Icon(Icons.home),
            activeForegroundColor: activeColor,
            inactiveForegroundColor: inactiveColor,
            title: "Home",
           ),
      ),
      PersistentTabConfig(
        screen: const Center(
          child: Text(
            'Coming soon',
          ),
        ),
        item: ItemConfig(
          icon: const Icon(Icons.person),
          inactiveIcon:  const Icon(Icons.person),
          activeForegroundColor: activeColor,
          inactiveForegroundColor: inactiveColor,
          title: "Profile",
        ),
      ),
    ];
  }
}
