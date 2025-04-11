
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

// import 'package:shared_preferences/shared_preferences.dart';

import 'core/http/dio_client.dart';
import 'core/notification_service/notifcation_service.dart';
import 'core/theme/theme.dart';
import 'core/theme/widget_themes/text_theme.dart';
import 'features/appointment/data/repositories/appointment_repository.dart';
import 'features/appointment/presentation/manager/appointment_cubit.dart';


final get_it = GetIt.instance;
var uuid = Uuid();

Future<void> initAppModule() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TDioHelper.init();
  // final prefs = await SharedPreferences.getInstance();
  // sl.registerLazySingleton<SharedPreferences>(() => prefs);
  get_it.registerLazySingleton<AppTextTheme>(() => AppTextTheme());
  get_it.registerLazySingleton<ThemeProvider>(() => ThemeProvider());
  get_it.registerLazySingleton<NotificationService>(() => NotificationService());
  get_it.registerLazySingleton<AppointmentRepository>(() => AppointmentRepository());
  get_it.registerFactory<AppointmentCubit>(() => AppointmentCubit(get_it()));


}

