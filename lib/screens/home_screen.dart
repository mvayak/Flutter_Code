import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/api_controller.dart';
import '../controller/common_controller.dart';
import '../utility/common_widget.dart';
import 'first_project_screen/dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      CommonController.to.getThemeStatus();
      _getData();
    });
  }
  _getData() async {
    await ApiController.to.getTokenAPI((){});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: commonAppBar(actions: [
        ObxValue(
          (data) => Switch(
            value: CommonController.to.isLightTheme.value,
            onChanged: (val) {
              CommonController.to.isLightTheme.value = val;
              Get.changeThemeMode(
                CommonController.to.isLightTheme.value ? ThemeMode.light : ThemeMode.dark,
              );
              CommonController.to.saveThemeStatus();
            },
          ),
          false.obs,
        ),
      ]),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              commonFillButtonView(
                  context: context,
                  tapOnButton: () {
                    Get.to(() => const DashboardScreen(),transition: Transition.noTransition);
                  },
                  isLoading: false,
                  title: 'Project 1'),
              const SizedBox(height: 25),
              commonFillButtonView(context: context, tapOnButton: () {}, isLoading: false, title: 'Project 2'),
            ],
          ),
        ),
      ),
    );
  }
}
