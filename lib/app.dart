import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_codebase_clean/core/common/bases/enum/auth_status.dart';
import 'package:flutter_codebase_clean/core/constants/constants.dart';
import 'package:flutter_codebase_clean/core/routes/app_navigator_observer.dart';
import 'package:flutter_codebase_clean/core/routes/app_routes.dart';
import 'package:flutter_codebase_clean/core/routes/routes.dart';
import 'package:flutter_codebase_clean/core/utils/navigation_utils.dart';
import 'package:flutter_codebase_clean/features/app/presentation/bloc/app_cubit.dart';
import 'package:flutter_codebase_clean/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter_codebase_clean/flavors.dart';
import 'package:flutter_codebase_clean/injection_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  late AppCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AppCubit>();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authCubit.openApp();
      context.setLocale(const Locale('vi'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _authCubit,
      child: OverlaySupport.global(
        child: ScreenUtilInit(
          designSize: Size(Consts.screenWidth, Consts.screenHeight),
          builder: (context, child) => RefreshConfiguration(
            headerBuilder: () => const MaterialClassicHeader(
              backgroundColor: Colors.blueAccent,
              color: Colors.white,
            ),
            footerBuilder: () => const ClassicFooter(),
            child: MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              navigatorObservers: [
                getIt<AppNavigatorObserver>(),
              ],
              title: F.title,
              onGenerateRoute: Routes.generateRoute,
              theme: ThemeData(colorScheme: ColorScheme.fromSwatch(backgroundColor: Colors.white60)),
              builder: (context, widget) {
                return BlocListener<AppCubit, AppState>(
                  listenWhen: (previous, current) => previous.authStatus != current.authStatus,
                  listener: (context, state) {
                    if (state.authStatus == AuthStatus.unauthenticated) {
                      NavigationUtils.pushAndRemoveUtilPage(context, AppRoutes.login, rootNavigator: true);
                    } else if (state.authStatus == AuthStatus.authenticated) {
                      NavigationUtils.pushAndRemoveUtilPage(context, AppRoutes.main, rootNavigator: true);
                    }
                  },
                  child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)), child: widget!),
                );
              },
              home: child,
            ),
          ),
          child: const SplashPage(),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
}
