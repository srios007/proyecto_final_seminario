import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto_final_seminario/app/services/services.dart';
import 'package:proyecto_final_seminario/app/utils/utils.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  // await PushNotificationService.initNotifications();
  // await constantsService.getConstants();
  // initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final box = GetStorage();
  String? _setInitialRoute() {
    var firebaseUser = auth.getCurrentUser();
    if (firebaseUser != null) {
      return Routes.HOME;
    } else if (box.read("isTourShowed") ?? false) {
      return Routes.TOUR;
      return Routes.LOGIN;
    } else {
      return Routes.TOUR;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      title: "Application",
      initialRoute: _setInitialRoute(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Palette.purple,
          iconTheme: IconThemeData(color: Palette.darkBlue),
          elevation: 0,
        ),
      ),
    );
  }
}
