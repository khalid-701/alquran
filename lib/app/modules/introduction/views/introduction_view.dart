import 'package:alquran/app/cosntants/color_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';
import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Al-Quran App",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Sesibuk itukah kamu sampai tidak membacaku ?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16,),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              width: 250,
              height: 250,
              child: Lottie.asset("assets/lottie/quran2.json")),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                Get.offAllNamed(Routes.HOME);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Get.isDarkMode ? appDarkColor : appLightColor),
              child: const Text("MULAI")),
        ],
      )),
    );
  }
}
