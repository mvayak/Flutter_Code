import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marlo/utility/app_bindings.dart';
import 'package:marlo/utility/colors.dart';
import 'package:marlo/utility/themes.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'controller/common_controller.dart';
import 'screens/home_screen.dart';

final GetStorage getPreference = GetStorage();

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(child,
          maxWidth: 1200,
          minWidth: 380,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(380, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: colorFFFFFF)),
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      home: const HomeScreen(),
    );
  }
}