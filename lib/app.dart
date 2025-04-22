
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/constants/sizes.dart';
import 'core/constants/text_strings.dart';
import 'core/theme/theme.dart';
import 'features/0-intro/presentation/pages/SplashScreen.dart';

class Get {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;
  static NavigatorState get navigator => navigatorKey.currentState!;
}

late final TextTheme appTextTheme;

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          // BlocProvider(create: (context) => LoginCubit( )),
          //     BlocProvider(create: (context) => HomeBloc()),
        ],
        child: Consumer<ThemeProvider>(builder: (context, them, c) {
          // final isDark =  them.getThemeModeIsDark();
          TSizes.init(context: context);
          ScreenUtil.init(context);
          // AppTextTheme.init(context,isDark);
final isWeb =MediaQuery.of(context).size.width > 800;

          return ScreenUtilInit(
              designSize: Size(
                isWeb ? 1920 : 430,


                932,
                // 932,
              ),
              minTextAdapt: true,
              splitScreenMode: true,
              useInheritedMediaQuery: true,
              ensureScreenSize: true,
              builder: (_, child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: TextScaler.linear(1.0)),
                  child: MaterialApp(
                      builder: (context, w) {
                        return w!;
                      },
                      debugShowCheckedModeBanner: false,
                      supportedLocales: context.supportedLocales,
                      localizationsDelegates: context.localizationDelegates,
                      navigatorKey: Get.navigatorKey,
                      locale: context.locale,
                      title: TTexts.appName,
                      theme: AppTheme.lightTheme,
                      home: child),
                );
              },
              child: SplashScreen());
        }));
  }
}
