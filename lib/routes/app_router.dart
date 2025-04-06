import 'package:meditech/routes/pages.dart';
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import '../features/0-intro/presentation/Introductory_screen.dart';

Route onGenerateRoute(RouteSettings routeSettings) {
  print("onGenerateRoute >>>>>>>>>>>>>>");
  print(routeSettings.name);
  switch (routeSettings.name) {
    case Pages.initial:
      return PageRouteBuilder(
        settings: routeSettings,
        pageBuilder: (_, __, ___) => const IntroductoryScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      );

    // case Pages.loginScreen:
    //   return PageRouteBuilder(
    //     settings: routeSettings,
    //     pageBuilder: (_, __, ___) => BlocProvider(
    //       create: (context) => getIt<LoginCubit>(),
    //       child: const LoginScreen(),
    //     ),
    //     transitionsBuilder: (_, animation, __, child) {
    //       return SlideTransition(
    //         position: Tween<Offset>(
    //           begin: const Offset(-1.0, 0.0),
    //           end: Offset.zero,
    //         ).animate(animation),
    //         child: child,
    //       );
    //     },
    //   );




    default:
      return PageRouteBuilder(
        settings: routeSettings,
        pageBuilder: (_, __, ___) => const PageNotFound(),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      );
  }
}



class PageNotFound extends StatefulWidget {
  const PageNotFound({super.key});

  @override
  State<PageNotFound> createState() => _PageNotFoundState();
}

class _PageNotFoundState extends State<PageNotFound> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  AppColors.white,
        body: Center(child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Page not found',
                style: TextStyle(fontSize: 32)),
            const SizedBox(height: 10,),
            Text(
                'Something went wrong',
              style: TextStyle(fontSize:18)),
          ],)));
  }
}
