import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';
import 'core/notification_service/notifcation_service.dart';
import 'di.dart';
import 'features/1-login/presentation/manager/login_cubit.dart';



import 'firebase_options.dart';

// void main() {
//   runApp(MyApp());
// }



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().initialize();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();

  await initAppModule();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,

      statusBarColor: Colors.transparent, // Makes the status bar transparent
      statusBarIconBrightness: Brightness.dark, // Adjusts icon brightness (light for dark backgrounds)
    ),
  );

  runApp(
    EasyLocalization(
      supportedLocales: [ const Locale('ar', 'EG')],
      path: 'assets/tr', // <-- change the path of the translation files
      fallbackLocale: const Locale('ar', 'EG'),

      child: DevicePreview(
        enabled: false,
        builder: (context) =>     MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => AuthCubit()),
          ],
          child: App(),
        ),// Wrap your app
      ),
    ),
  );
}

