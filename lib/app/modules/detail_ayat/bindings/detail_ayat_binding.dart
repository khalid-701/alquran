import 'package:get/get.dart';

import '../controllers/detail_ayat_controller.dart';

class DetailAyatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailAyatController>(
      () => DetailAyatController(),
    );
  }
}
