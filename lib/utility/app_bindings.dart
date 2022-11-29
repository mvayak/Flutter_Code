import 'package:get/get.dart';

import '../controller/api_controller.dart';
import '../controller/common_controller.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(CommonController(), permanent: true);
    Get.put(ApiController(), permanent: true);
  }
}
