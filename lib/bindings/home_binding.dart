import 'package:ai_joke/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../services/joke_service.dart';

class HomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<JokeService>(() => JokeService());
    Get.lazyPut<HomeController>(() => HomeController(Get.find<JokeService>()));
  }

}